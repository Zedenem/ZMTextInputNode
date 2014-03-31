//
//  ZMKeyboardNode.m
//  ZMTextInputNodeProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMKeyboardNode.h"

#import "ZMKeyNode.h"

@interface ZMKeyboardNode ()

#pragma mark Keyboard Presentation
@property(assign, nonatomic, readwrite, getter = isPresented) BOOL presented;

#pragma mark Keyboard Loading & Display
@property(assign, nonatomic, readonly) UIEdgeInsets marginInsets;
@property(assign, nonatomic, readonly) CGSize keySize;
@property(assign, nonatomic, readonly) CGSize spaceBetweenKeys;
@property(assign, nonatomic, readonly) NSUInteger numberOfSections;
@property(assign, nonatomic, readonly) NSUInteger maximumNumberOfItems;
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;

#pragma mark Keys Container Node
@property(strong, nonatomic) SKSpriteNode *contentNode;

@end

@implementation ZMKeyboardNode

#pragma mark Initialization
- (instancetype)initWithScene:(SKScene *)scene {
    self = [super initWithColor:[UIColor grayColor] size:CGSizeMake(scene.size.width, scene.size.height/2)];
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
        [self reloadData];
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

#pragma mark Keyboard Loading & Display
- (UIEdgeInsets)marginInsets {
    return UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
}
- (CGSize)keySize {
    return CGSizeMake(88.f, 108.f);
}
- (CGSize)spaceBetweenKeys {
    return CGSizeMake(10.f, 5.f);
}
- (NSUInteger)numberOfSections {
    NSUInteger numberOfSections = 1;
    if (self.dataSource) {
        numberOfSections = [self.dataSource numberOfSectionsInkeyboardNode:self];
    }
    return numberOfSections;
}
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
    return [self.dataSource keyboardNode:self numberOfItemsInSection:section];
}
- (NSUInteger)maximumNumberOfItems {
    NSUInteger maximumNumberOfItems = 0;
    for (int i = 0; i < self.numberOfSections; i++) {
        maximumNumberOfItems = MAX(maximumNumberOfItems, [self numberOfItemsInSection:i]);
    }
    return maximumNumberOfItems;
}
- (void)reloadData {
    CGSize contentNodeSize = CGSizeMake(MIN(self.size.width - self.marginInsets.left - self.marginInsets.right,
                                            self.keySize.width * self.maximumNumberOfItems
                                            + self.spaceBetweenKeys.width * (self.maximumNumberOfItems-1))
                                        ,
                                        MIN(self.size.height - self.marginInsets.top - self.marginInsets.bottom,
                                            self.keySize.height * self.numberOfSections
                                            + self.spaceBetweenKeys.height * (self.numberOfSections-1))
                                        );
    if (!self.contentNode) {
        self.contentNode = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:contentNodeSize];
        [self addChild:self.contentNode];
    }
    else {
        [self.contentNode removeAllChildren];
        self.contentNode.size = contentNodeSize;
    }
    
    
    CGPoint initialKeyNodePosition = CGPointMake(- self.contentNode.size.width/2 + self.keySize.width/2 + self.spaceBetweenKeys.width,
                                                 self.contentNode.size.height/2 - self.keySize.height/2 - self.spaceBetweenKeys.height);
    for (int i=0; i < self.numberOfSections; i++) {
        for (int j=0; j < [self numberOfItemsInSection:i]; j++) {
            NSString *character = [self.dataSource keyboardNode:self characterAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
            ZMKeyNode *keyNode = [ZMKeyNode keyNodeWithCharacter:character target:self action:@selector(keyStroked:)];
            keyNode.name = character;
            [self.contentNode addChild:keyNode];
            
            keyNode.position = CGPointMake(initialKeyNodePosition.x + j * self.keySize.width + (j-1) * self.spaceBetweenKeys.width,
                                           initialKeyNodePosition.y - i * self.keySize.height - (i-1) * self.spaceBetweenKeys.height);
        }
    }
}
- (void)keyStroked:(ZMKeyNode *)keyNode {
    [self.delegate keyboardNode:self didSelectCharacter:keyNode.name];
}

#pragma mark Predefined Sets of Keys
+ (NSArray *)azertyAlphabetKeys {
    return @[@[@"A", @"Z", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P"],
             @[@"Q", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"M"],
             @[@"W", @"X", @"C", @"V", @"B", @"N"]];
}

@end
