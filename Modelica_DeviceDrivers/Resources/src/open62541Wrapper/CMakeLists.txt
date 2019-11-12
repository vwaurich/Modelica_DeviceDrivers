cmake_minimum_required(VERSION 2.8.9)
project(open62541Wrapper)


ADD_LIBRARY( open62541Wrapper SHARED
             open62541.c open62541.h open62541Wrapper.h)
target_link_libraries(open62541Wrapper ws2_32.lib wsock32.lib)