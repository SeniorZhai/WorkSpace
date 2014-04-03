//
//  WelcomeScene.h
//  flappybird
//
//  Created by 翟涛 on 14-4-3.
//
//

#ifndef __flappybird__WelcomeScene__
#define __flappybird__WelcomeScene__

#include "WelcomeLayer.h"
#include "BackgroundLayer.h"
#include "cocos2d.h"
using namespace cocos2d;
using namespace std;

class WelcomeScene : public Scene{
public:
	WelcomeScene(void);
	~WelcomeScene(void);
	bool virtual init();
	CREATE_FUNC(WelcomeScene);
};

#endif /* defined(__flappybird__WelcomeScene__) */
