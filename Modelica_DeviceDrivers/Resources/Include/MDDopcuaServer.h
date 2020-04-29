

#ifndef MDDOPCUASERVER_H_
#define MDDOPCUASERVER_H_

#if !defined(ITI_COMP_SIM)

#include "ModelicaUtilities.h"
#include "MDDSerialPackager.h"

#if defined(_MSC_VER) || defined(__MINGW32__)

#include <winsock2.h>
#include "../src/include/CompatibilityDefs.h"
#include "../src/OPCUA62541Wrapper/include/OPCUA62541Wrapper.h"

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
	ModelicaFormatMessage("Create server in thread\n");
	r = startOPCUAserver(opcua->server,&opcua->running);
	ModelicaFormatMessage("Started opc ua server %d\n",r);

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
	
	//opcua->server = createOPCUAserver();
	ModelicaFormatMessage("Create server \n");
	
	InitializeCriticalSection(&opcua->receiveLock);
	opcua->hThread = CreateThread(0, 1024, MDD_OPCUAServerThread, opcua, 0, &id1);
	if (!opcua->hThread) {
		DWORD dw = GetLastError();
		deleteOPCUAserver(opcua->server,&opcua->running);
		DeleteCriticalSection(&opcua->receiveLock);
		free(opcua);
		opcua = NULL;
		WSACleanup();
		ModelicaFormatError("MDDopcuaServer.h: Error creating opc ua thread: %lu\n", dw);
	}


	/*

    udp->useReceiveThread = useReceiveThread;
    udp->receiving = 0;
    udp->bufferSize = bufferSize;
    udp->nReceivedBytes = 0;
    udp->nRecvbufOverwrites = 0;
    addr.sin_family = AF_INET;
    addr.sin_port = htons((u_short)port);
    addr.sin_addr.s_addr = INADDR_ANY;

    if (port) {
        rc = bind(udp->SocketID,(SOCKADDR*)&addr,sizeof(SOCKADDR_IN));
        if (rc == INVALID_SOCKET) {
            closesocket(udp->SocketID);
            free(udp);
            udp = NULL;
            rc = WSAGetLastError();
            WSACleanup();
            ModelicaFormatError("MDDUDPSocket.h: bind to port %d failed with error code: %d\n", port, rc);
            return udp;
        }
        udp->receiveBuffer = (char*)calloc(bufferSize, 1);
        InitializeCriticalSection(&udp->receiveLock);
        if (udp->useReceiveThread) {
            udp->receiving = 1;
            udp->hThread = CreateThread(0, 1024, MDD_udpReceivingThread, udp, 0, &id1);
            if (!udp->hThread) {
                DWORD dw = GetLastError();
                udp->receiving = 0;
                rc = shutdown(udp->SocketID, 2);
                if (rc == SOCKET_ERROR) {
                    ModelicaFormatMessage("MDDUDPSocket.h: shutdown failed: %d\n", WSAGetLastError());
                }
                closesocket(udp->SocketID);
                DeleteCriticalSection(&udp->receiveLock);
                free(udp->receiveBuffer);
                free(udp);
                udp = NULL;
                WSACleanup();
                ModelicaFormatError("MDDUDPSocket.h: Error creating UDP receiver thread: %lu\n", dw);
            }
        }
        ModelicaFormatMessage("MDDUDPSocket.h: Waiting for data on port %d.\n", port);
    }
    else {
        ModelicaMessage("MDDUDPSocket.h: Opened socket for sending.\n");
    } */
    return (void *) opcua;
}

DllExport void MDD_opcuaServerDestructor(void * p_opcua) 
{
    MDDopcuaServer * opcua = (MDDopcuaServer *) p_opcua;
	        ModelicaFormatMessage("Destroy\n");

	//deleteOPCUAserver(opcua->server, &opcua->running);

	/* 
    if (udp) {
        udp->receiving = 0;
        rc = shutdown(udp->SocketID, 2);
        if (rc == SOCKET_ERROR) {
            ModelicaFormatMessage("MDDUDPSocket.h: shutdown failed with error code: %d\n", WSAGetLastError());
        }
        closesocket(udp->SocketID);
        if (udp->useReceiveThread && udp->hThread) {
            DWORD dwEc = 1;
            WaitForSingleObject(udp->hThread, 1000);
            if (GetExitCodeThread(udp->hThread, &dwEc) && dwEc == STILL_ACTIVE) {
                TerminateThread(udp->hThread, 1);
            }
            CloseHandle(udp->hThread);
            DeleteCriticalSection(&udp->receiveLock);
            free(udp->receiveBuffer);
        }
        free(udp);
    } */
    WSACleanup();
}

#else

#error "Modelica_DeviceDrivers: No support of UDPSocket for your platform"

#endif /* defined(_MSC_VER) */

#endif /* !defined(ITI_COMP_SIM) */

#endif /* MDDOPCUASERVER_H_ */
