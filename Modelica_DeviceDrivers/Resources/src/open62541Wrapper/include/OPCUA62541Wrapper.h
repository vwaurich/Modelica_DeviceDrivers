#ifdef _WIN32
#    ifdef EXPORTLIB
#        define LIB_API __declspec(dllexport)
		#include "open62541.h"
		#include <signal.h>
		#include <stdlib.h>
#    else
#        define LIB_API __declspec(dllimport)
#    endif
#elif
#    define EXPORTLIB
#endif

LIB_API void* createOPCUAserver();
LIB_API int startOPCUAserver(void* opcua);
LIB_API void deleteOPCUAserver(void* opcua);
LIB_API void addIntVariable(void* opcua, char* name, int value);
LIB_API void writeIntVariable(void* opcua, char* name, int value);
LIB_API void addDoubleVariable(void* opcua, char* name, double value);
LIB_API void writeDoubleVariable(void* opcua, char* name, double value);
