
cmake_minimum_required(VERSION 2.6)
if(POLICY CMP0011)
    cmake_policy(PUSH)
    cmake_policy(SET CMP0011 NEW)
endif(POLICY CMP0011)

macro(macro_option _name _doc _default)
    if(NOT DEFINED "${_name}")
        set("${_name}" ${_default} CACHE STRING "${_doc}")
    endif(NOT DEFINED "${_name}")
    if("${_default}" STREQUAL "${${_name}}")
        message(STATUS "Option: ${_name}=${${_name}} [default]")
    else("${_default}" STREQUAL "${${_name}}")
        message(STATUS "Option: ${_name}=${${_name}} [default=${_default}]")
    endif("${_default}" STREQUAL "${${_name}}")
endmacro(macro_option _name _doc _default)

if(POLICY CMP0011)
    cmake_policy(POP)
endif(POLICY CMP0011)


