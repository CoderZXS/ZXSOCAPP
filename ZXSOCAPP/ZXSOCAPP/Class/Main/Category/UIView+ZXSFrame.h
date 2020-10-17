#import <UIKit/UIKit.h>

@interface UIView (ZXSFrame)

/*******x*y*width*height************/
@property (nonatomic, assign) CGFloat zxs_x;
@property (nonatomic, assign) CGFloat zxs_y;
@property (nonatomic, assign) CGFloat zxs_width;
@property (nonatomic, assign) CGFloat zxs_height;

/*******centerX*centerY*center************/
@property (nonatomic, assign) CGFloat zxs_centerX;
@property (nonatomic, assign) CGFloat zxs_centerY;
@property (nonatomic, assign) CGPoint zxs_center;

/*******top*left*buttom*right************/
@property (nonatomic, assign) CGFloat zxs_top;
@property (nonatomic, assign) CGFloat zxs_left;
@property (nonatomic, assign) CGFloat zxs_buttom;
@property (nonatomic, assign) CGFloat zxs_right;

/*******origin*size************/
@property (nonatomic, assign) CGPoint zxs_orign;
@property (nonatomic, assign) CGSize zxs_size;

@end
