
cmake_minimum_required(VERSION 2.6)
if(POLICY CMP0011)
    cmake_policy(PUSH)
    cmake_policy(SET CMP0011 NEW)
endif(POLICY CMP0011)

macro(macro_set_bare_var)
    foreach(_barevarname ${ARGN})
        set("${_barevarname}" "${${PROJECT_NAME}_${_barevarname}}")
    endforeach(_barevarname ${ARGN})
endmacro(macro_set_bare_var)

if(POLICY CMP0011)
    cmake_policy(POP)
endif(POLICY CMP0011)

