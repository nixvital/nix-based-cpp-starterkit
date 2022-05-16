include(CMakeParseArguments)

function(make_cc_test)
    if (NOT ENABLE_TESTING)
        return()
    endif()

    cmake_parse_arguments(MAKE_CC_TEST
        ""
        "NAME"
        "SRCS;DEPS;DATA"
        ${ARGN})

    set(_NAME "${MAKE_CC_TEST_NAME}")

    add_executable(${_NAME})
    target_sources(${_NAME} PRIVATE ${MAKE_CC_TEST_SRCS})
    target_link_libraries(${_NAME}
        PRIVATE ${MAKE_CC_TEST_DEPS} gtest gmock gtest_main)
    gtest_discover_tests(${_NAME})


    file(RELATIVE_PATH _DEST_DIR ${PROJECT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
    install(TARGETS ${_NAME} DESTINATION tests/${_DEST_DIR})
    foreach (_DATA_FILE ${MAKE_CC_TEST_DATA})
        get_filename_component(SUBPATH ${_DATA_FILE} DIRECTORY)
        install(FILES ${_DATA_FILE} DESTINATION tests/${_DEST_DIR}/${SUBPATH})
        configure_file(${_DATA_FILE} ${_DATA_FILE} COPYONLY)
    endforeach()
    
endfunction()
