//
//  AppDelegate.m
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "AppDelegate.h"
#import "LJBMainViewController.h"
#import "LJBSliderMenuViewController.h"
#import "IIViewDeckController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIViewController * viewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UMSocialData setAppKey:APPKey];
    
//    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    
    LJBSliderMenuViewController * sliderVC = [[LJBSliderMenuViewController alloc] init];
    
    LJBMainViewController * mainVC = [[LJBMainViewController alloc] init];
    
    IIViewDeckController * deckVC = [[IIViewDeckController alloc] initWithCenterViewController:mainVC leftViewController:sliderVC];
    deckVC.leftSize = 100;
    
    __weak LJBMainViewController * weakMain = mainVC;
    // 菜单回调方法
    mainVC.OpenLeftMenuViewAction = ^(BOOL isOpen){
        
        if (isOpen) {
            // 关闭左视图
            [deckVC closeLeftView];
            weakMain.coverView.hidden = YES;
            
        } else {
            // 滑出左视图
            [deckVC openLeftView];
            weakMain.coverView.hidden = NO;
        }
    };
    
    self.window.rootViewController = deckVC;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
