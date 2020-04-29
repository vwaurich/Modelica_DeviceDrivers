#ifdef _WIN32
#    ifdef EXPORTLIB
#        define LIB_API __declspec(dllexport)
		#include <open62541/plugin/log_stdout.h>
		#include <open62541/server.h>
		#include <open62541/server_config_default.h>
		#include <signal.h>
		#include <stdlib.h>
#    else
#        define LIB_API __declspec(dllimport)
#    endif
#elif
#    define EXPORTLIB
#endif

LIB_API void* createOPCUAserver();
LIB_API int startOPCUAserver(void* vp_server);
LIB_API void deleteOPCUAserver(void* vp_server);
