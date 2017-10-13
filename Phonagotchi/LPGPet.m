//
//  LPGPet.m
//  Phonagotchi
//
//  Created by Mar Koss on 2017-10-12.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "LPGPet.h"

@implementation LPGPet

-(instancetype)init {
    self = [super init];
    if (self){
        _isGrumpy = NO;
    }
    return self;
}

- (void)petPet: (CGPoint)velocity {
    if (velocity.x > 2000 || velocity.x < -2000 || velocity.y < -2000 || velocity.y > 2000) {
        _isGrumpy = YES;
    }
    else {
        _isGrumpy = NO;
    }
    
}
@end
