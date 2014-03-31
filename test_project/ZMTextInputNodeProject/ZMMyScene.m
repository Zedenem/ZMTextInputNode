//
//  ZMMyScene.m
//  ZMTextInputSpriteProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMMyScene.h"

#import "ZMTextInputNode.h"

@interface ZMMyScene () <ZMKeyboardNodeDataSource, ZMTextInputNodeDelegate>

#pragma mark Custom Keyboard
@property(strong, nonatomic) ZMKeyboardNode *keyboard;

@end

@implementation ZMMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        self.keyboard = [ZMKeyboardNode keyboardNodeWithScene:self];
        self.keyboard.dataSource = self;
        
        for (int i = 0; i < 10; i++) {
            ZMTextInputNode *textInputNode = [ZMTextInputNode textInputNodeWithKeyboard:self.keyboard];
            textInputNode.delegate = self;
            textInputNode.name = [NSString stringWithFormat:@"%lu", (unsigned long)i];
            textInputNode.position = CGPointMake(self.size.width/2 -4*50.f + i*50.f, self.size.height/2 + 100.f);
            [self addChild:textInputNode];
        }
        
        
        
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

#pragma mark ZMTextInputNodeDelegate
- (void)textInputNodeDidStartEditing:(ZMTextInputNode *)textInputNode {
    for (SKNode *node in self.children) {
        if ([node isKindOfClass:[ZMTextInputNode class]]) {
            ((ZMTextInputNode *)node).editing = NO;
        }
    }
    textInputNode.editing = YES;
}
- (void)textInputNodeDidChange:(ZMTextInputNode *)textInputNode {
    if ([textInputNode.name integerValue] < 10-1) {
        textInputNode.editing = NO;
        ZMTextInputNode *nextTextInputNode = (ZMTextInputNode *)[self childNodeWithName:[NSString stringWithFormat:@"%lu", (unsigned long)[textInputNode.name integerValue] + 1]];
        nextTextInputNode.editing = YES;
    }
}
- (BOOL)textInputNodeShouldClear:(ZMTextInputNode *)textInputNode {
    if ([textInputNode.text isEqualToString:ZMTextInputNodeEmptyString] && [textInputNode.name integerValue] > 0) {
        textInputNode.editing = NO;
        ZMTextInputNode *previousTextInputNode = (ZMTextInputNode *)[self childNodeWithName:[NSString stringWithFormat:@"%lu", (unsigned long)[textInputNode.name integerValue] - 1]];
        previousTextInputNode.editing = YES;
        previousTextInputNode.text = ZMTextInputNodeEmptyString;
    }
    return YES;
}

@end
