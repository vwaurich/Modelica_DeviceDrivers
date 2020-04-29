cmake_minimum_required(VERSION 2.8.9)
project(open62541Wrapper C)

#include directories
#find_path(OPEN62541_INC_DIR server.h)
#find_path(OPEN62541_PLUGIN_INC_DIR server_config_default.h)

#all source files
file(GLOB SOURCES "src/*.c")
file(GLOB HEADER "include/*.h")

#set(OPEN62541_DIR  "E:/Software/open62541/")
find_path(OPEN62541_DIR "E:/Software/open62541/")


#libraries
find_library(OPEN62541_LIB open62541)


include_directories(${OPEN62541_DIR}/include 
					${OPEN62541_DIR}/arch 
					${OPEN62541_DIR}/arch/win32 
					${OPEN62541_DIR}/build/src_generated 
					${OPEN62541_DIR}/src/pubsub 
					${OPEN62541_DIR}/plugins/include 
					${OPEN62541_DIR}/deps)
include_directories(include)

#add_definitions(-DUA_ENABLE_AMALGAMATION)

#add_executable(open62541Wrapper ${SOURCES} ${HEADER})

add_definitions(-DEXPORTLIB)

add_library(open62541Wrapper SHARED
    ${SOURCES}
	${HEADER}
)

target_link_libraries(open62541Wrapper ${OPEN62541_LIB} ws2_32)

