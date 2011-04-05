#ifndef __LOADER_H
#define __LOADER_H

#include <RedBox.h>


namespace RedBox {
	class Loader  {
	public:
		static void load(){
			//Setup and add your first state here
			RedBoxEngine::addState(new State());
		}
	};
}
#endif
