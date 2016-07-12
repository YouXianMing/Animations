//
//  CalendarEvent.m
//  EventStore
//
//  Created by YouXianMing on 16/7/8.
//  Copyright © 2016年 XianMing You. All rights reserved.
//

#import "CalendarEvent.h"
#import <CommonCrypto/CommonDigest.h>
#import <EventKit/EventKit.h>

@implementation CalendarEvent

- (void)remove {
    
    NSString *eventId = [[NSUserDefaults standardUserDefaults] objectForKey:[self storedKey]];
    
    if (eventId) {
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEvent      *event      = [eventStore eventWithIdentifier:eventId];
        NSError      *error      = nil;
        [eventStore removeEvent:event span:EKSpanThisEvent error:&error];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(calendarEvent:removedStatus:error:)]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.delegate calendarEvent:self
                               removedStatus:error ? kCalendarEventAccessRemovedFailed : kCalendarEventAccessRemovedSucess
                                       error:nil];
            });
        }
    }
}

- (BOOL)haveSaved {
    
    NSString *eventId = [[NSUserDefaults standardUserDefaults] objectForKey:[self storedKey]];
    
    if (eventId.length) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

- (void)save {
    
    NSParameterAssert(self.eventTitle);
    NSParameterAssert(self.startDate);
    NSParameterAssert(self.endDate);
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        
        if (granted) {
            
            EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
            event.calendar  = [eventStore defaultCalendarForNewEvents];
            event.title     = self.eventTitle;
            event.startDate = self.startDate;
            event.endDate   = self.endDate;
            
            self.alarmDate            ? [event addAlarm:[EKAlarm alarmWithAbsoluteDate:self.alarmDate]] : 0;
            self.eventLocation.length ? event.location = self.eventLocation                             : 0;
            
            NSError *savedError = nil;
            if ([eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&savedError]) {
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(calendarEvent:savedStatus:error:)]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.delegate calendarEvent:self
                                         savedStatus:kCalendarEventAccessSavedSucess
                                               error:nil];
                    });
                }
                
                // 存储事件的键值
                [[NSUserDefaults standardUserDefaults] setObject:event.eventIdentifier forKey:[self storedKey]];
                
            } else {
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(calendarEvent:savedStatus:error:)]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.delegate calendarEvent:self
                                         savedStatus:kCalendarEventAccessSavedFailed
                                               error:savedError];
                    });
                }
            }
            
        } else {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(calendarEvent:savedStatus:error:)]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.delegate calendarEvent:self
                                     savedStatus:kCalendarEventAccessDenied
                                           error:error];
                });
            }
        }
    }];
}

- (NSString *)storedKey {
    
    NSParameterAssert(self.eventTitle);
    NSParameterAssert(self.startDate);
    NSParameterAssert(self.endDate);
    
    NSString *string = [NSString stringWithFormat:@"%@%@%@", self.eventTitle, self.startDate, self.endDate];
    
    return [self md532BitLower:string];
}

- (NSString*)md532BitLower:(NSString *)string {
    
    const char    *cStr = [string UTF8String];
    unsigned char  result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]] lowercaseString];
}

+ (instancetype)calendarEventWithEventTitle:(NSString *)title startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    
    CalendarEvent *event = [[self class] new];
    event.eventTitle     = title;
    event.startDate      = startDate;
    event.endDate        = endDate;
    
    return event;
}

@end
