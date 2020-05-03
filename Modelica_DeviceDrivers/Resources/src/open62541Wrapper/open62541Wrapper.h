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



LIB_API void* createOPCUAserver();
LIB_API int startOPCUAserver(void* opcua);
LIB_API void deleteOPCUAserver(void* opcua);
LIB_API void addIntVariable(void* opcua, char* name, int value);
LIB_API void writeIntVariable(void* opcua, char* name, int value);
LIB_API void addDoubleVariable(void* opcua, char* name, double value);
LIB_API void writeDoubleVariable(void* opcua, char* name, double value);
