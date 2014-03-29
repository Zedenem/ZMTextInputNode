//
//  ZMKeyboardNode.m
//  ZMTextInputNodeProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMKeyboardNode.h"

@interface ZMKeyboardNode ()

#pragma mark Keyboard Presentation
@property(assign, nonatomic, readwrite, getter = isPresented) BOOL presented;

@end

@implementation ZMKeyboardNode

#pragma mark Initialization
- (instancetype)initWithScene:(SKScene *)scene {
    self = [super initWithColor:[UIColor redColor] size:CGSizeMake(scene.size.width, scene.size.height/2)];
    if (self) {
        self.zPosition = MAXFLOAT;
        self.position = CGPointMake(0, -scene.size.height);
        self.presented = NO;
        [scene addChild:self];
    }
    return self;
}
+ (instancetype)keyboardNodeWithScene:(SKScene *)scene {
    return [[self alloc] initWithScene:scene];
}

#pragma mark Keyboard Presentation
- (void)present {
    if (!self.presented) {
        [self runAction:[SKAction moveTo:CGPointMake(self.position.x, -self.size.height/2) duration:0.2f]];
        self.presented = YES;
    }
}
- (void)dismiss {
    if (self.presented) {
        [self runAction:[SKAction moveTo:CGPointMake(self.position.x, -self.scene.size.height) duration:0.2f]];
        self.presented = NO;
    }
}
- (void)removeFromParent {
    if (self.presented) {
        [self dismiss];
    }
    [super removeFromParent];
}

@end
