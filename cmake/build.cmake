if(string(COMPARE EQUAL ${CMAKE_BINARY_DIR} ${CMAKE_SOURCE_DIR}))
	message(FATAL "Do NOT use source directory as build directory!")
endif()

