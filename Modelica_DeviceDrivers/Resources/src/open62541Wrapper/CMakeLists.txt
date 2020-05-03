cmake_minimum_required(VERSION 2.8.9)
project(open62541Wrapper)

#all source files
file(GLOB SOURCES "*.c")
file(GLOB HEADER "*.h")

add_definitions(-DUA_DYNAMIC_LINKING_EXPORT -DEXPORTLIB -DUA_ARCHITECTURE_WIN32)

add_library(open62541Wrapper SHARED
    ${SOURCES}
	${HEADER}
)

target_link_libraries(open62541Wrapper ws2_32)
