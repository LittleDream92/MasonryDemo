//
//  UIView+Mosonry_MF.h
//  MosonryDemo
//
//  Created by Meng Fan on 16/7/5.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface UIView (Mosonry_MF)

//横向排列
- (void) distributeSpacingHorizontallyWith:(NSArray*)views;
//竖向排列
- (void) distributeSpacingVerticallyWith:(NSArray*)views;

@end
