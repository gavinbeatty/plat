project(plat C)
cmake_minimum_required(VERSION 2.6)
if(POLICY CMP0011)
    cmake_policy(SET CMP0011 NEW)
endif(POLICY CMP0011)

set(CMAKE_MODULE_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmakefiles"
    ${CMAKE_MODULE_PATH})
include(CmfInstallPrefix)
include(CmfLogVar)
include(CmfDeleteInstalled)
include(CmfSetDefaultInstallDirs)
include(CmfSetBuildType)
include(CmfSystemOrLocalDep)
include(CmfOption)

cmf_set_build_type()

set(pn "${PROJECT_NAME}")
set(${pn}_srcdir "${CMAKE_CURRENT_SOURCE_DIR}")
set(${pn}_builddir "${CMAKE_CURRENT_BINARY_DIR}")
string(TOUPPER "${pn}" PN)

cmf_option(${PN}_ENABLE_TESTS "Build tests." ON)

cmf_set_default_install_dirs()

cmf_install_prefix(${pn}_prefix)
cmf_log_var(${pn}_prefix)

set(${pn}_VERSION_MAJOR 1)
set(${pn}_VERSION_MINOR 5)
set(${pn}_VERSION_PATCH 0)
set(${pn}_VERSION_STR "${${pn}_VERSION_MAJOR}.${${pn}_VERSION_MINOR}.${${pn}_VERSION_PATCH}")

set(${pn}_VENDOR_STR "Gavin Beatty")
set(${pn}_CONTACT_STR "Gavin Beatty <gavinbeatty@gmail.com>")
set(${pn}_HOMEPAGE_STR "http://code.google.com/p/plat/")
set(${pn}_DESCRIPTION_STR "Platform detection headers for C/C++.")

configure_file("${${pn}_srcdir}/src/${pn}/config.h.in"
               "${${pn}_builddir}/src/${pn}/config.h"
               @ONLY)
set(include_dirs "${CMAKE_INSTALL_PREFIX}/${${pn}_includedir}")
configure_file("${${pn}_srcdir}/Export${pn}.cmake.in"
               "${${pn}_builddir}/Export${pn}.cmake"
               @ONLY)
set(build_include_dirs
"${CMAKE_CURRENT_SOURCE_DIR}/src"
"${CMAKE_CURRENT_BINARY_DIR}/src"
)
configure_file("${${pn}_srcdir}/BuildExport${pn}.cmake.in"
               "${${pn}_builddir}/BuildExport${pn}.cmake"
               @ONLY)
set(description_str "${${pn}_DESCRIPTION_STR}")
set(version_str "${${pn}_VERSION_STR}")
set(homepage_str "${${pn}_HOMEPAGE_STR}")
set(libdir "${${pn}_libdir}")
set(includedir "${${pn}_includedir}")
configure_file("${${pn}_srcdir}/${pn}.pc.in"
               "${${pn}_builddir}/${pn}.pc"
               @ONLY)
set(name "${pn}")
string(TOUPPER "${name}" NAME)
string(REGEX REPLACE "." " " empty "${name}")
set(no_libs TRUE)
set(config_header "config.h")
file(READ "cmake/cmakefiles/CmfVersionCmp.cmake" cmf_version_str)
set(deps_code "")
configure_file("${${pn}_srcdir}/cmake/cmakefiles/FindGeneric.cmake.in"
               "${${pn}_srcdir}/Find${pn}.cmake"
               @ONLY)


set(${pn}_HDRS
"${${pn}_builddir}/src/${pn}/config.h"
src/${pn}/cc.h
src/${pn}/endian.h
src/${pn}/os.h
src/${pn}/${pn}.h
)

if(${PN}_ENABLE_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif(${PN}_ENABLE_TESTS)

if(NOT ${PN}_NO_INSTALL)
install(FILES           ${${pn}_HDRS}
        DESTINATION     "${${pn}_projincludedir}"
)
cmf_delete_installed("${${pn}_cmakeexportdir}/Export${pn}-*.cmake")
install(FILES           "${${pn}_builddir}/Export${pn}.cmake"
        DESTINATION     "${${pn}_cmakeexportdir}"
)
install(FILES           "${${pn}_srcdir}/Find${pn}.cmake"
        DESTINATION     "${${pn}_cmakefindpkgdir}"
)
install(FILES           "${${pn}_builddir}/${pn}.pc"
        DESTINATION     "${${pn}_pkgconfigdir}"
)
endif(NOT ${PN}_NO_INSTALL)


