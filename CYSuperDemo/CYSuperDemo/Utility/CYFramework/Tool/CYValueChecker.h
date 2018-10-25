//
//  CYValueChecker.h
//  iOSShare
//
//  Created by cy on 15-10-3.
//  Copyright (c) 2015年 cy. All rights reserved.
//

#ifndef __CYValueChecker_h
#define __CYValueChecker_h

#define nilOrNull(obj) ((obj)==nil || [(obj) isEqual:[NSNull null]])
#define safeArray(obj) ((nilOrNull(obj) == NO && [(obj) respondsToSelector:@selector(objectAtIndex:)]) ? (obj) : nil)
#define safeDictionary(obj) ((nilOrNull(obj) == NO && [(obj) respondsToSelector:@selector(objectForKey:)]) ? (obj) : nil)

#define emptyString(obj) ([(obj) respondsToSelector:@selector(length)]==NO || (obj)==nil || [(obj) isEqual:[NSNull null]] || [(obj) length]==0)
#define safeString(obj) emptyString(obj) ? @"" : obj

#define convertableInteger(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(integerValue)])
#define convertableInt(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(intValue)])
#define convertableFloat(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(floatValue)])
#define convertableLong(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(longValue)])
#define convertableLongLong(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(longLongValue)])
#define convertableDouble(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(doubleValue)])
#define convertableLong(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(longValue)])
#define convertableBool(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(boolValue)])
#define convertableChar(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(charValue)])
#define convertableUnsignedChar(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(unsignedCharValue)])
#define convertableShort(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(shortValue)])
#define convertableUnsignedShort(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(unsignedShortValue)])
#define convertableUnsignedInt(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(unsignedIntValue)])
#define convertableUnsignedLong(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(unsignedLongValue)])
#define convertableUnsignedLongLong(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(unsignedLongLongValue)])
#define convertableunsignedInteger(obj) ((nilOrNull(obj)==NO) && [(obj) respondsToSelector:@selector(unsignedIntegerValue)])

#endif
