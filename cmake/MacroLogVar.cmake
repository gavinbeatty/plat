
cmake_minimum_required(VERSION 2.6)
if(POLICY CMP0011)
    cmake_policy(PUSH)
    cmake_policy(SET CMP0011 NEW)
endif(POLICY CMP0011)

macro(macro_log_var)
    foreach(macro_log_var_i ${ARGN})
        message(STATUS "${macro_log_var_i}=${${macro_log_var_i}}")
    endforeach(macro_log_var_i ${ARGN})
endmacro(macro_log_var)

if(POLICY CMP0011)
    cmake_policy(POP)
endif(POLICY CMP0011)


