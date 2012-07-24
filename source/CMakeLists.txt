# library 
#######################################

# make default configuration ##########
include( configure_lib )

# setup project compilation ###########
include_directories( ${_INCLUDE_DIR} )
file( GLOB _HEADERS          "${_INCLUDE_DIR}/*${_HEADER_EXT}" )
file( GLOB _PRIVATE_HEADERS  "${_SOURCE_DIR}/*${_HEADER_EXT}" )
file( GLOB _SOURCES          "${_SOURCE_DIR}/*.cpp" )
add_library( ${_LIBRARY_NAME} STATIC ${_PRIVATE_HEADERS} ${_HEADERS} ${_SOURCES} ) 

# lib instalation ######################
if( MSVC )
  install( TARGETS ${_LIBRARY_NAME} ARCHIVE DESTINATION lib )
else( MSVC )
  install( TARGETS ${_LIBRARY_NAME} ARCHIVE DESTINATION lib )
endif( MSVC )

# external public headers instalation ##
install( FILES ${_HEADERS} DESTINATION include )
