

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
typedef struct MDDopcuaClient_s MDDopcuaClient;

struct MDDopcuaServer_s {
    SOCKET SocketID;
	HANDLE hThread;
	void* server;
	unsigned char running;
    CRITICAL_SECTION receiveLock;
};

struct MDDopcuaClient_s {
    SOCKET SocketID;
	HANDLE hThread;
	void* client;
	char* endpointURL;
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

DllExport int MDD_opcuaAddIntVar(void* p_opcua, int invocOrder, char* nodeName, int nodeNsIdx,  int nodeId, int parentNsIdx, int parentNodeId, int referenceId, int value)
{
	MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	ModelicaFormatMessage("MDDopcuaServer.h:AddInt %s (%d:%d)to parent %d:%d with ref %d.\n",nodeName, nodeNsIdx, nodeId, parentNsIdx, parentNodeId, referenceId);
	addIntVariable(opcua->server, nodeName, nodeNsIdx, nodeId, parentNsIdx, parentNodeId, referenceId, value);
	return invocOrder+1;
}

DllExport void MDD_opcuaWriteIntVar(void* p_opcua, char* nodeName, int nodeNsIdx, int nodeId, int value)
{
	MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	//ModelicaFormatMessage("MDDopcuaServer.h: Write %s (%d)to %d.\n",nodeName, nodeId, value);
	writeIntVariable(opcua->server, nodeName, nodeNsIdx, nodeId, value);
}

DllExport int MDD_opcuaAddRealVar(void* p_opcua,int invocOrder, char* nodeName,int nodeNsIdx,  int nodeId, int parentNsIdx, int parentNodeId, int referenceId, double value)
{
	MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	ModelicaFormatMessage("MDDopcuaServer.h:AddReal %s (%d:%d)to parent %d:%d.\n",nodeName, nodeNsIdx, nodeId, parentNsIdx, parentNodeId, referenceId);
	addDoubleVariable(opcua->server, nodeName, nodeNsIdx, nodeId, parentNsIdx, parentNodeId,referenceId, value);
	return invocOrder+1;
}


DllExport void MDD_opcuaWriteRealVar(void* p_opcua, char* nodeName, int nodeNsIdx, int nodeId, double value)
{
	MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	//ModelicaFormatMessage("MDDopcuaServer.h: Write %s to %d.\n",nodeName, value);
	writeDoubleVariable(opcua->server, nodeName, nodeNsIdx, nodeId, value);
}

DllExport int MDD_opcuaAddObjectNode(void* p_opcua, int invocOrder, char* nodeName, int nodeNsIdx,  int nodeId, int parentNsIdx, int parentNodeId, int referenceId)
{
	MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	ModelicaFormatMessage("MDDopcuaServer.h:AddObject %s (%d:%d)to parent %d:%d.\n",nodeName, nodeNsIdx, nodeId, parentNsIdx, parentNodeId, referenceId);
	addObject(opcua->server, nodeName, nodeNsIdx, nodeId, parentNsIdx,parentNodeId,referenceId);
	return invocOrder+1;
}

//#################################################################
//###############OPC-UA-Client section##################
//#################################################################

DWORD WINAPI MDD_OPCUAClientThread(LPVOID p_opcua) {
	int ret = 0;
	
    MDDopcuaClient * opcua = (MDDopcuaClient *) p_opcua;
	ModelicaFormatMessage("MDDopcuaServer.h: Start OPC UA client on %s\n",opcua->endpointURL);
	ret = startOPCUAclient(opcua->client,opcua->endpointURL);
	ModelicaFormatMessage("MDDopcuaServer.h: Started OPC UA client on %s with ret=%d\n",opcua->endpointURL, ret);
    return 0;
}

DllExport void * MDD_opcuaClientConstructor(char* endpointURL) 
{
    int rc; /* Error variable */
    WSADATA wsa;
    SOCKADDR_IN addr;
    DWORD id1;
    MDDopcuaClient * opcua;
 
    rc = WSAStartup(MAKEWORD(2,2),&wsa);
    if (rc != NO_ERROR) {
        ModelicaFormatError("MDDopcuaServer.h: WSAStartup failed with error code: %d\n", rc);
        return NULL;
    }

    opcua = (MDDopcuaClient *)calloc(sizeof(MDDopcuaClient), 1);
	opcua->client = createOPCUAclient();
	opcua->endpointURL = endpointURL;
	ModelicaFormatMessage("MDDopcuaServer.h: Created OPC UA client \n");
	
	InitializeCriticalSection(&opcua->receiveLock);
	opcua->hThread = CreateThread(0, 1024, MDD_OPCUAClientThread, opcua, 0, &id1);
	if (!opcua->hThread) {
		DWORD dw = GetLastError();
		deleteOPCUAclient(opcua->client);
		DeleteCriticalSection(&opcua->receiveLock);
		free(opcua);
		opcua = NULL;
		WSACleanup();
		ModelicaFormatError("MDDopcuaServer.h: Error creating opc ua client thread: %lu\n", dw);
	}
    return (void *) opcua;
}

DllExport void MDD_opcuaClientDestructor(void * p_opcua) 
{
    MDDopcuaClient * opcua = (MDDopcuaClient *) p_opcua;

    if (opcua) {
        deleteOPCUAclient(opcua->client);
		ModelicaMessage("MDDopcuaClient.h: Delete OPC UA Client.\n");
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

int MDD_opcuaClientReadInt(void * p_opcua, int nodeNsIdx, int nodeId)
{
	MDDopcuaClient * opcua = (MDDopcuaClient *) p_opcua;
	//ModelicaFormatMessage("MDDopcuaServer.h: MDD_opcuaClientReadInt %d:%d\n",nodeNsIdx,nodeId);
	return readIntValue(opcua->client, nodeNsIdx, nodeId);
}

double MDD_opcuaClientReadDouble(void * p_opcua, int nodeNsIdx, int nodeId)
{
	MDDopcuaClient * opcua = (MDDopcuaClient *) p_opcua;
	//ModelicaFormatMessage("MDDopcuaServer.h: MDD_opcuaClientReadReal %d:%d\n",nodeNsIdx,nodeId);
	return readDoubleValue(opcua->client, nodeNsIdx, nodeId);
}

#else

#error "Modelica_DeviceDrivers: No support of OPC UA for your platform"

#endif /* defined(_MSC_VER) */

#endif /* !defined(ITI_COMP_SIM) */

#endif /* MDDOPCUASERVER_H_ */
