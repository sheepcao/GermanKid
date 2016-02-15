//
//  oldPriceButton.m
//  GermanKid
//
//  Created by Eric Cao on 2/3/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import "oldPriceButton.h"

@implementation oldPriceButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    //获得处理的上下文
    
    CGContextRef
    context = UIGraphicsGetCurrentContext();
    
    //指定直线样式
    
    CGContextSetLineCap(context,
                        kCGLineCapSquare);
    
    //直线宽度
    
    CGContextSetLineWidth(context,
                          0.8);
    
    //设置颜色
    
    CGContextSetRGBStrokeColor(context,
                               0.5, 0.5, 0.5, 1.0);
    
    //开始绘制
    
    CGContextBeginPath(context);
    
    //画笔移动到点(31,170)
    
    CGContextMoveToPoint(context,
                         1, rect.size.height/2-2);
    
    //下一点
    
    CGContextAddLineToPoint(context,
                            rect.size.width-2, rect.size.height/2-2);
    

    
    //绘制完成
    
    CGContextStrokePath(context);

}

- (void)drawLine:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 1.起点
    CGFloat startX = 3;
    CGFloat startY = 3;
    CGContextMoveToPoint(ctx, startX, startY);
    
    // 2.终点
    CGFloat endX = rect.size.width-6;
    CGFloat endY = rect.size.height-6;
    CGContextAddLineToPoint(ctx, endX, endY);
    
    // 3.绘图渲染
    CGContextStrokePath(ctx);
}


@end
