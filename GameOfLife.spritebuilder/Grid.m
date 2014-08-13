//
//  Grid.m
//  GameOfLife
//
//  Created by Ryan Higgins on 8/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid
{
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

-(void)onEnter
{
    [super onEnter];
    
    [self setupGrid];
    
    // accept touches on the grid
    self.userInteractionEnabled = YES;
}

-(void)setupGrid
{
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    _gridArray = [NSMutableArray array];
    
    for (int i = 0; i < GRID_ROWS; i++) {
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            _gridArray[i][j] = creature;
            
            
            x += _cellWidth;
        }
        
        y += _cellHeight;
    }
    
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInNode:self];
    Creature *creature = [self creatureForTouchPosition:location];
    
    creature.isAlive = !creature.isAlive;
    
}

-(Creature *)creatureForTouchPosition:(CGPoint)location
{
    int row = location.y / _cellHeight;
    int col = location.x / _cellWidth;
    return _gridArray[row][col];
}

-(void)evolveStep
{
    [self countNeighbors];
    
    [self updateCreatures];
    
    _generation++;
}

-(void)countNeighbors
{
    for (int i =0; i < [_gridArray count]; i++) {
        
        for (int j = 0; j < [_gridArray[i] count]; j++) {
            
            Creature *currentCreature = _gridArray[i][j];
            
            currentCreature.livingNeighbors = 0;
            
            
            for (int x = (i-1); x<= (i+1); x++) {
                
                for (int y = (j-1); y <= (j+1); y++) {
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    if (!((x == i) && (y == j)) && isIndexValid) {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive) {
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                }
                
            }
        }
    }
}

-(BOOL)isIndexValidForX:(int)x andY:(int)y {
    if (x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS) {
        return NO;
    }
    return YES;
}

-(void)updateCreatures
{
    for (int i = 0; i < [_gridArray count]; i++) {
        
        for (int j = 0; j < [_gridArray[i] count]; j++) {
            
            Creature *creature = _gridArray[i][j];
            
            if (creature.livingNeighbors == 3) {
                [creature setIsAlive:YES];
            } else {
                if (creature.livingNeighbors <= 1 || creature.livingNeighbors >= 4) {
                    [creature setIsAlive:NO];
                }
            }
        }
    }
}



@end
