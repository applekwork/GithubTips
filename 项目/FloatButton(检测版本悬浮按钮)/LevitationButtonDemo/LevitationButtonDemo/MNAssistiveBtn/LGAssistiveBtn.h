//
//  LGAssistiveBtn.h
//
//  Created by KWOK on 2018/12/8.
//  Copyright © 2018年 KWOK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LGAssistiveTouchType)
{
    LGAssistiveTypeNone = 0,   //自动识别贴边
    LGAssistiveTypeNearLeft,   //拖动停止之后，自动向左贴边
    LGAssistiveTypeNearRight,  //拖动停止之后，自动向右贴边
};

@interface LGAssistiveBtn : UIButton

+ (instancetype)LG_touchWithFrame:(CGRect)frame;

+ (instancetype)LG_touchWithType:(LGAssistiveTouchType)type
                           Frame:(CGRect)frame;

@end
