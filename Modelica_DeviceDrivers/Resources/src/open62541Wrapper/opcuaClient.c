#include "open62541Wrapper.h"
#include "winsock2.h"

void* createOPCUAclient()
{
	UA_Client *client = UA_Client_new();
	UA_ClientConfig_setDefault(UA_Client_getConfig(client));
	
	return client;
}

int startOPCUAclient(void* client_vp, char* endpointURL)
{
	//UA_StatusCode retval = UA_Client_connect(client, "opc.tcp://localhost:4840");
	UA_Client *client = (UA_Client*)client_vp;
	UA_StatusCode retval = UA_Client_connect(client, endpointURL);
	if (retval != UA_STATUSCODE_GOOD) {
		UA_Client_delete(client);
	}
	return retval;
}

void deleteOPCUAclient(void* client_vp)
{
	UA_Client *client = (UA_Client*)client_vp;
	UA_Client_delete(client_vp);
}

int readIntValue(void* client_vp, int nodeNsIdx, int intNodeId)
{
	int ret = 0;
	UA_Client *client = (UA_Client*)client_vp;

	UA_Variant value; /* Variants can hold scalar values and arrays of any type */
	UA_Variant_init(&value);

	/* NodeId of the variable holding the current time */
	UA_NodeId nodeId = UA_NODEID_NUMERIC(nodeNsIdx, intNodeId);
	UA_StatusCode retval = UA_Client_readValueAttribute(client, nodeId, &value);	
	//
	if (retval == UA_STATUSCODE_GOOD && UA_Variant_hasScalarType(&value, &UA_TYPES[UA_TYPES_INT32])) 
	{
		UA_Int32 intData = *(UA_Int32 *)value.data;
		ret = (int)intData;
	}
	return ret;
}

double readDoubleValue(void* client_vp, int nodeNsIdx, int intNodeId)
{
	double ret = 0.0;
	UA_Client *client = (UA_Client*)client_vp;

	UA_Variant value; /* Variants can hold scalar values and arrays of any type */
	UA_Variant_init(&value);

	/* NodeId of the variable holding the current time */
	UA_NodeId nodeId = UA_NODEID_NUMERIC(nodeNsIdx, intNodeId);
	UA_StatusCode retval = UA_Client_readValueAttribute(client, nodeId, &value);
	//
	if (retval == UA_STATUSCODE_GOOD && UA_Variant_hasScalarType(&value, &UA_TYPES[UA_TYPES_DOUBLE]))
	{
		UA_Double doubleData = *(UA_Double *)value.data;
		ret = (double)doubleData;
	}
	return ret;
}