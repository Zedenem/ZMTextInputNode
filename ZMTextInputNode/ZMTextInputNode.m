//
//  ZMTextInputNode.m
//  ZMTextInputNodeProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMTextInputNode.h"

@interface ZMTextInputNode () <ZMKeyboardNodeDelegate>

#pragma mark Custom Keyboard
@property(strong, nonatomic) ZMKeyboardNode *keyboard;

@end

@implementation ZMTextInputNode

#pragma mark Initialization
- (id)initWithFontNamed:(NSString *)fontName {
    self = [super initWithFontNamed:fontName];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (instancetype)initWithKeyboard:(ZMKeyboardNode *)keyboard {
    self = [self initWithFontNamed:@"Helvetica"];
    if (self) {
        self.keyboard = keyboard;
    }
    return self;
}
+ (instancetype)textInputNodeWithKeyboard:(ZMKeyboardNode *)keyboard {
    return [[self alloc] initWithKeyboard:keyboard];
}

#pragma mark Touches
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (!self.keyboard.isPresented) {
        [self.keyboard present];
        self.keyboard.delegate = self;
    }
    else {
        [self.keyboard dismiss];
    }
}

#pragma mark ZMKeyboardDelegate
- (void)keyboardNode:(ZMKeyboardNode *)keyboardNode didSelectCharacter:(NSString *)character {
    self.text = character;
}

@end
