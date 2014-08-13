//
//  Creature.h
//  GameOfLife
//
//  Created by Ryan Higgins on 8/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

@property (nonatomic, assign) BOOL isAlive;

// Number of living neighbors
@property (nonatomic, assign) NSInteger livingNeighbors;


// designated initalizer
-(instancetype)initCreature;

@end
