//
//  WelcomeLayer.h
//  flappybird
//
//  Created by 翟涛 on 14-4-3.
//
//

#ifndef __flappybird__WelcomeLayer__
#define __flappybird__WelcomeLayer__
#include "AtlasLoader.h"
#include "SimpleAudioEngine.h"
#include "time.h"
#include "cocos2d.h"

using namespace cocos2d;
using namespace std;
using namespace CocosDenshion;

const int START_BUTTON_TAG = 100;

class WelcomeLayer : public Layer{
public:
    WelcomeLayer();
    ~WelcomeLayer();
    virtual bool init();
    CREATE_FUNC(WelcomeLayer);
private:
    void menuStartCallback(void *sender);
    void scrollLand(float dt);
    
    Sprite *land1;
    Sprite *land2;
};

#endif /* defined(__flappybird__WelcomeLayer__) */
