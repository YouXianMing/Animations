//////////////////////////////////////
//                                  //
//  Copyright (c) 2015 YouXianMing  //
//                                  //
//////////////////////////////////////

#ifndef SIMPLE_NSLOG_H
#define SIMPLE_NSLOG_H

#import <Foundation/Foundation.h>
#import <asl.h>


#define THIS_FILE [(@"" __FILE__) lastPathComponent]


#define _NSLog(fmt,...) {                                             \
  do                                                                  \
  {                                                                   \
    NSString *str = [NSString stringWithFormat:fmt, ##__VA_ARGS__];   \
    printf("%s\n",[str UTF8String]);                                  \
    asl_log(NULL, NULL, ASL_LEVEL_NOTICE, "%s", [str UTF8String]);    \
  }                                                                   \
  while (0);                                                          \
}


#define NSLog(fmt, ...) _NSLog((@"%@:%d %s " fmt), THIS_FILE, __LINE__, __FUNCTION__, ##__VA_ARGS__)


#ifdef DEBUG
#define DLog(fmt, ...) _NSLog((@"%@:%d %s " fmt),    \
          THIS_FILE,                                 \
          __LINE__,                                  \
          __FUNCTION__,                              \
          ##__VA_ARGS__)
#else
    #define DLog(...)
#endif


#endif