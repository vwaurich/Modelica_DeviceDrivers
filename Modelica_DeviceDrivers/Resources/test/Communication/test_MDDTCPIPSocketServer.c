#include <stdio.h>
#include "../../Include/MDDTCPIPSocketServer.h"
#include "../../Include/MDDTCPIPSocket.h"
#include "../src/include/util.h" /* MDD_msleep(..) */

#define DEFAULT_BUFLEN 512
#define DEFAULT_PORT 27015
#define MAX_CLIENTS 10

int main(void) {
	void* server = MDD_TCPIPServer_Constructor(DEFAULT_PORT, MAX_CLIENTS, 1);
    const char* recvbuf_server;
    int nRecvBytes;
    int nSentBytes;
    char sendbuf_server[DEFAULT_BUFLEN] = { 0 };
    unsigned int i = 0;
    int acceptedClients[MAX_CLIENTS];
	memset(acceptedClients, 0, sizeof(acceptedClients));

    /***********************************************************************/
    /* Set up TCP/IP client so that the server has something that connects */
    /***********************************************************************/

	while (1)
	{
		recvbuf_server = MDD_TCPIPServer_Read(server, 1, DEFAULT_BUFLEN, &nRecvBytes);
			if (nRecvBytes > DEFAULT_BUFLEN) {
				printf("%d: Buffer overflow. Got %d bytes\n", i, nRecvBytes);
			}

			else if (nRecvBytes > 0) {
				printf("%d: nReceivedBytes: %d\n", i, nRecvBytes);
				printf("%d: recvbuf: %s\n", i, recvbuf_server);
				memcpy(sendbuf_server, recvbuf_server, nRecvBytes);
				printf("%d: sendbuf_server: %s\n", i, sendbuf_server);
				nSentBytes = MDD_TCPIPServer_Send(server, sendbuf_server, nRecvBytes, 1);
				printf("%d: nSentBytes: %d\n", i, nSentBytes);
			}
	}

    MDD_TCPIPServer_Destructor(server);

    return EXIT_SUCCESS;
}
