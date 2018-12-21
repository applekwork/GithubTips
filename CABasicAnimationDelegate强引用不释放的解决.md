# CABasicAnimationDelegate强引用不释放的解决

```
//
//  CABasicAnimation+WeakReference.h
//  动画
//
//  Created by  LG on 2018/12/21.
//  Copyright © 2018年 LG. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CABasicAnimation (WeakReference)
- (void)setWeakAnimationDelegate:(id)delegate;
@end


```


```
//
//  CABasicAnimation+WeakReference.m
//  动画
//
//  Created by  LG on 2018/12/21.
//  Copyright © 2018年 LG. All rights reserved.
//

#import "CABasicAnimation+WeakReference.h"
#import <objc/runtime.h>

static void *BasicAnimationDelegate = @"BasicAnimationDelegate";

@implementation CABasicAnimation (WeakReference)

- (void)setWeakAnimationDelegate:(id)delegate {
    self.delegate = self;
    objc_setAssociatedObject(self, BasicAnimationDelegate, delegate, OBJC_ASSOCIATION_ASSIGN);
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    id obj = objc_getAssociatedObject(self, BasicAnimationDelegate);
    [obj animationDidStop:anim finished:flag];
}
@end
```

