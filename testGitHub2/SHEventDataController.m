//
//  SHEventDataController.m
//  testGitHub2
//
//  Created by sathachie on 2013/05/28.
//  Copyright (c) 2013年 SH. All rights reserved.
//

#import "SHEventDataController.h"

@implementation SHEventDataController

+ (void)requestAccess:(EKEventStore *)eventStore
{
    //////////////////////////////////////////////////
    // カレンダーへのアクセス権を要求する iOS 6.0以降
    //////////////////////////////////////////////////

    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        
        EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
        
        switch (authorizationStatus) {
            case EKAuthorizationStatusNotDetermined:
                NSLog(@"未確認");
                [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                    
                    if (granted)
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"Authorized" object:nil];
                }];
                break;
                
            case EKAuthorizationStatusDenied:
                NSLog(@"拒否");
                break;
                
            case EKAuthorizationStatusAuthorized:
                NSLog(@"許可済み");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Authorized" object:nil];
                break;
                
            case EKAuthorizationStatusRestricted:
                NSLog(@"制限");
                break;
                
            default:
                break;
        }
    }
}

+ (NSPredicate *)predicateFromOneYearAgo:(EKEventStore *)eventStore
{
    //////////////////////////////////////////////////
    // 1年前から4年間のイベントを取得するための述語を作成
    //////////////////////////////////////////////////
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    dateComponents.year -= 1;
    
    //当日0:00の1年前
    NSDate *dateStart = [calendar dateFromComponents:dateComponents];
    NSLog(@"startDate:%@", dateStart.description);
    
    //さらに4年後
    dateComponents.year += 4;
    NSDate *dateEnd = [calendar dateFromComponents:dateComponents];
    NSLog(@"endDate:%@", dateEnd.description);
    
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:dateStart endDate:dateEnd calendars:nil];
    
    return predicate;
}

+ (NSArray *)allEvent:(EKEventStore *)eventStore
{
    //////////////////////////////////////////////////
    // 4年間のイベントを取得する
    //////////////////////////////////////////////////
    
    NSPredicate *predicate = [self predicateFromOneYearAgo:eventStore];
    
    NSArray *array = [eventStore eventsMatchingPredicate:predicate];
    
    return [array sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
}

@end
