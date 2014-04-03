//
//  LoadingScene.h
//  flappybird
//
//  Created by 翟涛 on 14-4-3.
//
//


#ifndef __flappybird__LoadingScene__
#define __flappybird__LoadingScene__
#include "cocos2d.h"
#include "SimpleAudioEngine.h"
#include "AtlasLoader.h"

using namespace CocosDenshion;
USING_NS_CC;

class LoadingScene : public Scene{
public:
    LoadingScene();
    ~LoadingScene();
    
    virtual bool init();
    CREATE_FUNC(LoadingScene);
    
    void onEnter() override;
private:
    void loadingCallBack(Texture2D *texture);
};

#endif /* defined(__flappybird__LoadingScene__) */
