//
//  ZMMyScene.m
//  ZMTextInputSpriteProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMMyScene.h"

#import "ZMTextInputNode.h"

@implementation ZMMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        ZMTextInputNode *textInputNode = [[ZMTextInputNode alloc] initWithFontNamed:@"Helvetice-Neue"];
        textInputNode.text = @"Youhou";
        [self addChild:textInputNode];
        
    }
    return self;
}

@end
