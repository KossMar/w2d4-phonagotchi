//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@interface LPGViewController ()

@property (nonatomic) LPGPet *pet;
@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) UIPinchGestureRecognizer *pinchGestureRecognizer;
@property (nonatomic) UIImageView *bucketImageView;
@property (nonatomic) UIImageView *appleImageView;
@property (nonatomic) UIImageView *secondAppleImageView;


@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.pet = [[LPGPet alloc] init];

    
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


    self.bucketImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.image = [UIImage imageNamed:@"bucket"];
    [self.view addSubview:self.bucketImageView];
    
    [[self.bucketImageView.widthAnchor constraintEqualToConstant:80] setActive:YES];
    [[self.bucketImageView.heightAnchor constraintEqualToAnchor:self.bucketImageView.widthAnchor] setActive:YES];
    [[self.bucketImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-50] setActive:YES];
    [[self.bucketImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:50] setActive:YES];
    
    self.appleImageView = [[UIImageView alloc] initWithFrame:self.bucketImageView.frame];
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleImageView.image = [UIImage imageNamed:@"apple"];
    [self.view addSubview:self.appleImageView];
    
    [[self.appleImageView.widthAnchor constraintEqualToConstant:60] setActive:YES];
    [[self.appleImageView.heightAnchor constraintEqualToAnchor:self.appleImageView.widthAnchor]setActive:YES];
    [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bucketImageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:1.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bucketImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:1.0].active = YES;

    
    self.secondAppleImageView = [[UIImageView alloc]initWithFrame:self.appleImageView.frame];
    self.secondAppleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.secondAppleImageView.image = [UIImage imageNamed:@"apple"];
    [[self.secondAppleImageView.widthAnchor constraintEqualToConstant:60] setActive:YES];
    [[self.secondAppleImageView.heightAnchor constraintEqualToAnchor:self.secondAppleImageView.widthAnchor]setActive:YES];
    [self.view addSubview:self.secondAppleImageView];
    [self.secondAppleImageView setHidden:YES];
    
    
    self.petImageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(petPhonagotchi:)];
    [self.petImageView addGestureRecognizer:panGesture];
    
    self.appleImageView.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *feedingGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(feedPhonagotchi:)];
    [self.appleImageView addGestureRecognizer:feedingGesture];
    
    [self.secondAppleImageView setUserInteractionEnabled:NO];
    UIPanGestureRecognizer *panGesture2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveApple:)];
    [self.secondAppleImageView addGestureRecognizer:panGesture2];
}




-(void)petPhonagotchi:(UIPanGestureRecognizer*)sender {
    
    CGPoint velocity = [sender velocityInView:sender.view];
    NSLog(@"%@", NSStringFromCGPoint(velocity));
    [self.pet petPet:velocity];
    if (self.pet.isGrumpy) {
        self.petImageView.image = [UIImage imageNamed:@"grumpy"];
    }
    else {
        self.petImageView.image = [UIImage imageNamed:@"default"];
    }
    
    
}

- (void)feedPhonagotchi:(UIPinchGestureRecognizer*)sender {
    
    NSLog(@"Apple added");
    
    [self.secondAppleImageView setHidden:NO];
    [self.secondAppleImageView setUserInteractionEnabled:YES];
    
    self.secondAppleImageView.center =  self.appleImageView.center;
    
}

- (void)moveApple:(UIPanGestureRecognizer*)sender {
    NSLog(@"Apple move");

    CGPoint locationInView = [sender locationInView:self.view];
        sender.view.center = locationInView;
    
    
    
    switch (sender.state) {
        case UIGestureRecognizerStateEnded:
            if (CGRectIntersectsRect(self.secondAppleImageView.frame, self.petImageView.frame)) {
                [UIImageView animateWithDuration:2 animations:^{
                    self.secondAppleImageView.alpha = 0;
                } completion:^(BOOL finished) {
                    [self.secondAppleImageView setHidden:YES];
                    self.secondAppleImageView.center = self.appleImageView.center;
                    [self.secondAppleImageView setUserInteractionEnabled:NO];
                    self.secondAppleImageView.alpha = 100;
                }];
            }
            else {
                CGPoint point = CGPointMake(self.secondAppleImageView.frame.origin.x, 1000);
                [UIImageView animateWithDuration:2 animations:^{
                    self.secondAppleImageView.center = point;
                } completion:^(BOOL finished) {
                    [self.secondAppleImageView setHidden:YES];
                    self.secondAppleImageView.center = self.appleImageView.center;
                    [self.secondAppleImageView setUserInteractionEnabled:NO];
                }];
            }
            break;
    }
    
}












//    self.copyAppleImageView = [[UIImageView alloc] initWithFrame:self.appleImageView.frame];
//    CGPoint location = [sender locationInView:sender.view];
//
//    switch (sender.state) {
//        case UIGestureRecognizerStateBegan:
//            if (CGRectIntersectsRect(CGRectMake(location.x, location.y, 0, 0), self.bucketImageView.frame)) {
//                self.anotherAppleImageView = [[UIImageView alloc] initWithFrame:self.appleViewImage.frame];
//
//            }
//            break;
//        case UIGestureRecognizerStateChanged:
//
//            break;
//
//        case UIGestureRecognizerStateEnded:
//            if (CGRectIntersectsRect(self.anotherAppleImageView.frame, self.petImageView.frame)) {
//                [UIView animateWithDuration:2 animations:^{
//                    self.anotherAppleImageView.alpha = 0;
//                } completion:^(BOOL finished) {
//                    if (self.myPhonagotchi.isGrumpy) {
//
//                    }
//                }]
//            }
//            break;
//        default:
//            break;
//    }
    
//    if (velocity.x > 200 || velocity.y > 200) {
//        self.petImageView.image = [UIImage imageNamed:@"grumpy"];
//    }
//    else {
//        self.petImageView.image = [UIImage imageNamed:@"default"];
//    }

//    CGPoint translationInView = [sender translationInView:self.petImageView];
//
//    CGPoint oldCenter = sender.view.center;
//    CGPoint newCenter = CGPointMake(oldCenter.x + translationInView.x, oldCenter.y + translationInView.y);
//    sender.view.center = newCenter;
//    [sender setTranslation:CGPointZero inView:self.view];

    
//    [self.petImageView addGestureRecognizer:self.panGestureRecognizer];


@end
