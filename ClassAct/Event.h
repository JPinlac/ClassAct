//
//  Event.h
//  ClassAct
//
//  Created by DetroitLabs on 7/7/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
@property NSDate *start;
@property NSDate *end;
@property NSString *eventDescription;
@property NSString *hangoutLink;
@property NSString *summary;
@property NSString *location;
- (id) initWithDate:(NSDate *)start
                end:(NSDate *)end
   eventDescription:(NSString *)eventDescription
        hangoutLink:(NSString *)hangoutLink
            summary:(NSString *)summary
           location:(NSString *)location;
@end
