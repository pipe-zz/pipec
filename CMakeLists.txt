cmake_minimum_required(VERSION 2.8)
project(pipec)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(LLVM_VERSION "3.4.2")
set(LLVM_DOWNLOAD_URL_FILENAME "llvm-${LLVM_VERSION}.src.tar.gz")
set(LLVM_DOWNLOAD_URL "http://llvm.org/releases/${LLVM_VERSION}/${LLVM_DOWNLOAD_URL_FILENAME}")
set(LLVM_SRC_DIR "${CMAKE_BINARY_DIR}/llvm-${LLVM_VERSION}.src")
set(LLVM_CMAKE_BIN_DIR "${CMAKE_BINARY_DIR}/llvm-${LLVM_VERSION}.bin")
set(LLVM_INSTALL_DIR "${CMAKE_BINARY_DIR}/llvm-${LLVM_VERSION}")

if(EXISTS ${LLVM_SRC_DIR})
	
else()
	
	file(MAKE_DIRECTORY ${LLVM_SRC_DIR})
	file(DOWNLOAD ${LLVM_DOWNLOAD_URL} "${CMAKE_BINARY_DIR}/${LLVM_DOWNLOAD_URL_FILENAME}")
	
	execute_process(
		COMMAND ${CMAKE_COMMAND} -E tar xzf ${CMAKE_BINARY_DIR}/${LLVM_DOWNLOAD_URL_FILENAME} ${LLVM_SRC_DIR}
	)
		
	message("Building llvm ${LLVM_VERSION}...")

	file(MAKE_DIRECTORY ${LLVM_CMAKE_BIN_DIR})

	execute_process(
	COMMAND ${CMAKE_COMMAND} ${LLVM_SRC_DIR} -G ${CMAKE_GENERATOR} -DCMAKE_INSTALL_PREFIX=${LLVM_INSTALL_DIR} -DCMAKE_BUILD_TYPE=Release
	WORKING_DIRECTORY ${LLVM_CMAKE_BIN_DIR}
	)
	
endif()

if(EXISTS ${LLVM_INSTALL_DIR})

else()
	
	file(MAKE_DIRECTORY ${LLVM_INSTALL_DIR})

	execute_process(
		COMMAND ${CMAKE_COMMAND} --build .
		WORKING_DIRECTORY ${LLVM_CMAKE_BIN_DIR}
	)
	
	
	execute_process(
		COMMAND ${CMAKE_COMMAND} -P ${LLVM_CMAKE_BIN_DIR}/cmake_install.cmake
		OUTPUT_QUIET
	)

endif()

include(./cmake/gen_ycm_conf.cmake)

message("Building Pipe...")
include_directories(${LLVM_INSTALL_DIR}/include)
include_directories("include")
link_directories(${LLVM_INSTALL_DIR}/lib)

set(LIBPIPE_HEADERS
	"include/pipe/module.h"
)

set(LIBPIPE_SOURCES
	"src/module.cpp"
)

set(PIPEC_SOURCES
	"src/main.cpp"
)

execute_process(
	COMMAND ${LLVM_INSTALL_DIR}/bin/llvm-config --libs
	OUTPUT_VARIABLE LLVM_LIBS_STR
)

execute_process(
	COMMAND ${LLVM_INSTALL_DIR}/bin/llvm-config --ldflags
	OUTPUT_VARIABLE LLVM_LDLIBS_STR
)

string(REPLACE "-l" "" LLVM_LIBS_STR "${LLVM_LIBS_STR}${LLVM_LDLIBS_STR}")
string(REPLACE " " ";" LLVM_LIBS_STR "${LLVM_LIBS_STR}")
string(REPLACE "\n" ";" LLVM_LIBS "${LLVM_LIBS_STR}")

message("${LLVM_LIBS}")

add_library(pipe SHARED ${LIBPIPE_SOURCES} ${LIBPIPE_HEADERS})
target_link_libraries(pipe ${LLVM_LIBS})

add_executable(pipec ${PIPEC_SOURCES})
target_link_libraries(pipec pipe)
