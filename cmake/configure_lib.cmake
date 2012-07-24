# creates a master public header ################################################################
set( _LIBRARY_MASTER_HEADER "${_INCLUDE_DIR}/${_LIBRARY_NAME}${_HEADER_EXT}" )

# creates info.cpp file #########################################################################
configure_file( "${CMAKE_MODULE_PATH}/libraryinfo.h.in"   "${_INCLUDE_DIR}/libraryinfo.${_HEADER_EXT}" )
configure_file( "${CMAKE_MODULE_PATH}/libraryinfo.cpp.in" "${_SOURCE_DIR}/libraryinfo.cpp" )
message( "!-- Generated information class LibraryInfo_t ..." )

# create a list with all headers in public /include folder #
set( _INCLUDE_LIST "" )
file( GLOB __HEADER_LIST "${_INCLUDE_DIR}/*${_HEADER_EXT}" )

if( __HEADER_LIST )
  string( REPLACE "${_INCLUDE_DIR}/" " " __HEADER_LIST ${__HEADER_LIST} ) 
  string( STRIP "${__HEADER_LIST}" __HEADER_LIST )
  string( REPLACE " " ";" __HEADER_LIST ${__HEADER_LIST} ) 
  list( REMOVE_ITEM __HEADER_LIST "${_LIBRARY_NAME}${_HEADER_EXT}" )

  foreach( __HEADER_FILE IN LISTS __HEADER_LIST )
    set( _INCLUDE_LIST "\n#include \"${__HEADER_FILE}\"${_INCLUDE_LIST}" )
  endforeach( __HEADER_FILE )
endif(  __HEADER_LIST ) 

configure_file( "${CMAKE_MODULE_PATH}/make_master_header.in" "${_LIBRARY_MASTER_HEADER}" @ONLY )
message( "!-- Generated master header file:\n    ${_INCLUDE_DIR}/${_LIBRARY_NAME}${_HEADER_EXT} ..." )

# creates a configuration header ################################################################
set( _LIBRARY_CONFIGURATION_HEADER "${_SOURCE_DIR}/${_LIBRARY_NAME}_config${_HEADER_EXT}" )
configure_file( "${CMAKE_MODULE_PATH}/make_config_header.in" "${_LIBRARY_CONFIGURATION_HEADER}" @ONLY)
message( "!-- Generated configuration header file:\n    ${_LIBRARY_CONFIGURATION_HEADER} ..." )

