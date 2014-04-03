//
//  WelcomeLayer.cpp
//  flappybird
//
//  Created by 翟涛 on 14-4-3.
//
//

#include "WelcomeLayer.h"

WelcomeLayer::WelcomeLayer(){};

WelcomeLayer::~WelcomeLayer(){};

bool WelcomeLayer::init(){
	if(!Layer::init()){
		return false;
	}
//    Size visiableSize = Director::getInstance()->getVisibleSize();
//    Point origin = Director::getInstance()->getVisibleOrigin();
    
    time_t t = time(NULL);
    tm* lt = localtime(&t);
    int hour = lt->tm_hour;
    
    Sprite *background;
    if (hour >= 6 && hour <= 17) {
        background = Sprite::createWithSpriteFrame(AtlasLoader::getInstance()->getSpriteFrameByName("bg_day"));
//        background = Sprite::createWithSpriteFrame(SpriteFrameCache::getInstance()->getSpriteFrameByName("bg_day"));
    }else{
        background = Sprite::createWithSpriteFrame(AtlasLoader::getInstance()->getSpriteFrameByName("bg_night"));
//        background = Sprite::createWithSpriteFrame(SpriteFrameCache::getInstance()->getSpriteFrameByName("bg_night"));
    }
    Size size = background->getContentSize();
    log("%f",size.width);
    background->setAnchorPoint(Point::ZERO);
    background->setPosition(Point::ZERO);
    this->addChild(background);

    return true;
}

void WelcomeLayer::menuStartCallback(void *sender){
    
}