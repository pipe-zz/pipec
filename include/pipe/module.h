#ifndef PIPE_MODULE_H
#define PIPE_MODULE_H

#include <string>

namespace pipe {
	class module {
	public:
		
		static module create_from_file(std::string path);
		static module create_from_source(std::string src);
	};
}

#endif//PIPE_MODULE_H
