//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    [self.view addSubview:self.petImageView];
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:0.0].active = YES;

    self.petImageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(petPhonagotchi:)];
    [self.petImageView addGestureRecognizer:panGesture];
   
}

-(void)petPhonagotchi:(UIPanGestureRecognizer*)sender {
    
    CGPoint velocity = [sender velocityInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(velocity));
    if (velocity.x > 200 || velocity.y > 200) {
        self.petImageView.image = [UIImage imageNamed:@"grumpy"];
    }
    else {
        self.petImageView.image = [UIImage imageNamed:@"default"];
    }
//    CGPoint translationInView = [sender translationInView:self.petImageView];
//
//    CGPoint oldCenter = sender.view.center;
//    CGPoint newCenter = CGPointMake(oldCenter.x + translationInView.x, oldCenter.y + translationInView.y);
//    sender.view.center = newCenter;
//    [sender setTranslation:CGPointZero inView:self.view];

    
//    [self.petImageView addGestureRecognizer:self.panGestureRecognizer];
}

@end
