//
//  Calendar.h
//  
//
//  Created by DetroitLabs on 7/7/16.
//
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject
@property NSMutableDictionary *events;
+ (instancetype)sharedInstance;
@end
