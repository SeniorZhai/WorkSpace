//
//  BridSprite.cpp
//  flappybird
//
//  Created by 翟涛 on 14-4-4.
//
//

#include "BridSprite.h"

BirdSprite::BirdSprite(){}
BirdSprite::~BirdSprite(){}

BirdSprite * BirdSprite::shareBirdSprite = nullptr;
BirdSprite* BirdSprite::getInstance(){
    if (shareBirdSprite == NULL) {
        shareBirdSprite = new BirdSprite();
        if (!shareBirdSprite->init()) {
            delete (shareBirdSprite);
            shareBirdSprite = NULL;
            CCLOG("ERROR:Could not init shareBirdSprite");
        }
    }
    return shareBirdSprite;
}

bool BirdSprite::init(){
    this->isFirstTime = 3;
    return true;
}

bool BirdSprite::createdBird(){
    this->createBirdByRandom();
    if (Sprite::initWithSpriteFrame(AtlasLoader::getInstance()->getSpriteFrameByName(this->birdName))) {
        Animation* animation = this->createAnimation(this->birdNameFormat.c_str(), 3, 10);
        Animate* animate = Animate::create(animation);
        this->idleAction = RepeatForever::create(animate);
        
        ActionInterval *up = MoveBy::create(0.4f, Point(0,8));
        ActionInterval *upBack = up->reverse();
        this->swingAction = RepeatForever::create(Sequence::create(up, upBack, NULL));
        return true;
    }
    return false;
}
void BirdSprite::idle(){
    if (changeState(ACTION_STATE_IDLE)) {
        this->runAction(idleAction);
        this->runAction(swingAction);
    }
}

void BirdSprite::fly(){
    if (changeState(ACTION_STATE_FLY)) {
        this->runAction(swingAction);
        this->getPhysicsBody()->setGravityEnable(true);
    }
}

void BirdSprite::die(){
    if (changeState(ACTION_STATE_DIE)) {
        this->stopAllActions();
    }
}

Animation* BirdSprite::createAnimation(const char *fmt, int count, float fps){
    Animation *animation = Animation::create();
    animation->setDelayPerUnit(1/fps);
    for(int i = 0, i < count, i++){
        const char *filename = String::createWithSpriteFrame(fmt,i)->getCString();
        
    }
}
