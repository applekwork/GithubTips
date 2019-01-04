//
//  LGAssistiveBtn.m
//
//  Created by KWOK on 2018/12/8.
//  Copyright © 2018年 KWOK. All rights reserved.
//

#import "LGAssistiveBtn.h"

#define screenW  [UIScreen mainScreen].bounds.size.width
#define screenH  [UIScreen mainScreen].bounds.size.height

@implementation LGAssistiveBtn{
    
    LGAssistiveTouchType  _type;
    //拖动按钮的起始坐标点
    CGPoint _touchPoint;
}

+ (instancetype)LG_touchWithFrame:(CGRect)frame{
    return [[self alloc]initWithType:LGAssistiveTypeNone frame:frame];
}
+ (instancetype)LG_touchWithType:(LGAssistiveTouchType)type
                           Frame:(CGRect)frame {
   return [[self alloc]initWithType:type frame:frame];
}

- (instancetype)initWithType:(LGAssistiveTouchType)type
                       frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        //UIbutton的换行显示
        self.titleLabel.textColor  = [UIColor whiteColor];
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        NSString *versionStr = [[[NSBundle
                                  mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
        NSString *buildStr = [[[NSBundle
                                mainBundle]infoDictionary]valueForKey:@"CFBundleVersion"];
        
        NSString *titles = [NSString stringWithFormat:@"Ver:%@ 测试\nBuild:%@",versionStr,buildStr];
        [self setTitle:titles forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
        [self.window addSubview:self];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    //按钮刚按下的时候，获取此时的起始坐标
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //获取当前移动过程中的按钮坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    
    //偏移量(当前坐标 - 起始坐标 = 偏移量)
    CGFloat offsetX = currentPosition.x - _touchPoint.x;
    CGFloat offsetY = currentPosition.y - _touchPoint.y;
    
    //移动后的按钮中心坐标
    CGFloat centerX = self.center.x + offsetX;
    CGFloat centerY = self.center.y + offsetY;
    self.center = CGPointMake(centerX, centerY);
    
    //父试图的宽高
    CGFloat superViewWidth = self.superview.frame.size.width;
    CGFloat superViewHeight = self.superview.frame.size.height;
    CGFloat btnX = self.frame.origin.x;
    CGFloat btnY = self.frame.origin.y;
    CGFloat btnW = self.frame.size.width;
    CGFloat btnH = self.frame.size.height;
    
    //x轴左右极限坐标
    if (btnX > superViewWidth){
        //按钮右侧越界
        CGFloat centerX = superViewWidth - btnW/2;
        self.center = CGPointMake(centerX, centerY);
    }else if (btnX < 0){
        //按钮左侧越界
        CGFloat centerX = btnW * 0.5;
        self.center = CGPointMake(centerX, centerY);
    }
    
    //默认都是有导航条的，有导航条的，父试图高度就要被导航条占据，固高度不够
    CGFloat defaultNaviHeight = 64;
    CGFloat judgeSuperViewHeight = superViewHeight - defaultNaviHeight;
    
    //y轴上下极限坐标
    if (btnY <= 0){
        //按钮顶部越界
        centerY = btnH * 0.7;
        self.center = CGPointMake(centerX, centerY);
    }
    else if (btnY > judgeSuperViewHeight){
        //按钮底部越界
        CGFloat y = superViewHeight - btnH * 0.5;
        self.center = CGPointMake(btnX, y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    
    CGFloat btnWidth = self.frame.size.width;
    CGFloat btnHeight = self.frame.size.height;
    CGFloat btnY = self.frame.origin.y;
    
    //按钮靠近右侧
    switch (_type) {
            
        case LGAssistiveTypeNone:{
            
            //自动识别贴边
            if (self.center.x >= self.superview.frame.size.width/2) {
                
                [UIView animateWithDuration:0.5 animations:^{
                    //按钮靠右自动吸边
                    CGFloat btnX = self.superview.frame.size.width - btnWidth;
                    self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
                }];
            }else{
                
                [UIView animateWithDuration:0.5 animations:^{
                    //按钮靠左吸边
                    CGFloat btnX = 0;
                    self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
                }];
            }
            break;
        }
        case LGAssistiveTypeNearLeft:{
            [UIView animateWithDuration:0.5 animations:^{
                //按钮靠左吸边
                CGFloat btnX = 0;
                self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
            }];
            break;
        }
        case LGAssistiveTypeNearRight:{
            [UIView animateWithDuration:0.5 animations:^{
                //按钮靠右自动吸边
                CGFloat btnX = self.superview.frame.size.width - btnWidth;
                self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
            }];
        }
    }
    
}




@end
