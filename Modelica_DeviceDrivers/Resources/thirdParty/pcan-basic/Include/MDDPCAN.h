
#ifndef MDDPCAN_H
#define MDDPCAN_H


# define DllExport \
__declspec( dllexport )

#if defined(_MSC_VER) || defined(__CYGWIN__) || defined(__MINGW32__)

/** Constructor for PCAN object*/
extern "C" DllExport void* MDD_PCAN_Constructor(int channelName, int baudrate);

/** Destructor for PCAN object*/
extern "C" DllExport void MDD_PCAN_Destructor(void* p_pcan);

/** Read CAN message*/
extern "C" DllExport void MDD_PCANReadP(void* p_pcan, int id, void* p_serialp, int* len, int* timeStamp);

#endif /* defined(_MSC_VER) */

#endif /* EXTERNALMEMORY_H */