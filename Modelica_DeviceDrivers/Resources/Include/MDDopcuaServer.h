/** Serial port driver support (header-only library).
 *
 * @file
 * @author vwaurich
 * @since 2019-07-11
 * @copyright see Modelica_DeviceDrivers project's License.txt file
 *
 */

#ifndef MDDOPCUASERVER_H_
#define MDDOPCUASERVER_H_

#include "../thirdParty/open62541/open62541.h"
#include "ModelicaUtilities.h"

#if !defined(WIN32_LEAN_AND_MEAN)
#define WIN32_LEAN_AND_MEAN
#endif
#include <windows.h>
#include "../src/include/CompatibilityDefs.h"



static volatile UA_Boolean running = true;

typedef struct{
  HANDLE hThread;
  CRITICAL_SECTION receiveLock;

  UA_Server* server;
  UA_Boolean running;
} MDDopcuaServer;


DWORD WINAPI MDD_OPCUAServerThread(LPVOID p_opcua) {
    MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	ModelicaFormatMessage("Create server\n");
	UA_StatusCode retval = UA_Server_run(opcua->server, &opcua->running);

    return 0;
}



void* MDD_opcuaServerConstructor()
{
	    ModelicaFormatMessage("Create server\n");
		MDDopcuaServer* opcua = (MDDopcuaServer*) calloc(sizeof(MDDopcuaServer), 1);

		// init open62541 opc ua server
		opcua->server = UA_Server_new();
		opcua->running = true;
		UA_ServerConfig_setDefault(UA_Server_getConfig(opcua->server));	
        
		//start main loop in a separate thread
		DWORD id1;
		InitializeCriticalSection(&opcua->receiveLock);
        opcua->hThread = CreateThread(0, 0, MDD_OPCUAServerThread, opcua, 0, &id1);
		if (!opcua->hThread) {
                DeleteCriticalSection(&opcua->receiveLock);
				opcua->running = false;
				UA_Server_delete(opcua->server);
                free(opcua);
                opcua = NULL;
                ModelicaError("MDDOPCUA_Server.h: Error creating thread for main loop.\n");
            }
		ModelicaFormatMessage("Server Created\n");
	return (void*)opcua;
}

void MDD_opcuaServerDestructor(void* p_opcua)
{
	MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	opcua->running = false;
	UA_Server_delete(opcua->server);
	if (opcua->hThread) {
		DWORD dwEc = 1;
		WaitForSingleObject(opcua->hThread, 1000);
		if (GetExitCodeThread(opcua->hThread, &dwEc) && dwEc == STILL_ACTIVE) {
			TerminateThread(opcua->hThread, 1);
		}
		CloseHandle(opcua->hThread);
		DeleteCriticalSection(&opcua->receiveLock);
	}
	ModelicaFormatMessage("Destroy server\n");
}


#endif /* MDDSERIALPORT_H_ */
