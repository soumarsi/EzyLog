//
//  graphView.m
//  EzyLog
//
//  Created by IOS2 on 19/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "graphView.h"




CGFloat kGraphHeight=230;

CGFloat kDefaultGraphWidth=520;

CGFloat kOffsetX=30;//53; //initiate the origin.x of bar
CGFloat kStepX=60;   //sets the gaps between the bars
CGFloat kGraphBottom;//=20;//bottom point of graph
CGFloat kGraphTop=5;

CGFloat kStepY=40;
CGFloat kOffsetY;//=15;


CGFloat kBarTop=10;
CGFloat kBarWidth=35;


CGRect barRect;



@implementation graphView



//if you put value 0.2 it will be equivalent to kStepY=40



float data[] = {0.2, 0.4,0.6,0.8};



//Method for drawing grids and bars
 
- (void)drawRect:(CGRect)rect
{
         if([[UIScreen mainScreen] bounds].size.height==736)
         {
    
             kOffsetX=60;
             kOffsetY=0;
             
             
             kGraphHeight=230;
             
             kDefaultGraphWidth=610;
             
             NSLog(@".....%f.....",[[UIScreen mainScreen] bounds].size.height);
         
         
        }
    
    
    if([[UIScreen mainScreen] bounds].size.height==667)
    {
    
        kOffsetX=80;
        
       kStepY=40;
        
        kGraphBottom=230;
        
               kDefaultGraphWidth=587;
    
    
    }
        
        
        if([[UIScreen mainScreen] bounds].size.height==568)
        {
            
            
            kOffsetX=60;
            
            kDefaultGraphWidth=505;
            
            
            
        }
 
    
    
    
     CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0.9);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    
    

    
    int howManyHorizontal = (kGraphBottom - kGraphTop - kOffsetY) / kStepY;
    
    for (int i = 0; i <= howManyHorizontal; i++)
    {
        

        
        CGContextMoveToPoint(context, kOffsetX, kGraphBottom - kOffsetY - i * kStepY);
        CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphBottom - kOffsetY - i * kStepY);
        
//        
//        UILabel *hoursLabel=[[UILabel alloc]initWithFrame:CGRectMake(kOffsetX-50, kGraphBottom - kOffsetY - i * kStepY-20, 40, 20)];
//        
//        hoursLabel.text=[NSString stringWithFormat:@"%d",i];
//        
//        //hoursLabel.backgroundColor=[UIColor redColor];
//        
//        [self addSubview:hoursLabel];

        
        
        
    }
    
    
    
    CGContextStrokePath(context);
    
    
    
    
    // Draw the bars
    
    float maxBarHeight = kGraphHeight - kBarTop - kOffsetY;
    
    for (int i = 0; i < sizeof(data); i++)
    {
        float barX;
        
       // barX=kStepX+i*kBarWidth+(i*kStepX)/2;// kStepX + i * kStepX - kBarWidth / 2;
        
        barX=kOffsetX+kBarWidth*(i*2+1);
        
        NSLog(@"gap : %f",barX);
        
        float barY = kBarTop + maxBarHeight - maxBarHeight * data[i];
        
        //float barY = kGraphBottom;
        
        float barHeight = maxBarHeight * data[i];
        

        barRect = CGRectMake(barX, barY, kBarWidth, barHeight);
        
        
            UIView *barView=[[UIView alloc]initWithFrame:barRect];
        
            barView.backgroundColor=[UIColor colorWithRed:(119.0f/255) green:(189.0f/255) blue:(34.0f/255) alpha:1];
        
           [self addSubview:barView];


      [self animateViewHeight:barView withAnimationType:kCATransitionFromTop];
        
        
        [self addSubview:barView];
        
        
        
       
        
        
    }

}


- (void)animateViewHeight:(UIView*)animateView withAnimationType:(NSString*)animType {
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:animType];
    
    [animation setDuration:0.5];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[animateView layer] addAnimation:animation forKey:kCATransition];
    //animateView.hidden = !animateView.hidden;
    
    

    
}





@end
