
#include "MDDPCAN.h"
#include "PCANBasic.h"
#include "PCANBasicClass.h"
#include "ModelicaUtilities.h"
#include "MDDSerialPackager.h"
#include <map>
#include <vector>

typedef struct {
	int channelName;
	PCANBasicClass* pcan;
	TPCANStatus status;
	TPCANMsg* rcvMsg;
	TPCANMsg* currentMsg;
	std::map<int, TPCANMsg>* ID_MSG_map;
	TPCANTimestamp* timeStamp;
	DWORD readThreadID;
	HANDLE readThreadHandle;
} MDD_PCAN;


static DWORD WINAPI readingThread(LPVOID p_PCAN)
{
	MDD_PCAN *pcan = (MDD_PCAN*)p_PCAN;
	pcan->currentMsg->DATA[0] = 0;
	pcan->currentMsg->DATA[1] = 0;
	while (1) {
		pcan->status = pcan->pcan->Read(pcan->channelName, pcan->currentMsg, pcan->timeStamp);
		if (pcan->status != PCAN_ERROR_QRCVEMPTY)
		{
			//ModelicaFormatMessage("ok !, got %d\n", pcan->currentMsg->ID);
			int num = pcan->ID_MSG_map->count(pcan->currentMsg->ID);
			//ModelicaFormatMessage("count %d !\n", num);

			if (pcan->ID_MSG_map->count(pcan->currentMsg->ID) == 0)
			{
				//ModelicaFormatMessage("register ! %d\n", pcan->currentMsg->ID);
				pcan->ID_MSG_map->insert(std::pair<int, TPCANMsg>((int)pcan->currentMsg->ID, *pcan->currentMsg));
			}
			else
			{
				//ModelicaFormatMessage("update ! %d\n", pcan->currentMsg->DATA[0]);
				(*pcan->ID_MSG_map)[pcan->currentMsg->ID] = *pcan->currentMsg;
			}
		}
	}
	return 0;
}

/** Constructor for real array
*/
extern "C" DllExport void* MDD_PCAN_Constructor(int channelName, int baudrate) {
	ModelicaFormatMessage("MDDPCAN::MDD_PCAN_Constructor!\n");

	MDD_PCAN* pcan = (MDD_PCAN*)calloc(1, sizeof(MDD_PCAN));
	pcan->channelName = channelName;
	pcan->rcvMsg = (TPCANMsg*)calloc(1, sizeof(TPCANMsg));
	pcan->currentMsg = (TPCANMsg*)calloc(1, sizeof(TPCANMsg));
	pcan->timeStamp = new tagTPCANTimestamp();
	pcan->ID_MSG_map = new std::map<int, TPCANMsg>;

	pcan->pcan = new PCANBasicClass();
	pcan->status = pcan->pcan->Initialize(pcan->channelName, PCAN_BAUD_250K, PCAN_TYPE_ISA);

	if (pcan->status)
		ModelicaFormatMessage("Could not initialize the CAN Device properly\n");
	else
		ModelicaFormatMessage("Successfully initialized CAN device\n");

	pcan->currentMsg->ID = DWORD(0);
	pcan->currentMsg->LEN = BYTE(8);
	pcan->currentMsg->MSGTYPE = BYTE(PCAN_MESSAGE_STANDARD);
	pcan->currentMsg->DATA[0] = 1;
	pcan->currentMsg->DATA[1] = 1;
	pcan->currentMsg->DATA[2] = 1;
	pcan->currentMsg->DATA[3] = 1;
	pcan->currentMsg->DATA[4] = 1;
	pcan->currentMsg->DATA[5] = 1;
	pcan->currentMsg->DATA[6] = 1;
	pcan->currentMsg->DATA[7] = 1;

	//reading thread
	pcan->readThreadHandle = CreateThread(0, 0, readingThread, pcan, 0, &pcan->readThreadID);

	return (void*)pcan;
}

/** Destructor for real array
*/
extern "C" DllExport void MDD_PCAN_Destructor(void* p_pcan) {
	MDD_PCAN* pcan = (MDD_PCAN*)p_pcan;

	//close thread
	WaitForSingleObject(pcan->readThreadHandle, 1000);
	DWORD dwEc = 1;
	if (GetExitCodeThread(pcan->readThreadHandle, &dwEc) && dwEc == STILL_ACTIVE) {
		TerminateThread(pcan->readThreadHandle, 1);
	}
	CloseHandle(pcan->readThreadHandle);

	//free
	if (pcan) {
		free(pcan);
	}
}

/** Read CAN message*/
extern "C" DllExport void MDD_PCANReadP(void* p_pcan, int id, void* p_serialp, int* len, int* timeStamp)
{
	MDD_PCAN* pcan = (MDD_PCAN*)p_pcan;
	len[0] = 0;
	timeStamp[0] = 0;
	std::map<int, TPCANMsg>::iterator it = pcan->ID_MSG_map->find(id);

	if (it != pcan->ID_MSG_map->end())
	{
		pcan->rcvMsg = &it->second;
		//ModelicaFormatMessage(" for id %d , we got %d\n",id, &it->second);
		int rc = MDD_SerialPackagerSetDataWithErrorReturn(p_serialp, reinterpret_cast<const char*>(pcan->rcvMsg->DATA), pcan->rcvMsg->LEN);
	}
	else
	{
	    ModelicaFormatMessage("MDDPCAN::MDD_PCANReadP did not received any message with ID! %d \n", id);
	}
}

