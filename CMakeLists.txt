#-------------------------------------------------------------------------------------------------
# Folder project structure
# + project 
#   - include = Where you put all public headers   
#   - source  = Where you put all source and private headers
#   - tests   = Where you put all unit tests coded to validate this library
#   - doc     = Where is automatic generated private documentation (if you installed Doxygen)
#   - cmake   = Where are some scripts to CMake use in automatic generations
#-------------------------------------------------------------------------------------------------

# project_template_lib_cpp
###############################################################
cmake_minimum_required ( VERSION 2.8 ) 
set( _PROJECT_NAME    "project_template_lib_cpp" )
string( TOUPPER ${_PROJECT_NAME} _PROJECT_NAME_UPPER )
project( ${_PROJECT_NAME} ) 

set( _PROJECT_VERSION "0.0.1" )

set( _LIBRARY_NAME ${_PROJECT_NAME} )
string( TOUPPER ${_LIBRARY_NAME} _LIBRARY_NAME_UPPER )

set( _INCLUDE_DIR   ${PROJECT_SOURCE_DIR}/include )
set( _SOURCE_DIR    ${PROJECT_SOURCE_DIR}/source )
set( _DOCUMENT_DIR  ${PROJECT_SOURCE_DIR}/doc )
set( _UNIT_TEST_DIR ${PROJECT_SOURCE_DIR}/tests )

# global default header extension ##########
set( _HEADER_EXT   ".h" )

# set cmake macros and scritps path #
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake" )

# set visual studio static c runtime use ###
include( static_vslibs )

# configure basic unit tests #################
enable_testing()
include( CTest )

# source directory #########################
add_subdirectory( source )

# tests directory ##########################
add_subdirectory( tests )

# Document generation, if Doxygen installed #
find_package(Doxygen)
if(DOXYGEN_FOUND)
  # Extenal documentation # Generated only during Packaging/Instalation phase #
  set( _DOCUMENT_TITLE "${_PROJECT_NAME}" )
  set( _INPUT_DOC ${_INCLUDE_DIR} )
  set( SHOW_INTERNAL_DOCS "NO" )
  configure_file(${_DOCUMENT_DIR}/Doxyfile.in ${PROJECT_SOURCE_DIR}/Doxyfile_public @ONLY)
  
  # Internal documentation # 
  set( _DOCUMENT_TITLE "${_DOCUMENT_TITLE} - Only for ${_PROJECT_NAME} Maintenance Team" )
  set( _INPUT_DOC "${_INPUT_DOC} ${_SOURCE_DIR}" )
  set( SHOW_INTERNAL_DOCS "YES" )
  configure_file( ${_DOCUMENT_DIR}/Doxyfile.in ${PROJECT_SOURCE_DIR}/Doxyfile_Internal @ONLY)
  add_custom_target( GENERATE_INTERNAL_DOC ${DOXYGEN_EXECUTABLE} ${PROJECT_SOURCE_DIR}/Doxyfile_Internal WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/doc COMMENT "Generating internal API documentation with Doxygen..." )

  # doc build and instalation #
  install( CODE "EXECUTE_PROCESS( COMMAND \"${DOXYGEN_EXECUTABLE}\" ../Doxyfile_public WORKING_DIRECTORY ${_DOCUMENT_DIR} )" )  
  install( DIRECTORY "${_DOCUMENT_DIR}/html" DESTINATION doc )  
endif(DOXYGEN_FOUND)

# package configuration ####################################################  
set( CPACK_PACKAGE_VERSION_MAJOR "0" )
set( CPACK_PACKAGE_VERSION_MINOR "0" )
set( CPACK_PACKAGE_VERSION_PATCH "1" )  

set( CPACK_PACKAGE_FILE_NAME ${PROJECT_NAME} ) 
if( WIN32 ) 
  set( CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}.win32" )
else( WIN32 ) 
  if( APPLE )
    set( CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}.darwin" )
  else( APPLE )
    set( CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}.unix" )
  endif( APPLE )
endif( WIN32 )

set( CPACK_GENERATOR "ZIP" )
include( CPack )

