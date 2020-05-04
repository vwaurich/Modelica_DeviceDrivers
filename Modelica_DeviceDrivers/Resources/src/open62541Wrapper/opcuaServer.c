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
	return retval;
}

void deleteOPCUAserver(void* opcua)
{
	UA_Server *server = (UA_Server*)opcua;
	running = false;
	UA_Server_delete(server);  // sometimes, this makes the process crash
}

void addIntVariable(void * opcua,  char * name, int nodeNsIdx, int intNodeId, int parentNsIdx, int intParentNodeId, int value)
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
	UA_NodeId IntegerNodeId = UA_NODEID_NUMERIC(nodeNsIdx, intNodeId);
	UA_QualifiedName myIntegerName = UA_QUALIFIEDNAME(intNodeId, name);
	//UA_NodeId parentNodeId = UA_NODEID_NUMERIC(0, UA_NS0ID_OBJECTSFOLDER);
	UA_NodeId parentNodeId = UA_NODEID_NUMERIC(parentNsIdx, intParentNodeId);
	UA_NodeId parentReferenceNodeId = UA_NODEID_NUMERIC(0, UA_NS0ID_ORGANIZES);
	UA_Server_addVariableNode(server, IntegerNodeId, parentNodeId,
		parentReferenceNodeId, myIntegerName,
		UA_NODEID_NUMERIC(0, UA_NS0ID_BASEDATAVARIABLETYPE), attr, NULL, NULL);
}

void writeIntVariable(void * opcua, char * name, int nodeNsIdx, int intNodeId, int value)
{
	UA_Server *server = (UA_Server*)opcua;

	UA_NodeId IntegerNodeId = UA_NODEID_NUMERIC (nodeNsIdx, intNodeId);

	/* Write a different integer value */
	UA_Int32 myInteger = value;
	UA_Variant myVar;
	UA_Variant_init(&myVar);
	UA_Variant_setScalar(&myVar, &myInteger, &UA_TYPES[UA_TYPES_INT32]);
	UA_Server_writeValue(server, IntegerNodeId, myVar);
}

void addDoubleVariable(void * opcua, char * name, int nodeNsIdx, int intNodeId, int parentNsIdx, int intParentNodeId, double value)
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
	//UA_NodeId myDoubleNodeId = UA_NODEID_STRING(1, name);
	UA_NodeId doubleNodeId = UA_NODEID_NUMERIC(nodeNsIdx, intNodeId);
	UA_QualifiedName myDoubleName = UA_QUALIFIEDNAME(1, name);
	//UA_NodeId parentNodeId = UA_NODEID_NUMERIC(0, UA_NS0ID_OBJECTSFOLDER);
	UA_NodeId parentNodeId = UA_NODEID_NUMERIC(parentNsIdx, intParentNodeId);
	UA_NodeId parentReferenceNodeId = UA_NODEID_NUMERIC(0, UA_NS0ID_ORGANIZES);
	UA_Server_addVariableNode(server, doubleNodeId, parentNodeId,
		parentReferenceNodeId, myDoubleName,
		UA_NODEID_NUMERIC(0, UA_NS0ID_BASEDATAVARIABLETYPE), attr, NULL, NULL);
}


void writeDoubleVariable(void * opcua, char * name, int nodeNsIdx, int intNodeId, double value)
{
	UA_Server *server = (UA_Server*)opcua;

	//UA_NodeId myDoubleNodeId = UA_NODEID_STRING(1, name);
	UA_NodeId doubleNodeId = UA_NODEID_NUMERIC(nodeNsIdx, intNodeId);

	/* Write a different integer value */
	UA_Double myDouble = value;
	UA_Variant myVar;
	UA_Variant_init(&myVar);
	UA_Variant_setScalar(&myVar, &myDouble, &UA_TYPES[UA_TYPES_DOUBLE]);
	UA_StatusCode sc = UA_Server_writeValue(server, doubleNodeId, myVar);
}

void addObject(void * opcua, char* name, int nodeNsIdx, int intNodeId, int parentNsIdx, int intParentNodeId) {
	UA_Server *server = (UA_Server*)opcua;

	UA_NodeId objNodeId = UA_NODEID_NUMERIC(nodeNsIdx, intNodeId);
	UA_NodeId parentNodeId = UA_NODEID_NUMERIC(parentNsIdx, intParentNodeId);

	UA_ObjectAttributes oAttr = UA_ObjectAttributes_default;
	oAttr.displayName = UA_LOCALIZEDTEXT("en-US", name);
	UA_Server_addObjectNode(server, objNodeId,
		parentNodeId,
		UA_NODEID_NUMERIC(0, UA_NS0ID_ORGANIZES),
		UA_QUALIFIEDNAME(nodeNsIdx, name),
		UA_NODEID_NUMERIC(0, UA_NS0ID_BASEOBJECTTYPE),
		oAttr, NULL, &objNodeId);
}

