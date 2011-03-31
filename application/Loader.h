#ifndef __LOADER_H
#define __LOADER_H

#include "RedBoxEngine.h"
#include "PlayState.h"

namespace RedBox {
	class Loader  {
	public:
		static void load(){
			//Setup and add your first state here
			RedBoxEngine::addState(new PlayState());
		}
	};
}
#endif
