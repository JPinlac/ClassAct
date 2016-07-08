//
//  Calendar.m
//  
//
//  Created by DetroitLabs on 7/7/16.
//
//

#import "Calendar.h"

@implementation Calendar
+ (Calendar *)sharedInstance{
    static Calendar *eventList = nil;
    static dispatch_once_t onePredicate;
    
    dispatch_once(&onePredicate, ^{
        eventList = [[Calendar alloc] init];
        eventList.events = [NSMutableDictionary dictionary];
    });
    
    return eventList;
}
@end
