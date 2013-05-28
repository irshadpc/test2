//
//  SHEventDataController.h
//  testGitHub2
//
//  Created by sathachie on 2013/05/28.
//  Copyright (c) 2013年 SH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface SHEventDataController : NSObject

+ (void)requestAccess:(EKEventStore *)eventStore;
+ (NSArray *)allEvent:(EKEventStore *)eventStore;

@end
