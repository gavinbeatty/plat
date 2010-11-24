project(plat C)
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
set(CMAKE_MODULE_PATH
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmakefiles"
  ${CMAKE_MODULE_PATH}
)

include(CmfConfigureFile)
include(CmfInstallPrefix)
include(CmfSetBuildType)
include(CmfOption)

#########################
# Project Configuration #
#########################
include(ProjectDetails)

set(pn "${PROJECT_NAME}")
set(${pn}_srcdir "${CMAKE_CURRENT_SOURCE_DIR}")
set(${pn}_builddir "${CMAKE_CURRENT_BINARY_DIR}")
string(TOUPPER "${pn}" PN)

# configure install dirs etc.
cmf_configure_install_prefix(
  ${pn}
  "${${pn}_srcdir}"
  "${${pn}_builddir}}"
  "${pn}_install_prefix_file"
)
include("${${pn}_install_prefix_file}")

# config.h
cmf_configure_file(
  ${pn}
  "${${pn}_srcdir}/src/${pn}/config.h.in"
  "${${pn}_builddir}/src/${pn}/config.h"
)

# CMake Export
set(${pn}_include_dirs "${${pn}_install_include_proj}")
cmf_configure_file(
  ${pn}
  "${${pn}_srcdir}/Export${pn}.cmake.in"
  "${${pn}_builddir}/Export${pn}.cmake"
)

# CMake Build Export
set(${pn}_build_include_dirs
  "${${pn}_srcdir}/src"
  "${${pn}_builddir}/src"
)
cmf_configure_file(
  ${pn}
  "${${pn}_srcdir}/BuildExport${pn}.cmake.in"
  "${${pn}_builddir}/BuildExport${pn}.cmake"
)

# pkgconfig
# XXX set some variables
cmf_configure_file(
  ${pn}
  "${${pn}_srcdir}/${pn}.pc.in"
  "${${pn}_builddir}/${pn}.pc"
)

# Find.cmake
cmf_configure_file(
  ${pn}
  "${${pn}_srcdir}/cmake/cmakefiles/FindGeneric.cmake.in"
  "${${pn}_srcdir}/Find${pn}.cmake"
)


set(${pn}_hdrs
"${${pn}_builddir}/src/${pn}/config.h"
src/${pn}/cc.h
src/${pn}/endian.h
src/${pn}/os.h
src/${pn}/${pn}.h
)

enable_testing()
add_subdirectory(tests)

install(FILES           ${${pn}_hdrs}
        DESTINATION     "${${pn}_install_include_proj}"
)
install(FILES           "${${pn}_builddir}/Export${pn}.cmake"
        DESTINATION     "${${pn}_install_cmakeexport_proj}"
)
install(FILES           "${${pn}_srcdir}/Find${pn}.cmake"
        DESTINATION     "${${pn}_install_cmakefind}"
)
install(FILES           "${${pn}_builddir}/${pn}.pc"
        DESTINATION     "${${pn}_install_pkgconfig}"
)

