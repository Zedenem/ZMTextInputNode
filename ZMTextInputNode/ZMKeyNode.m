//
//  DBButton.m
//  Dobble
//
//  Created by Zouhair Mahieddine on 3/13/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMKeyNode.h"

static NSString *const kAnimatedButtonActionKey = @"animatedButtonActionKey";

@interface ZMKeyNode ()

#pragma mark Target Action
@property(strong, nonatomic) id target;
@property(assign, nonatomic) SEL action;

#pragma mark Title
@property(strong, nonatomic) SKLabelNode *labelNode;

@end

@implementation ZMKeyNode

#pragma mark Initialization

- (instancetype)initWithCharacter:(NSString *)character target:(id)target action:(SEL)action {
    self = [self initWithColor:[UIColor darkGrayColor] size:CGSizeMake(66.f, 88.f)];
    if (self) {
        self.userInteractionEnabled = YES;
        [self.labelNode setText:character];
        [self setTarget:target action:action];
    }
    return self;
}
+ (instancetype)keyNodeWithCharacter:(NSString *)character target:(id)target action:(SEL)action {
    return [[self alloc] initWithCharacter:character target:target action:action];
}

#pragma mark Target Action
- (void)setTarget:(id)target action:(SEL)action {
    self.target = target;
    self.action = action;
}

#pragma mark Title
- (SKLabelNode *)labelNode {
    if (!_labelNode) {
        _labelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Neue"];
        _labelNode.fontSize = 80.f;
        _labelNode.fontColor = [UIColor whiteColor];
        _labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        [self addChild:_labelNode];
    }
    return _labelNode;
}

#pragma mark Touches Events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self runAction:[SKAction scaleTo:1.1f duration:0.1f]];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self runAction:[SKAction
                     sequence:@[[SKAction scaleTo:0.8f duration:0.1f],
                                [SKAction scaleTo:1.0f duration:0.1f],
                                [SKAction
                                 runBlock:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                     [self.target performSelector:self.action withObject:self];
#pragma clang diagnostic pop
                                 }]]]];
}

@end
