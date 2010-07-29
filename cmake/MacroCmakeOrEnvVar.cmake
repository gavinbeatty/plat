
cmake_minimum_required(VERSION 2.6)
if(POLICY CMP0011)
    cmake_policy(PUSH)
    cmake_policy(SET CMP0011 NEW)
endif(POLICY CMP0011)

macro(macro_cmake_or_env_var _name)
    if(NOT "${${_name}}" STREQUAL "")
    elseif(NOT "$ENV{${_name}}" STREQUAL "")
        set("${_name}" "$ENV{${_name}}")
    endif(NOT "${${_name}}" STREQUAL "")
endmacro(macro_cmake_or_env_var _name)

if(POLICY CMP0011)
    cmake_policy(POP)
endif(POLICY CMP0011)

