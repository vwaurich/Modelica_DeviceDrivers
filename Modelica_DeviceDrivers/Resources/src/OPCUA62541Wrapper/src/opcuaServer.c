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

	addIntVariable(server, "test", 123);

	return server;
}

int startOPCUAserver(void* opcua)
{
	UA_Server *server = (UA_Server*)opcua;
	UA_StatusCode retval = UA_Server_run(server, &running);
	UA_Server_delete(server);
	return retval;
}

void deleteOPCUAserver(void* opcua)
{
	UA_Server *server = (UA_Server*)opcua;
	running = false;
	UA_Server_delete(server);
}

void addIntVariable(void * opcua,  char * name, int value)
{
	UA_Server *server = (UA_Server*)opcua;

	/* Define the attribute of the int variable node */
	UA_VariableAttributes attr = UA_VariableAttributes_default;
	UA_Int32 myInteger = value;
	UA_Variant_setScalar(&attr.value, &myInteger, &UA_TYPES[UA_TYPES_INT32]);
	attr.description = UA_LOCALIZEDTEXT("en-US", name);
	attr.displayName = UA_LOCALIZEDTEXT("en-US", name);
	attr.dataType = UA_TYPES[UA_TYPES_INT32].typeId;
	attr.accessLevel = UA_ACCESSLEVELMASK_READ | UA_ACCESSLEVELMASK_WRITE;


	/* Add the variable node to the information model */
	
	UA_NodeId myIntegerNodeId = UA_NODEID_STRING(1, name);
	UA_QualifiedName myIntegerName = UA_QUALIFIEDNAME(1, name);
	UA_NodeId parentNodeId = UA_NODEID_NUMERIC(0, UA_NS0ID_OBJECTSFOLDER);
	UA_NodeId parentReferenceNodeId = UA_NODEID_NUMERIC(0, UA_NS0ID_ORGANIZES);
	UA_Server_addVariableNode(server, myIntegerNodeId, parentNodeId,
		parentReferenceNodeId, myIntegerName,
		UA_NODEID_NUMERIC(0, UA_NS0ID_BASEDATAVARIABLETYPE), attr, NULL, NULL);
}

