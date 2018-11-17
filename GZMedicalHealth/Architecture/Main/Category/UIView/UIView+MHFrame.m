//
//  UIView+MHFrame.m
//  MHDevLibExample
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 Mike_He. All rights reserved.
//

#import "UIView+MHFrame.h"

@implementation UIView (MHFrame)

- (void)setMh_x:(CGFloat)mh_x
{
    CGRect frame = self.frame;
    frame.origin.x = mh_x;
    self.frame = frame;
}
- (CGFloat)mh_x
{
    return self.frame.origin.x;
}




- (void)setMh_y:(CGFloat)mh_y
{
    CGRect frame = self.frame;
    frame.origin.y = mh_y;
    self.frame = frame;
}
- (CGFloat)mh_y
{
    return self.frame.origin.y;
}




- (void)setMh_centerX:(CGFloat)mh_centerX
{
    CGPoint center = self.center;
    center.x = mh_centerX;
    self.center = center;
}
- (CGFloat)mh_centerX
{
    return self.center.x;
}



- (void)setMh_centerY:(CGFloat)mh_centerY
{
    CGPoint center = self.center;
    center.y = mh_centerY;
    self.center = center;
}
- (CGFloat)mh_centerY
{
    return self.center.y;
}




- (void)setMh_width:(CGFloat)mh_width
{
    CGRect frame = self.frame;
    frame.size.width = mh_width;
    self.frame = frame;
}
- (CGFloat)mh_width
{
    return self.frame.size.width;
}





- (void)setMh_height:(CGFloat)mh_height
{
    CGRect frame = self.frame;
    frame.size.height = mh_height;
    self.frame = frame;
}
- (CGFloat)mh_height
{
    return self.frame.size.height;
}





- (void)setMh_size:(CGSize)mh_size
{
    CGRect frame = self.frame;
    frame.size = mh_size;
    self.frame = frame;
}
- (CGSize)mh_size
{
    return self.frame.size;
}





- (void)setMh_origin:(CGPoint)mh_origin
{
    CGRect frame = self.frame;
    frame.origin = mh_origin;
    self.frame = frame;
}
- (CGPoint)mh_origin
{
    return self.frame.origin;
}


- (void)setMh_top:(CGFloat)mh_top
{
    CGRect frame = self.frame;
    frame.origin.y = mh_top;
    self.frame = frame;
}
- (CGFloat)mh_top
{
    return self.frame.origin.y;
}


- (void)setMh_left:(CGFloat)mh_left
{
    CGRect frame = self.frame;
    frame.origin.x = mh_left;
    self.frame = frame;
}
- (CGFloat)mh_left
{
    return self.frame.origin.x;
}


- (void)setMh_bottom:(CGFloat)mh_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = mh_bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)mh_bottom{
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setMh_right:(CGFloat)mh_right
{
    CGRect frame = self.frame;
    frame.origin.x = mh_right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)mh_right{
    return self.frame.origin.x + self.frame.size.width;
}

#pragma mark - Shortcuts for the coords


- (CGFloat)GZ_top
{
    return self.frame.origin.y;
}

- (void)setGZ_top:(CGFloat)GZ_top
{
    CGRect frame = self.frame;
    frame.origin.y = GZ_top;
    self.frame = frame;
}


- (CGFloat)GZ_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setGZ_right:(CGFloat)GZ_right
{
    CGRect frame = self.frame;
    frame.origin.x = GZ_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)GZ_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setGZ_bottom:(CGFloat)GZ_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = GZ_bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)GZ_left
{
    return self.frame.origin.x;
}

- (void)setGZ_left:(CGFloat)GZ_left
{
    CGRect frame = self.frame;
    frame.origin.x = GZ_left;
    self.frame = frame;
}

- (CGFloat)GZ_width
{
    return self.frame.size.width;
}

- (void)setGZ_width:(CGFloat)GZ_width
{
    CGRect frame = self.frame;
    frame.size.width = GZ_width;
    self.frame = frame;
}

- (CGFloat)GZ_height
{
    return self.frame.size.height;
}

- (void)setGZ_height:(CGFloat)GZ_height
{
    CGRect frame = self.frame;
    frame.size.height = GZ_height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)GZ_origin {
    return self.frame.origin;
}

- (void)setGZ_origin:(CGPoint)GZ_origin {
    CGRect frame = self.frame;
    frame.origin = GZ_origin;
    self.frame = frame;
}

- (CGSize)GZ_size {
    return self.frame.size;
}

- (void)setGZ_size:(CGSize)GZ_size {
    CGRect frame = self.frame;
    frame.size = GZ_size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)GZ_centerX {
    return self.center.x;
}

- (void)setGZ_centerX:(CGFloat)GZ_centerX {
    self.center = CGPointMake(GZ_centerX, self.center.y);
}

- (CGFloat)GZ_centerY {
    return self.center.y;
}

- (void)setGZ_centerY:(CGFloat)GZ_centerY {
    self.center = CGPointMake(self.center.x, GZ_centerY);
}


@end
