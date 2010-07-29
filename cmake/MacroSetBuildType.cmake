
cmake_minimum_required(VERSION 2.6)
if(POLICY CMP0011)
    cmake_policy(PUSH)
    cmake_policy(SET CMP0011 NEW)
endif(POLICY CMP0011)

macro(macro_set_build_type)
    if(NOT CMAKE_BUILD_TYPE)
        if(${CMAKE_PROJECT_NAME}_DEVELOPER)
            set(CMAKE_BUILD_TYPE "RelWithDebInfo")
            if(${CMAKE_PROJECT_NAME}_DEVELOPER_BUILD_TYPE)
                set(CMAKE_BUILD_TYPE "${${CMAKE_PROJECT_NAME}_DEVELOPER_BUILD_TYPE}")
            endif(${CMAKE_PROJECT_NAME}_DEVELOPER_BUILD_TYPE)
        endif(${CMAKE_PROJECT_NAME}_DEVELOPER)
        if(NOT CMAKE_BUILD_TYPE)
            set(CMAKE_BUILD_TYPE "Release")
        endif(NOT CMAKE_BUILD_TYPE)
    endif(NOT CMAKE_BUILD_TYPE)
endmacro(macro_set_build_type)

if(POLICY CMP0011)
    cmake_policy(POP)
endif(POLICY CMP0011)


