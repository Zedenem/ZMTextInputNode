//
//  ZMMyScene.m
//  ZMTextInputSpriteProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMMyScene.h"

#import "ZMTextInputNode.h"

@interface ZMMyScene ()

#pragma mark Custom Keyboard
@property(strong, nonatomic) ZMKeyboardNode *keyboard;

@end

@implementation ZMMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.keyboard = [ZMKeyboardNode keyboardNodeWithScene:self];
        
        ZMTextInputNode *textInputNode = [ZMTextInputNode textInputNodeWithKeyboard:self.keyboard];
        textInputNode.text = @"Youhou";
        [self addChild:textInputNode];
        
    }
    return self;
}

@end
