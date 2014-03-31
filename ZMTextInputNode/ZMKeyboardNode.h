//
//  ZMKeyboardNode.h
//  ZMTextInputNodeProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class ZMKeyboardNode;
@protocol ZMKeyboardNodeDataSource <NSObject>

- (NSUInteger)numberOfSectionsInkeyboardNode:(ZMKeyboardNode *)keyboardNode;
- (NSUInteger)keyboardNode:(ZMKeyboardNode *)keyboardNode numberOfItemsInSection:(NSUInteger)section;
- (NSString *)keyboardNode:(ZMKeyboardNode *)keyboardNode characterAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ZMKeyboardNodeDelegate <NSObject>

@optional
- (void)keyboardNode:(ZMKeyboardNode *)keyboardNode didSelectCharacter:(NSString *)character;

@end

@interface ZMKeyboardNode : SKSpriteNode

@property(weak, nonatomic) id<ZMKeyboardNodeDataSource> dataSource;
@property(weak, nonatomic) id<ZMKeyboardNodeDelegate> delegate;

#pragma mark Initialization
- (instancetype)initWithScene:(SKScene *)scene;
+ (instancetype)keyboardNodeWithScene:(SKScene *)scene;

#pragma mark Keyboard Presentation
@property(assign, nonatomic, readonly, getter = isPresented) BOOL presented;
- (void)present;
- (void)dismiss;

#pragma mark Keyboard Loading & Display
- (void)reloadData;

#pragma mark Predefined Sets of Keys
+ (NSArray *)azertyAlphabetKeys;

@end
