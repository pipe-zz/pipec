#define __STDC_LIMIT_MACROS
#define __STDC_CONSTANT_MACROS

#include <string>
#include <vector>
#include <fstream>
#include <iostream>

#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/Assembly/Parser.h>
#include <llvm/IRReader/IRReader.h>

#include <pipe/module.h>

int main(int argc, char* argv[]) {
	
	std::vector<std::string> args;
	for(int i=0; argc > i; i++) { args.push_back(argv[i]); }
	
	bool bJIT = false;
	pipe::module module;
	std::vector<std::string> srcPaths;
	
	for(auto& arg : args) {
		if(arg == "-jit") {
			bJIT = true;
			break;
		} else
		if(arg[0] != '-') {
			module.load_from_file(arg.substr(1));
			
		} else {
			std::cout << "[pipec] Ignorning invalid command '" << arg.substr(1) << "'\n";
		}
	}
	
	if(bJIT) {
		if(srcPaths.empty()) {
			
		} else {
			
		}
	}
	
	return 0;
}
