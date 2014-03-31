//
//  ZMTextInputNode.m
//  ZMTextInputNodeProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMTextInputNode.h"

// Constants
NSString *const ZMTextInputNodeEmptyString = @"?";

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
        self.text = ZMTextInputNodeEmptyString;
        self.fontColor = [UIColor darkTextColor];
    }
    return self;
}
+ (instancetype)textInputNodeWithKeyboard:(ZMKeyboardNode *)keyboard {
    return [[self alloc] initWithKeyboard:keyboard];
}

#pragma mark Editing
- (void)setEditing:(BOOL)editing {
    if (_editing != editing) {
        _editing = editing;
        if (_editing) {
            self.fontColor = [UIColor blueColor];
            self.fontName = @"Helvetica-Bold";
            if (!self.keyboard.presented) {
                [self.keyboard present];
            }
            self.keyboard.delegate = self;
        }
        else {
            self.fontColor = [UIColor darkTextColor];
            self.fontName = @"Helvetica";
            if ([self.keyboard.delegate isEqual:self]) {
                self.keyboard.delegate = nil;
            }
        }
    }
}

#pragma mark Touches
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.delegate textInputNodeDidStartEditing:self];
    self.editing = YES;
}

#pragma mark ZMKeyboardDelegate
- (void)keyboardNode:(ZMKeyboardNode *)keyboardNode didSelectCharacter:(NSString *)character {
    self.text = character;
    [self.delegate textInputNodeDidChange:self];
}
- (void)keyboardNodeDidHitDeleteKey:(ZMKeyboardNode *)keyboardNode {
    if ([self.delegate textInputNodeShouldClear:self]) {
        self.text = ZMTextInputNodeEmptyString;
    }
}

@end
