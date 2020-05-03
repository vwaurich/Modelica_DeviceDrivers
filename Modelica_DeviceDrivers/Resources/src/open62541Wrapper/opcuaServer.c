#include "open62541Wrapper.h"
#include "winsock2.h"

static volatile UA_Boolean running = true;
static volatile UA_StatusCode status = 0;

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
	UA_Server *server = (UA_Server*)opcua;
	UA_StatusCode retval = UA_Server_run(server, &running);
	UA_Server_delete(server);
	return retval;
}

void deleteOPCUAserver(void* opcua)
{
	UA_Server *server = (UA_Server*)opcua;
	running = false;
	//UA_Server_delete(server);  // sometimes, this makes the pocess crash
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

void addDoubleVariable(void * opcua, char * name, double value)
{
	UA_Server *server = (UA_Server*)opcua;

	/* Define the attribute of the int variable node */
	UA_VariableAttributes attr = UA_VariableAttributes_default;
	UA_Double myDouble = value;
	UA_Variant_setScalar(&attr.value, &myDouble, &UA_TYPES[UA_TYPES_DOUBLE]);
	attr.description = UA_LOCALIZEDTEXT("en-US", name);
	attr.displayName = UA_LOCALIZEDTEXT("en-US", name);
	attr.dataType = UA_TYPES[UA_TYPES_DOUBLE].typeId;
	attr.accessLevel = UA_ACCESSLEVELMASK_READ | UA_ACCESSLEVELMASK_WRITE;

	/* Add the variable node to the information model */
	UA_NodeId myDoubleNodeId = UA_NODEID_STRING(1, name);
	UA_QualifiedName myDoubleName = UA_QUALIFIEDNAME(1, name);
	UA_NodeId parentNodeId = UA_NODEID_NUMERIC(0, UA_NS0ID_OBJECTSFOLDER);
	UA_NodeId parentReferenceNodeId = UA_NODEID_NUMERIC(0, UA_NS0ID_ORGANIZES);
	UA_Server_addVariableNode(server, myDoubleNodeId, parentNodeId,
		parentReferenceNodeId, myDoubleName,
		UA_NODEID_NUMERIC(0, UA_NS0ID_BASEDATAVARIABLETYPE), attr, NULL, NULL);
}

void writeIntVariable(void * opcua, char * name, int value)
{
	UA_Server *server = (UA_Server*)opcua;

	UA_NodeId myIntegerNodeId = UA_NODEID_STRING(1, name);

	/* Write a different integer value */
	UA_Int32 myInteger = value;
	UA_Variant myVar;
	UA_Variant_init(&myVar);
	UA_Variant_setScalar(&myVar, &myInteger, &UA_TYPES[UA_TYPES_INT32]);
	UA_Server_writeValue(server, myIntegerNodeId, myVar);

	///* Set the status code of the value to an error code. The function
	//* UA_Server_write provides access to the raw service. The above
	//* UA_Server_writeValue is syntactic sugar for writing a specific node
	//* attribute with the write service. */
	//UA_WriteValue wv;
	//UA_WriteValue_init(&wv);
	//wv.nodeId = myIntegerNodeId;
	//wv.attributeId = UA_ATTRIBUTEID_VALUE;
	//wv.value.status = UA_STATUSCODE_BADNOTCONNECTED;
	//wv.value.hasStatus = true;
	//UA_Server_write(server, &wv);
	//
	///* Reset the variable to a good statuscode with a value */
	//wv.value.hasStatus = false;
	//wv.value.value = myVar;
	//wv.value.hasValue = true;
	//UA_Server_write(server, &wv);
}

void writeDoubleVariable(void * opcua, char * name, double value)
{
	UA_Server *server = (UA_Server*)opcua;

	UA_NodeId myDoubleNodeId = UA_NODEID_STRING(1, name);

	/* Write a different integer value */
	UA_Double myDouble = value;
	UA_Variant myVar;
	UA_Variant_init(&myVar);
	UA_Variant_setScalar(&myVar, &myDouble, &UA_TYPES[UA_TYPES_DOUBLE]);
	UA_StatusCode sc = UA_Server_writeValue(server, myDoubleNodeId, myVar);
}
