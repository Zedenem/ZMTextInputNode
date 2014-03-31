//
//  DBButton.h
//  Dobble
//
//  Created by Zouhair Mahieddine on 3/13/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ZMKeyNode : SKSpriteNode

#pragma mark Initialization
- (instancetype)initWithCharacter:(NSString *)character target:(id)target action:(SEL)action;
+ (instancetype)keyNodeWithCharacter:(NSString *)character target:(id)target action:(SEL)action;

#pragma mark Target Action
- (void)setTarget:(id)target action:(SEL)action;

#pragma mark Character
@property(strong, nonatomic) NSString *character;

@end