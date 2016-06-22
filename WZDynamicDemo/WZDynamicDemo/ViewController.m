//
//  ViewController.m
//  WZDynamicDemo
//
//  Created by songbiwen on 16/6/22.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;

@property (nonatomic, strong) UIDynamicAnimator *animatior;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self addCollisionBehavior];
//    [self addGravityBehavior];
    
    //吸附行为
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [self addSnapBehavior:point];
    
}


/** 吸附行为 */
- (void)addSnapBehavior:(CGPoint)point {
    
    [self.animatior removeAllBehaviors];
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self.redView snapToPoint:point];
    snapBehavior.damping = 1.0; //防抖动系数，值越大，抖动幅度越不明显
    [self.animatior addBehavior:snapBehavior];
}


/** 碰撞行为 */
- (void)addCollisionBehavior {
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
    [collisionBehavior addItem:self.redView];
//    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES; //以父视图为边界
    
    CGFloat width = self.view.frame.size.width;
    [collisionBehavior addBoundaryWithIdentifier:@"circle" forPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width, width)]]; //圆形为边界
    [self.animatior addBehavior:collisionBehavior];
}


/** 测试重力感应 */
- (void)addGravityBehavior {
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:self.redView];
    //重力感觉方向
    gravityBehavior.gravityDirection = CGVectorMake(1, 0);
    [self.animatior addBehavior:gravityBehavior];
}


/** 初始化 */
- (UIDynamicAnimator *)animatior {
    if (!_animatior) {
        
        //动画以哪个界面为参照物
        _animatior = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animatior;
}
@end
