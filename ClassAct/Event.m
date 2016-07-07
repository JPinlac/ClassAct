//
//  Event.m
//  ClassAct
//
//  Created by DetroitLabs on 7/7/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "Event.h"

@implementation Event
- (id) initWithDate:(NSDate *)start
                end:(NSDate *)end
   eventDescription:(NSString *)eventDescription
        hangoutLink:(NSString *)hangoutLink
            summary:(NSString *)summary
           location:(NSString *)location{
    self.start = start;
    self.end = end;
    self.eventDescription = eventDescription;
    self.hangoutLink = hangoutLink;
    self.summary = summary;
    self.location = location;
    return self;
}
@end
