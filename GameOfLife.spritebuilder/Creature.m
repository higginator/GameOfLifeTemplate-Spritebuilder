//
//  Creature.m
//  GameOfLife
//
//  Created by Ryan Higgins on 8/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

-(instancetype)initCreature
{
    if (self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"]) {
        self.isAlive = NO;
    }
    
    return self;
}

-(void)setIsAlive:(BOOL)newState {
    //properties in header file automatiacally create variables with leading underscore
    _isAlive = newState;
    
    //visible is a property of any class inheriting from CCNode
    
    self.visible = _isAlive;
}

@end
