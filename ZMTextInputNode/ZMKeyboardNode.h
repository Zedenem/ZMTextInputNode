//
//  ZMKeyboardNode.h
//  ZMTextInputNodeProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ZMKeyboardNode : SKSpriteNode

#pragma mark Initialization
- (instancetype)initWithScene:(SKScene *)scene;
+ (instancetype)keyboardNodeWithScene:(SKScene *)scene;

#pragma mark Keyboard Presentation
@property(assign, nonatomic, readonly, getter = isPresented) BOOL presented;
- (void)present;
- (void)dismiss;

@end
