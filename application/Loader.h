#ifndef __LOADER_H
#define __LOADER_H
#include "State.h"
namespace RedBox {

	class Loader  {
	public:
		Loader();
	private:
		State * firstState;
	};
}
#endif
