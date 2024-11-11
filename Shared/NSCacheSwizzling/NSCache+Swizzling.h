//
//  NSCache+Swizzling.h
//  EmojiTest
//
//  Created by Mohamed Salah on 15/08/2024.
//

#import <Foundation/Foundation.h>

@interface NSCache (Swizzling)

/// Enables our own implementations of NSCache methods
+ (void)swizzleNSCacheMethods;

/// Disable our implementations of NSCache methods by resetting the default methods impl
+ (void)unswizzleNSCacheMethods;

@end
