//
//  ZMTextInputNode.h
//  ZMTextInputNodeProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMKeyboardNode.h"

@interface ZMTextInputNode : SKLabelNode

#pragma mark Initialization
- (instancetype)initWithKeyboard:(ZMKeyboardNode *)keyboard;
+ (instancetype)textInputNodeWithKeyboard:(ZMKeyboardNode *)keyboard;

@end
