//
//  WelcomeScene.cpp
//  flappybird
//
//  Created by 翟涛 on 14-4-3.
//
//

#include "WelcomeScene.h"

WelcomeScene::WelcomeScene(){};

WelcomeScene::~WelcomeScene(){};

bool WelcomeScene::init(){
	bool bRet = false;
	do{
		CC_BREAK_IF(!Scene::init());
		auto _welcomeLayer = WelcomeLayer::create();
		//auto _welcomeLayer = StatusLayer::create();
		CC_BREAK_IF(!_welcomeLayer);
		this->addChild(_welcomeLayer);
		bRet = true;
	}while(0);
	return bRet;
}