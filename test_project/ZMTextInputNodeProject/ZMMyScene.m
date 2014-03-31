//
//  ZMMyScene.m
//  ZMTextInputSpriteProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMMyScene.h"

#import "ZMTextInputNode.h"

@interface ZMMyScene () <ZMKeyboardNodeDataSource>

#pragma mark Custom Keyboard
@property(strong, nonatomic) ZMKeyboardNode *keyboard;

@end

@implementation ZMMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.keyboard = [ZMKeyboardNode keyboardNodeWithScene:self];
        self.keyboard.dataSource = self;
        
        ZMTextInputNode *textInputNode = [ZMTextInputNode textInputNodeWithKeyboard:self.keyboard];
        textInputNode.text = @"A";
        textInputNode.position = CGPointMake(0.f, 100.f);
        [self addChild:textInputNode];
        
    }
    return self;
}

#pragma mark ZMKeyboardNodeDataSource
- (NSUInteger)numberOfSectionsInkeyboardNode:(ZMKeyboardNode *)keyboardNode {
    return [[ZMKeyboardNode azertyAlphabetKeys] count];
}
- (NSUInteger)keyboardNode:(ZMKeyboardNode *)keyboardNode numberOfItemsInSection:(NSUInteger)section {
    return [[ZMKeyboardNode azertyAlphabetKeys][section] count];
}
- (NSString *)keyboardNode:(ZMKeyboardNode *)keyboardNode characterAtIndexPath:(NSIndexPath *)indexPath {
    return [ZMKeyboardNode azertyAlphabetKeys][indexPath.section][indexPath.row];
}

@end
