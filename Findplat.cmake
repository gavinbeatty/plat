# - Try to find plat.
# Once done this will define the following variables:
#
#  plat_FOUND              - If false, no plat headers were found.
#  plat_VERSION_MAJOR      - The major version plat found.
#  plat_VERSION_MINOR      - The minor version plat found.
#  plat_VERSION_PATCH      - The patch version plat found.
#  plat_VERSION_STRING     - The version string, i.e., major.minor.patch
#                            format.
#
#  plat_INCLUDE_DIRS       - List of include directories to add when compiling
#                            code using plat.
#
#  plat_LIBRARIES          - List of plat's libraries.
#
#  plat_SHARED_LIBRARIES   - List of plat's libraries as shared libraries.
#
#  plat_STATIC_LIBRARIES   - List of plat's libraries as static libraries.
#
# You can set the following variables to aid in finding plat:
#
#  PLAT_EXPORT_DIR         - Hints for the path leading to the CMake export file.
#                            e.g., /opt/plat-1.0.0/lib/plat, C:\plat-1.0.0\lib\plat
#
#  EXPORT_ROOT_DIR           - After PLAT_EXPORT_DIR, we try:
#                               ${EXPORT_ROOT_DIR}/lib/plat
#
#  PLAT_EXPORT_FILENAME    - The base filename of the CMake export file.
#                            e.g., Exportplat-1.cmake, Exportplat-1.0.0.cmake
#
# You may have multiple versions of plat installed. To select whichever one you
# are using, below is the recommended strategy:
#
# If you have installed plat to its own prefix, such as /opt/plat-1.0:
# set PLAT_EXPORT_DIR=/opt/plat-1.0/lib/plat. It will pick up the CMake export
# file at /opt/plat-1.0/lib/plat/Exportplat.cmake.
#
# If you have installed plat to a shared prefix, such as /usr/local:
# set PLAT_EXPORT_DIR=/usr/local/lib/plat
# set PLAT_EXPORT_FILENAME=Exportplat-1.0.0.cmake
# or whatever version you require.
#
# CMake 2.6 module syntax is supported.
# i.e.,
#
#  find_package(plat [<major>[.<minor>[.<patch>]]] [EXACT]
#               [QUIET] [REQUIRED])
#
#

set(_p "plat")
string(TOUPPER "${_p}" _P)

if(NOT ${_p}_FOUND)

set(${_p}_no_libs TRUE)
if(NOT ${_p}_no_libs)
    set(${_p}_default_lib_type "")
    set(${_p}_shared_libs )
    set(${_p}_static_libs )
endif(NOT ${_p}_no_libs)
set(${_p}_config_header "config.h")

set(${_p}_found TRUE)


cmake_minimum_required(VERSION 2.6)
if(POLICY CMP0011)
    cmake_policy(PUSH)
    cmake_policy(SET CMP0011 NEW)
endif(POLICY CMP0011)

macro(macro_version_major_number _a _a_major)
    string(REGEX REPLACE "^([0-9]+)" "\\1" "${_a_major}" "${_a}")
    set("${_a_major}" "${CMAKE_MATCH_1}")
    if("${${_a_major}}" STREQUAL "")
        set("${_a_major}" "0")
    endif("${${_a_major}}" STREQUAL "")
endmacro(macro_version_major_number _a _a_major)
macro(macro_version_minor_number _a _a_minor)
    string(REGEX REPLACE "^[0-9]+\\.([0-9]+)" "\\1" "${_a_minor}" "${_a}")
    set("${_a_minor}" "${CMAKE_MATCH_1}")
    if("${${_a_minor}}" STREQUAL "")
        set("${_a_minor}" "0")
    endif("${${_a_minor}}" STREQUAL "")
endmacro(macro_version_minor_number _a _a_minor)
macro(macro_version_patch_number _a _a_patch)
    string(REGEX REPLACE "^[0-9]+\\.[0-9]+\\.([0-9]+)" "\\1" "${_a_patch}" "${_a}")
    set("${_a_patch}" "${CMAKE_MATCH_1}")
    if("${${_a_patch}}" STREQUAL "")
        set("${_a_patch}" "0")
    endif("${${_a_patch}}" STREQUAL "")
endmacro(macro_version_patch_number _a _a_patch)
macro(macro_version_other_number _a _a_other)
    string(REGEX REPLACE "^[0-9]+\\.[0-9]+\\.[0-9]+\\.([0-9]+)" "\\1" "${_a_other}" "${_a}")
    set("${_a_other}" "${CMAKE_MATCH_1}")
    if("${${_a_other}}" STREQUAL "")
        set("${_a_other}" "0")
    endif("${${_a_other}}" STREQUAL "")
endmacro(macro_version_other_number _a _a_other)
macro(macro_version_letter _a _a_letter)
    string(REGEX REPLACE "^[0-9.]*([a-zA-Z])$" "\\1" "${_a_letter}" "${_a}")
    set("${_a_letter}" "${CMAKE_MATCH_1}")
endmacro(macro_version_letter _a _a_letter)
macro(macro_normalize_version _a _norm _letter)
    macro_version_major_number("${_a}" _a_major)
    macro_version_minor_number("${_a}" _a_minor)
    macro_version_patch_number("${_a}" _a_patch)
    macro_version_other_number("${_a}" _a_other)
    macro_version_letter("${_a}" "${_letter}")
    foreach(_i "_a_major" "_a_minor" "_a_patch" "_a_other")
        if("${${_i}}" GREATER 99)
            message(SEND_ERROR "macro_normalize_version: can only handle version numbers less than 100 in each position.")
        endif("${${_i}}" GREATER 99)
    endforeach(_i "_a_major" "_a_minor" "_a_patch" "_a_other")
    math(EXPR "${_norm}" "${_a_other} + ( ${_a_patch} * 100 ) + ( ${_a_minor} * 10000 ) + ( ${_a_major} * 1000000 )")
endmacro(macro_normalize_version _a _norm _letter)

macro(macro_version_letter_cmp_ _a _b _result)
    if("${_a}" STREQUAL "${_b}")
        set("${_result}" 0)
    elseif("${_a}" STREQUAL "")
        set("${_result}" -1)
    elseif("${_b}" STREQUAL "")
        set("${_result}" 1)
    elseif("${_a}" STRLESS "${_b}")
        set("${_result}" -1)
    else("${_a}" STREQUAL "${_b}")
        set("${_result}" 1)
    endif("${_a}" STREQUAL "${_b}")
endmacro(macro_version_letter_cmp_ _a _b _result)

macro(macro_cmp_op_result_match _op _cmpresult _result)
    set("${_result}" 0)
    if("${_op}" STREQUAL "==" AND "${_cmpresult}" EQUAL 0)
        set("${_result}" 1)
    elseif("${_op}" STREQUAL "!=")
        if(NOT "${_cmpresult}" EQUAL 0)
            set("${_result}" 1)
        endif(NOT "${_cmpresult}" EQUAL 0)
    elseif("${_op}" STREQUAL "<" AND "${_cmpresult}" EQUAL -1)
        set("${_result}" 1)
    elseif("${_op}" STREQUAL ">" AND "${_cmpresult}" EQUAL 1)
        set("${_result}" 1)
    elseif("${_op}" STREQUAL "<=")
        if(NOT "${_cmpresult}" EQUAL 1)
            set("${_result}" 1)
        endif(NOT "${_cmpresult}" EQUAL 1)
    elseif("${_op}" STREQUAL ">=")
        if(NOT "${_cmpresult}" EQUAL -1)
            set("${_result}" 1)
        endif(NOT "${_cmpresult}" EQUAL -1)
    endif("${_op}" STREQUAL "==")
endmacro(macro_cmp_op_result_match _op _cmpresult _result)

macro(macro_version_cmp _a _b _result)
    if("${_a}" STREQUAL "${_b}")
        set("${_result}" 0)
    else("${_a}" STREQUAL "${_b}")
        macro_normalize_version("${_a}" _a_norm _a_letter)
        macro_normalize_version("${_b}" _b_norm _b_letter)
        if("${_a_norm}" EQUAL "${_b_norm}")
            macro_version_letter_cmp_("${_a_letter}" "${_b_letter}" "${_result}")
        elseif("${_a_norm}" LESS "${_b_norm}")
            set("${_result}" -1)
        else("${_a_norm}" EQUAL "${_b_norm}")
            set("${_result}" 1)
        endif("${_a_norm}" EQUAL "${_b_norm}")
    endif("${_a}" STREQUAL "${_b}")
endmacro(macro_version_cmp _a _b _result)

if(POLICY CMP0011)
    cmake_policy(POP)
endif(POLICY CMP0011)


macro(setu _varname)
    set("${_varname}" ${ARGN})
    string(TOUPPER "${_varname}" _varname_u)
    set("${_varname_u}" ${ARGN})
endmacro(setu _varname)
macro(m_check_version _proj _depname _foundvar)
    set(${_foundvar} TRUE)
    set(${_depname}_find_ver "${${_depname}_FIND_VERSION_MAJOR}")
    if(${_depname}_FIND_VERSION_MINOR)
        set(${_depname}_find_ver "${${_depname}_find_ver}.${${_depname}_FIND_VERSION_MINOR}")
        if(${_depname}_FIND_VERSION_PATCH)
            set(${_depname}_find_ver "${${_depname}_find_ver}.${${_depname}_FIND_VERSION_PATCH}")
        endif(${_depname}_FIND_VERSION_PATCH)
    endif(${_depname}_FIND_VERSION_MINOR)
    set(${_depname}_ver "${${_depname}_VERSION_STRING}")
    macro_version_cmp("${${_depname}_ver}" "${${_depname}_find_ver}" _cmp)
    if(${_depname}_FIND_VERSION_EXACT)
        if(NOT "${_cmp}" EQUAL "0")
            set("${_foundvar}" FALSE)
            message(STATUS "${_proj}: Exact version ${${_depname}_find_ver} required but version ${${_depname}_ver} found.")
        endif(NOT "${_cmp}" EQUAL "0")
    else(${_depname}_FIND_VERSION_EXACT)
        if("${_cmp}" EQUAL "-1")
            set("${_foundvar}" FALSE)
            message(STATUS "${_proj}: Version >= ${${_depname}_find_ver} required but version ${${_depname}_ver} found.")
        elseif("${_cmp}" EQUAL "1")
            if(NOT "${${_depname}_FIND_VERSION_MAJOR}" STREQUAL "${${_depname}_VERSION_MAJOR}")
                set("${_foundvar}" FALSE)
                message(STATUS "${_proj}: ${${_depname}_ver} is >= ${${_depname}_find_ver}, as required, but major versions ${${_depname}_VERSION_MAJOR} and ${${_depname}_FIND_VERSION_MAJOR} do not match.")
            endif(NOT "${${_depname}_FIND_VERSION_MAJOR}" STREQUAL "${${_depname}_VERSION_MAJOR}")
        endif("${_cmp}" EQUAL "-1")
    endif(${_depname}_FIND_VERSION_EXACT)
endmacro(m_check_version _proj _depname _foundvar)
macro(m_req_dep _name _depname _exactornot _ver _foundvar)
    macro_version_major_number("${_ver}" _major)
    macro_version_minor_number("${_ver}" _minor)
    macro_version_patch_number("${_ver}" _patch)
    set(${_foundvar} TRUE)
    if(NOT ${_depname}_FOUND)
        message(STATUS "${_name}: ${_depname}_FOUND=${${_depname}_FOUND}: ${_depname} is a required dependency for ${_name}.")
        set(${_foundvar} FALSE)
    else(NOT ${_depname}_FOUND)
        set(${_depname}_FIND_VERSION_MAJOR "${_major}")
        set(${_depname}_FIND_VERSION_MINOR "${_minor}")
        set(${_depname}_FIND_VERSION_PATCH "${_patch}")
        set(${_depname}_FIND_VERSION_EXACT FALSE)
        if("${_exactornot}" STREQUAL "EXACT")
            set(${_depname}_FIND_VERSION_EXACT TRUE)
        endif("${_exactornot}" STREQUAL "EXACT")
        m_check_version("${_p}" "${_depname}" "${_foundvar}")
    endif(NOT ${_depname}_FOUND)
    if(NOT "${_foundvar}")
        set(${_proj}_found FALSE)
    endif(NOT "${_foundvar}")
endmacro(m_req_dep _name _depname _exactornot _ver _foundvar)
macro(m_log_var)
    foreach(_i ${ARGN})
        message(STATUS "${_i}=${${_i}}")
    endforeach(_i ${ARGN})
endmacro(m_log_var)



set(generic_export_dir)
if(NOT "${EXPORT_ROOT_DIR}" STREQUAL "")
    set(generic_export_dir "${EXPORT_ROOT_DIR}/lib/${_p}")
endif(NOT "${EXPORT_ROOT_DIR}" STREQUAL "")
set(${_p}_export_dir
${${_P}_EXPORT_DIR}
$ENV{${_P}_EXPORT_DIR}
${generic_export_dir}
"/usr/local/lib/${_p}"
"/usr/lib/${_p}"
"/opt/${_p}/lib/${_p}"
"C:\\${_p}\\lib\\${_p}"
"C:\\Program Files\\${_p}\\lib\\${_p}"
)

set(${_p}_export_filename "$ENV{${_P}_EXPORT_FILENAME}")
if(NOT "${${_P}_EXPORT_FILENAME}" STREQUAL "")
    set(${_p}_export_filename "${${_P}_EXPORT_FILENAME}")
endif(NOT "${${_P}_EXPORT_FILENAME}" STREQUAL "")
if(NOT ${_p}_export_filename)
    set(${_p}_export_filename "Export${_p}.cmake")
endif(NOT ${_p}_export_filename)

if(${_p}_export_dir)
    find_file(${_p}_EXPORT "${${_p}_export_filename}"
      HINTS ${${_p}_export_dir}
    )
else(${_p}_export_dir)
    find_file(${_p}_EXPORT "${${_p}_export_filename}")
endif(${_p}_export_dir)
set(${_P}_EXPORT "${${_p}_EXPORT}")

if(${_p}_EXPORT)
    include(${${_p}_EXPORT})
    set(${_P}_INCLUDE_DIRS ${${_p}_INCLUDE_DIRS})
    if(NOT ${_p}_no_libs)
        setu(${_p}_LIBRARIES ${${_p}_LIBRARIES} ${_p}_export_${_p}${${_p}_default_lib_type})
        setu(${_p}_LIBRARY ${${_p}_LIBRARIES})
        if(${_p}_shared_libs)
            setu(${_p}_SHARED_LIBRARIES ${${_p}_SHARED_LIBRARIES} ${_p}_export_${_p}_shared)
            setu(${_p}_SHARED_LIBRARY ${${_p}_SHARED_LIBRARIES})
        endif(${_p}_shared_libs)
        if(${_p}_static_libs)
            setu(${_p}_STATIC_LIBRARIES ${${_p}_STATIC_LIBRARIES} ${_p}_export_${_p}_static)
            setu(${_p}_STATIC_LIBRARY ${${_p}_STATIC_LIBRARIES})
        endif(${_p}_static_libs)
    endif(NOT ${_p}_no_libs)
    find_file(${_p}_config_h "${_p}/${${_p}_config_header}"
        HINTS ${${_p}_INCLUDE_DIRS}
    )
    if(${_p}_config_h)
        file(STRINGS "${${_p}_config_h}" ${_p}_config_h_strings)
        foreach(_l ${${_p}_config_h_strings})
            string(REGEX
                MATCH "^#[ \t]*define[ \t]+${_P}_VERSION_STR[ \t]+\"(.*)\""
                ${_p}_version_match "${_l}"
            )
            if(${_p}_version_match)
                break()
            endif(${_p}_version_match)
        endforeach(_l ${${_p}_config_h_strings})
        if(${_p}_version_match)
            string(REGEX REPLACE ".*\"(.*)\".*" "\\1" ${_p}_version "${${_p}_version_match}")
            string(REGEX REPLACE "^([0-9]+)\\.[0-9]+\\.[0-9]+$"
                "\\1" ${_p}_VERSION_MAJOR "${${_p}_version}")
            string(REGEX REPLACE "^[0-9]+\\.([0-9]+)\\.[0-9]+$"
                "\\1" ${_p}_VERSION_MINOR "${${_p}_version}")
            string(REGEX REPLACE "^[0-9]+\\.[0-9]+\\.([0-9]+)$"
                "\\1" ${_p}_VERSION_PATCH "${${_p}_version}")
            set(${_p}_VERSION_STRING "${${_p}_VERSION_MAJOR}.${${_p}_VERSION_MINOR}.${${_p}_VERSION_PATCH}")
        else(${_p}_version_match)
            message(STATUS "${_p}: Could not read version number from ${_p}/config.h")
            set(${_p}_found FALSE)
        endif(${_p}_version_match)
    else(${_p}_config_h)
        message(STATUS "${_p}: Could not find header file: ${_p}/config.h")
        set(${_p}_found FALSE)
    endif(${_p}_config_h)

    if(${_p}_FIND_VERSION)
        m_check_version("${_p}" "${_p}" "${_p}_found")
    endif(${_p}_FIND_VERSION)

    if(${_p}_no_libs)
        if(${_p}_INCLUDE_DIRS AND ${_p}_found)
            setu(${_p}_FOUND TRUE)
        endif(${_p}_INCLUDE_DIRS AND ${_p}_found)
    else(${_p}_no_libs)
        if(${_p}_INCLUDE_DIRS AND ${_p}_LIBRARIES AND ${_p}_found)
            setu(${_p}_FOUND TRUE)
        endif(${_p}_INCLUDE_DIRS AND ${_p}_LIBRARIES AND ${_p}_found)
    endif(${_p}_no_libs)
else(${_p}_EXPORT)
    message(STATUS "${_p}: Could not find ${${_p}_export_filename}")
    set(${_p}_found FALSE)
endif(${_p}_EXPORT)

endif(NOT ${_p}_FOUND)

if (${_p}_FOUND)
  if (NOT ${_p}_FIND_QUIETLY)
    if(${_p}_no_libs)
      message(STATUS "${_p}: Found ${_p} ${${_p}_VERSION_STRING}: INLCUDE_DIRS=${${_p}_INCLUDE_DIRS}")
    else(${_p}_no_libs)
      message(STATUS "${_p}: Found ${_p} ${${_p}_VERSION_STRING}: INLCUDE_DIRS=${${_p}_INCLUDE_DIRS} LIBRARIES=${${_p}_LIBRARIES}")
    endif(${_p}_no_libs)
  endif (NOT ${_p}_FIND_QUIETLY)
else (${_p}_FOUND)
  if (${_p}_FIND_REQUIRED)
    message(SEND_ERROR "${_p}: Not found or failure in requirements.")
  endif (${_p}_FIND_REQUIRED)
endif (${_p}_FOUND)


