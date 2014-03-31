//
//  ZMTextInputNode.h
//  ZMTextInputNodeProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMKeyboardNode.h"

// Constants
extern NSString *const ZMTextInputNodeEmptyString;

@class ZMTextInputNode;
@protocol ZMTextInputNodeDelegate <NSObject>

- (void)textInputNodeDidStartEditing:(ZMTextInputNode *)textInputNode;
- (void)textInputNodeDidChange:(ZMTextInputNode *)textInputNode;
- (BOOL)textInputNodeShouldClear:(ZMTextInputNode *)textInputNode;

@end

@interface ZMTextInputNode : SKLabelNode

@property(weak, nonatomic) id<ZMTextInputNodeDelegate> delegate;

#pragma mark Initialization
- (instancetype)initWithKeyboard:(ZMKeyboardNode *)keyboard;
+ (instancetype)textInputNodeWithKeyboard:(ZMKeyboardNode *)keyboard;

#pragma mark Editing
@property(assign, nonatomic, getter = isEditing) BOOL editing;

@end
