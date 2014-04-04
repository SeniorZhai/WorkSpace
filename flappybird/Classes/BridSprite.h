//
//  BridSprite.h
//  flappybird
//
//  Created by 翟涛 on 14-4-4.
//
//

#ifndef __flappybird__BridSprite__
#define __flappybird__BridSprite__

#include "cocos2d.h"
#include "AtlasLoader.h"
using namespace cocos2d;

typedef enum{
    ACTION_STATE_IDLE,
    ACTION_STATE_FLY,
    ACTION_STATE_DIE
}ActionState;
const int BIRD_SPRITE_TAG = 10003;

class BirdSprite : public Sprite {
public:
    BirdSprite();
    ~BirdSprite();
    static BirdSprite* getInstance();
    bool virtual init();
    bool createdBird();
    void idle();
    void fly();
    void die();
protected:
    static Animation *createAnimation(const char *fmt,int count,float fps);
    void createBirdByRandom();
private:
    static BirdSprite* shareBirdSprite;
    bool changeState(ActionState state);
    Action* idleAction;
    Action* swingAction;
    
    ActionState currentStatus;
    string birdName;
    string birdNameFormat;
    unsigned int isFirstTime;
};

#endif /* defined(__flappybird__BridSprite__) */
