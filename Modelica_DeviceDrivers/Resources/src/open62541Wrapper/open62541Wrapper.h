#if defined _WIN32 || defined __CYGWIN__
  #ifdef EXPORTLIB
    #ifdef __GNUC__
		#include "open62541.h"
		#include <signal.h>
		#include <stdlib.h>
      #define LIB_API __attribute__ ((dllexport))
    #else
  		#include "open62541.h"
		#include <signal.h>
		#include <stdlib.h>    
		#define LIB_API __declspec(dllexport) // Note: actually gcc seems to also supports this syntax.
    #endif
  #else
    #ifdef __GNUC__
      #define LIB_API __attribute__ ((dllimport))
    #else
      #define LIB_API __declspec(dllimport) // Note: actually gcc seems to also supports this syntax.
    #endif
  #endif
#endif


enum referenceIdType {setIndexToOneBaseDummyType_DO_NOT_USE,hasProperty,hasComponent,organizes};


LIB_API void* createOPCUAserver();
LIB_API int startOPCUAserver(void* opcua);
LIB_API void deleteOPCUAserver(void* opcua);
LIB_API void addIntVariable(void* opcua, char* name, int nodeNsIdx, int intNodeId, int parentNsIdx, int intParentNodeId, int referenceId, int value);
LIB_API void writeIntVariable(void* opcua, char* name, int nodeNsIdx, int intNodeId, int value);
LIB_API void addDoubleVariable(void* opcua, char* name, int nodeNsIdx, int intNodeId, int parentNsIdx, int intParentNodeId, int referenceId, double value);
LIB_API void writeDoubleVariable(void* opcua, char* name, int nodeNsIdx, int intNodeId, double value);
LIB_API void addObject(void *server, char* name, int nodeNsIdx, int nodeId, int parentNsIdx, int intParentNodeId, int referenceId);

LIB_API void* createOPCUAclient();
LIB_API int startOPCUAclient(void* client_vp, char* endpointURL);
LIB_API void deleteOPCUAclient(void* client_vp);
LIB_API int readIntValue(void* client_vp, int nodeNsIdx, int intNodeId);
