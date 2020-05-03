

#ifndef MDDOPCUASERVER_H_
#define MDDOPCUASERVER_H_

#if !defined(ITI_COMP_SIM)

#include "ModelicaUtilities.h"
#include "MDDSerialPackager.h"

#if defined(_MSC_VER) || defined(__MINGW32__)

#include <winsock2.h>
#include "../src/include/CompatibilityDefs.h"
#include "../src/open62541Wrapper/open62541Wrapper.h"

#pragma comment( lib, "Ws2_32.lib" )

typedef struct MDDopcuaServer_s MDDopcuaServer;

struct MDDopcuaServer_s {
    SOCKET SocketID;
	HANDLE hThread;
	void* server;
	unsigned char running;
    CRITICAL_SECTION receiveLock;
};

DWORD WINAPI MDD_OPCUAServerThread(LPVOID p_opcua) {
	int r;
    MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	r = startOPCUAserver(opcua->server);
	ModelicaFormatMessage("MDDopcuaServer.h: Started OPC UA server %d\n",r);	
    return 0;
}

DllExport void * MDD_opcuaServerConstructor() 
{
    int rc; /* Error variable */
    WSADATA wsa;
    SOCKADDR_IN addr;
    DWORD id1;
    MDDopcuaServer * opcua;
 
    rc = WSAStartup(MAKEWORD(2,2),&wsa);
    if (rc != NO_ERROR) {
        ModelicaFormatError("MDDopcuaServer.h: WSAStartup failed with error code: %d\n", rc);
        return NULL;
    }

    opcua = (MDDopcuaServer *)calloc(sizeof(MDDopcuaServer), 1);
	opcua->server = createOPCUAserver();
	ModelicaFormatMessage("MDDopcuaServer.h: Created OPC UAserver \n");
	
	InitializeCriticalSection(&opcua->receiveLock);
	opcua->hThread = CreateThread(0, 1024, MDD_OPCUAServerThread, opcua, 0, &id1);
	if (!opcua->hThread) {
		DWORD dw = GetLastError();
		deleteOPCUAserver(opcua->server);
		DeleteCriticalSection(&opcua->receiveLock);
		free(opcua);
		opcua = NULL;
		WSACleanup();
		ModelicaFormatError("MDDopcuaServer.h: Error creating opc ua thread: %lu\n", dw);
	}
    return (void *) opcua;
}

DllExport void MDD_opcuaServerDestructor(void * p_opcua) 
{
    MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;

    if (opcua) {
        deleteOPCUAserver(opcua->server);
		ModelicaMessage("MDDopcuaServer.h: Delete OPC UA Server.\n");
        if (opcua->hThread) {
            DWORD dwEc = 1;

            if (GetExitCodeThread(opcua->hThread, &dwEc) && dwEc == STILL_ACTIVE) 
			{
                TerminateThread(opcua->hThread, 1);
				ModelicaMessage("MDDopcuaServer.h: Close Thread.\n");
            }
            CloseHandle(opcua->hThread);
            DeleteCriticalSection(&opcua->receiveLock);
        }
        free(opcua);
    }
    WSACleanup();
}

DllExport void MDD_opcuaAddIntVar(void* p_opcua, char* nodeName, int value)
{
	MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	addIntVariable(opcua->server, nodeName, value);
}

DllExport void MDD_opcuaWriteIntVar(void* p_opcua, char* nodeName, int value)
{
	MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	//ModelicaFormatMessage("MDDopcuaServer.h: Write %s to %d.\n",nodeName, value);
	writeIntVariable(opcua->server, nodeName, value);
}

DllExport void MDD_opcuaAddRealVar(void* p_opcua, char* nodeName, double value)
{
	MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	addDoubleVariable(opcua->server, nodeName, value);
}

DllExport void MDD_opcuaWriteRealVar(void* p_opcua, char* nodeName, double value)
{
	MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	//ModelicaFormatMessage("MDDopcuaServer.h: Write %s to %d.\n",nodeName, value);
	writeDoubleVariable(opcua->server, nodeName, value);
}

#else

#error "Modelica_DeviceDrivers: No support of OPC UA for your platform"

#endif /* defined(_MSC_VER) */

#endif /* !defined(ITI_COMP_SIM) */

#endif /* MDDOPCUASERVER_H_ */
