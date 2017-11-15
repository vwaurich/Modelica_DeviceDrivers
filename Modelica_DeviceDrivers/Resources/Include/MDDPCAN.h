
#ifndef MDDPCAN_H
#define MDDPCAN_H


# define DllExport \
__declspec( dllexport )


#include "ModelicaUtilities.h"
#include <windows.h>
#include <mmsystem.h>
#include <stdlib.h>

#if defined(_MSC_VER) || defined(__CYGWIN__) || defined(__MINGW32__)

/*
--------- Functions for REAL type ---------
*/

/** Constructor for ExternalMemory of type double*/
DllExport void* MDD_PCAN_Constructor(int channelName, int baudrate);

/** Destructor for ExternalMemory of type double*/
DllExport void MDD_PCAN_Destructor(void* p_pcan);

/** Read CAN message*/
DllExport void MDD_PCANReadP(void* p_pcan, int id, void* p_serialp, int* len, int* timeStamp);


#endif /* defined(_MSC_VER) */

#endif /* EXTERNALMEMORY_H */