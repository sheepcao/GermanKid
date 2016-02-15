//
//  AppDelegate.m
//  GermanKid
//
//  Created by Eric Cao on 1/19/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import "AppDelegate.h"
#import "globalVar.h"
#import "AFHTTPRequestOperationManager.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self requestSettingInfo];
    
    
    
    NSArray *allBanner = [[NSUserDefaults standardUserDefaults] objectForKey:ALL_BANNER];

    if (!allBanner || allBanner.count == 0 ) {
        NSArray *banners = @[@{@"banner_index":@"0",@"product_name":@"拼图游戏"},@{@"banner_index":@"1",@"product_name":@"秋千"}];
        [[NSUserDefaults standardUserDefaults] setObject:banners forKey:ALL_BANNER];
        
    }
    [self requestBannerInfo];


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


-(void)requestBannerInfo
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager.requestSerializer setTimeoutInterval:12];  //Time out after 25 seconds
    NSDictionary *parameters = @{@"tag": @"bannerInfo"};
    
    
    [manager POST:bannerURL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"prod Json: %@", responseObject);
        
        NSArray *banners = [responseObject objectForKey:@"banners"];
        [[NSUserDefaults standardUserDefaults] setObject:banners forKey:ALL_BANNER];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ups JsonError: %@", error.localizedDescription);
        NSLog(@"ups Json ERROR: %@",  operation.responseObject);
        
        
    }];
    
    
}

-(void)requestSettingInfo
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager.requestSerializer setTimeoutInterval:12];  //Time out after 25 seconds
    NSDictionary *parameters = @{@"tag": @"settingInfo"};
    
    
    [manager POST:settingURL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"prod Json: %@", responseObject);
        
        NSString *message = [responseObject objectForKey:@"message"];
        NSString *version = [responseObject objectForKey:@"version"];
        
        if (![version isEqualToString:VERSIONNUMBER]) {
            UIAlertView *updateAlert = [[UIAlertView alloc] initWithTitle:@"新版本提醒" message:message delegate:self cancelButtonTitle:@"暂不" otherButtonTitles:@"升级", nil];
            [updateAlert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ups JsonError: %@", error.localizedDescription);
        NSLog(@"ups Json ERROR: %@",  operation.responseObject);
        
        
    }];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:REVIEW_URL]];

    }
}


@end
