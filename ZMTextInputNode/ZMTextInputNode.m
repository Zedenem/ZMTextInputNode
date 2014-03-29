//
//  ZMTextInputNode.m
//  ZMTextInputNodeProject
//
//  Created by Zouhair Mahieddine on 3/29/14.
//  Copyright (c) 2014 Zedenem. All rights reserved.
//

#import "ZMTextInputNode.h"

@interface ZMTextInputNode ()

@property(readwrite, retain) UIView *inputView;

#pragma mark Custom Keyboard
@property(strong, nonatomic) UIView *keyboard;

@end

@implementation ZMTextInputNode

#pragma mark Initialization
- (id)initWithFontNamed:(NSString *)fontName {
    self = [super initWithFontNamed:fontName];
    if (self) {
        self.userInteractionEnabled = YES;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 384)];
        view.backgroundColor = [UIColor redColor];
        self.inputView = view;
    }
    return self;
}

#pragma mark Touches
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self becomeFirstResponder];
}

@end
