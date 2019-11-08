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

static volatile UA_Boolean running = true;

typedef struct{
  UA_Server* server;
  UA_Boolean running;
} MDDopcuaServer;

void* MDD_opcuaServerConstructor()
{
	    ModelicaFormatMessage("Create server\n");
		MDDopcuaServer* opcua = (MDDopcuaServer*) calloc(sizeof(MDDopcuaServer), 1);

		opcua->server = UA_Server_new();
		opcua->running = true;
		UA_ServerConfig_setDefault(UA_Server_getConfig(opcua->server));	

		UA_StatusCode retval = UA_Server_run(opcua->server, &opcua->running);

		ModelicaFormatMessage("Server Created\n");
	return NULL;
}

void MDD_opcuaServerDestructor(void* p_opcuaServer)
{
	//UA_Server_destroy(server);
	ModelicaFormatMessage("Destroy server\n");
}


#endif /* MDDSERIALPORT_H_ */
