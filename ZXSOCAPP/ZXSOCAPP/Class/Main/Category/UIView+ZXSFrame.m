#import "UIView+ZXSFrame.h"

@implementation UIView (ZXSFrame)

- (void)setZxs_x:(CGFloat)zxs_x {
    CGRect frame = self.frame;
    frame.origin.x = zxs_x;
    self.frame = frame;
}

- (CGFloat)zxs_x {
    return self.frame.origin.x;
}

- (void)setZxs_y:(CGFloat)zxs_y {
    CGRect frame = self.frame;
    frame.origin.y = zxs_y;
    self.frame = frame;
}

- (CGFloat)zxs_y {
    return self.frame.origin.y;
}

- (void)setZxs_width:(CGFloat)zxs_width {
    CGRect frame = self.frame;
    frame.size.width = zxs_width;
    self.frame = frame;
}

- (CGFloat)zxs_width {
    return self.frame.size.width;
}

- (void)setZxs_height:(CGFloat)zxs_height {
    CGRect frame = self.frame;
    frame.size.height = zxs_height;
    self.frame = frame;
}

- (CGFloat)zxs_height {
    return self.frame.size.height;
}

- (void)setZxs_centerX:(CGFloat)zxs_centerX {
    CGPoint center = self.center;
    center.x = zxs_centerX;
    self.center = center;
}

- (CGFloat)zxs_centerX {
     return self.center.x;
}

- (void)setZxs_centerY:(CGFloat)zxs_centerY {
    CGPoint center = self.center;
    center.y = zxs_centerY;
    self.center = center;
}

- (CGFloat)zxs_centerY {
    return self.center.y;
}

- (void)setZxs_center:(CGPoint)zxs_center {
    CGPoint center = self.center;
    center.x = zxs_center.x;
    center.y = zxs_center.y;
    self.center = center;
}

- (CGPoint)zxs_center {
    return self.center;
}

- (void)setZxs_top:(CGFloat)zxs_top {
    CGRect frame = self.frame;
    frame.origin.y = zxs_top;
    self.frame = frame;
}

- (CGFloat)zxs_top {
    return self.frame.origin.y;
}

- (void)setZxs_left:(CGFloat)zxs_left {
    CGRect frame = self.frame;
    frame.origin.x = zxs_left;
    self.frame = frame;
}

- (CGFloat)zxs_left {
    return self.frame.origin.x;
}

- (void)setZxs_buttom:(CGFloat)zxs_buttom {
    CGRect frame = self.frame;
    frame.origin.y = zxs_buttom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)zxs_buttom {
    return CGRectGetMaxY(self.frame);
}

- (void)setZxs_right:(CGFloat)zxs_right {
    CGRect frame = self.frame;
    frame.origin.x = zxs_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)zxs_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setZxs_size:(CGSize)zxs_size {
    CGRect frame = self.frame;
    frame.size = zxs_size;
    self.frame = frame;
}

- (CGSize)zxs_size {
    return self.frame.size;
}

- (void)setZxs_orign:(CGPoint)zxs_orign {
    CGRect frame = self.frame;
    frame.origin = zxs_orign;
    self.frame = frame;
}

- (CGPoint)zxs_orign {
     return self.frame.origin;
}

@end
