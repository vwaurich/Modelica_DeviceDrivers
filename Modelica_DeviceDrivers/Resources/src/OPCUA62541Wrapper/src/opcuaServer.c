#include "OPCUA62541Wrapper.h"


static volatile UA_Boolean running = true;
static void stopHandler(int sig) {
	UA_LOG_INFO(UA_Log_Stdout, UA_LOGCATEGORY_USERLAND, "received ctrl-c");
	running = false;
}

void* createOPCUAserver()
{
	UA_Server *server = UA_Server_new();
	UA_ServerConfig_setDefault(UA_Server_getConfig(server));
	return server;
}

int startOPCUAserver(void* opcua)
{
	//UA_Server *server = (UA_Server*)opcua;
	//UA_Boolean run = (UA_Boolean) running;
	//UA_StatusCode retval = UA_Server_run(server, run);

	signal(SIGINT, stopHandler);
	signal(SIGTERM, stopHandler);

	UA_Server *server = UA_Server_new();
	UA_ServerConfig_setDefault(UA_Server_getConfig(server));

	UA_StatusCode retval = UA_Server_run(server, &running);

	UA_Server_delete(server);


	return 4;
}

void deleteOPCUAserver(void* opcua)
{
	UA_Server *server = (UA_Server*)opcua;
	UA_Boolean* run = (UA_Boolean*)running;
	run = false;
	UA_Server_delete(server);
}

