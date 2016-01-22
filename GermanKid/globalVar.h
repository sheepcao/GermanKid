//
//  globalVar.h
//  dotaer
//
//  Created by Eric Cao on 7/6/15.
//  Copyright (c) 2015 sheepcao. All rights reserved.
//

#ifndef dotaer_globalVar_h
#define dotaer_globalVar_h


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define categoryViewHeight  100
#define categoryBtnHeight  60


#define REVIEW_URL @"https://itunes.apple.com/cn/app/dota-quan-zi/id1028906602?ls=1&mt=8"

#define ALLAPP_URL @"itms://itunes.apple.com/us/artist/cao-guangxu/id844914783"

#define VERSIONNUMBER   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define ADMOB_ID @"ca-app-pub-3074684817942615/4321450681"




#endif


