# Unit tests 
#################################################################################
include_directories( ${_INCLUDE_DIR} )

# creates teste_01.cpp file ####################################################
message( "!-- Generated default unit test in file:\n    ${_UNIT_TEST_DIR}/test_01.cpp ..." )
configure_file( "${PROJECT_SOURCE_DIR}/cmake/test_01.cpp.in" "${_UNIT_TEST_DIR}/test_01.cpp" )

# creates all tests entries ####################################################
message( "!-- Generating build configuration to unit tests..." )

enable_testing()
file( GLOB _UNIT_TEST_SOURCES "${_UNIT_TEST_DIR}/*.cpp" )
foreach( _UNIT_TEST_SOURCE IN LISTS _UNIT_TEST_SOURCES )
  string( REPLACE "${_UNIT_TEST_DIR}/" "" _UNIT_TEST_SOURCE_WITHOUT_PATH "${_UNIT_TEST_SOURCE}" )
  string( REPLACE ".cpp" "" _TARGET_UNIT_TEST "${_UNIT_TEST_SOURCE_WITHOUT_PATH}" )   
  add_executable( ${_TARGET_UNIT_TEST} "${_UNIT_TEST_SOURCE}" )
  target_link_libraries( ${_TARGET_UNIT_TEST} ${_LIBRARY_NAME} )
  
  # adds a basic test without arguments for each unit test #
  add_test( "${_TARGET_UNIT_TEST}_0_ARG" "${EXECUTABLE_OUTPUT_PATH}/${_TARGET_UNIT_TEST}" )
endforeach( _UNIT_TEST_SOURCE )

# Configure below all custom unit tests like examples below #
add_test( test_01_1_ARG "${EXECUTABLE_OUTPUT_PATH}/test_01" 1 )
add_test( test_01_2_ARG "${EXECUTABLE_OUTPUT_PATH}/test_01" 1 20 )