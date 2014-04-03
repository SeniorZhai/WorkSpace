//
//  LoadingScene.cpp
//  flappybird
//
//  Created by 翟涛 on 14-4-3.
//
//

#include "LoadingScene.h"
#include "WelcomeScene.h"
LoadingScene::LoadingScene(){}
LoadingScene::~LoadingScene(){}

bool LoadingScene::init(){
    if (Scene::init()) {
        return true;
    }else{
        return false;
    }
}

void LoadingScene::onEnter(){
    Sprite *background = Sprite::create("splash.png");
    Size visibleSize = Director::getInstance()->getVisibleSize();
    Point origin = Director::getInstance()->getVisibleOrigin();
	background->setPosition(origin.x + visibleSize.width/2, origin.y + visibleSize.height/2);
    this->addChild(background);
    Director::getInstance()->getTextureCache()->addImageAsync("Image.png", CC_CALLBACK_1(LoadingScene::loadingCallBack,this));
}
void LoadingScene::loadingCallBack(Texture2D *texture){
   
    AtlasLoader::getInstance()->loadAtlas("atlas.txt", texture);
    
    SimpleAudioEngine::getInstance()->preloadEffect("sfx_die.ogg");
	SimpleAudioEngine::getInstance()->preloadEffect("sfx_hit.ogg");
	SimpleAudioEngine::getInstance()->preloadEffect("sfx_point.ogg");
	SimpleAudioEngine::getInstance()->preloadEffect("sfx_swooshing.ogg");
	SimpleAudioEngine::getInstance()->preloadEffect("sfx_wing.ogg");
    auto scene = WelcomeScene::create();
	TransitionScene *transition = TransitionFade::create(1, scene);
	Director::getInstance()->replaceScene(transition);

}