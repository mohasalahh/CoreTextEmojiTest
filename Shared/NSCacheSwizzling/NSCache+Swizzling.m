//
//  NSCache+Swizzling.m
//  EmojiTest
//
//  Created by Mohamed Salah on 15/08/2024.
//

#import "NSCache+Swizzling.h"
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <execinfo.h>
#import <objc/runtime.h>


/// These are custom preprocessor macros set for each target to be able to include the correct auto-created swift bridging header.
#ifdef KEYBOARD_TARGET
#import "Keyboard-Swift.h"
#elif defined(EMOJITEST_TARGET)
#import "EmojiTest-Swift.h"
#endif

@implementation NSCache (Swizzling)

static Method originalSetObjectMethod = NULL;

+ (void)swizzleNSCacheMethods {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // Original and swizzled selectors
        SEL originalSelector = @selector(setObject:forKey:);
        SEL swizzledSelector = @selector(swizzled_setObject:forKey:);
        
        // Get the original method
        originalSetObjectMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        // Swizzle the methods
        method_exchangeImplementations(originalSetObjectMethod, swizzledMethod);
    });
}

+ (void)unswizzleNSCacheMethods {
    if (originalSetObjectMethod) {
        Class class = [self class];
        
        SEL swizzledSelector = @selector(swizzled_setObject:forKey:);
        
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        // Unswizzle by swapping the methods back
        method_exchangeImplementations(swizzledMethod, originalSetObjectMethod);
    }
}

/// Our own implmentation of the setObject selector in NSCache
/// - Parameters:
///   - obj: the object being cached
///   - key: unique key for each obj
- (void)swizzled_setObject:(id)obj forKey:(id)key {
    NSLog(@"Swizzled setObject:forKey: called with object: %@, key: %@", obj, key);
    
    BOOL isFromCT = [self isCallStackFromCT];
    
    // Log whether the call is from CoreText or not
    NSLog(@"isCallStackFromCT: %@", isFromCT ? @"YES" : @"NO");
    // Check if the object is of type CGImage
    if (isFromCT && obj && CFGetTypeID((__bridge CFTypeRef)obj) == CGImageGetTypeID()) {
        // add current cache object to cache manager
        [CoreTextCacheManager addCache: self];
    }
    
    // Proceed with the original implementation for other objects
    [self swizzled_setObject:obj forKey:key]; // Calls the original implementation
}


/// Checks whether the call to setObject in an NSCache is called by CoreText or other frameworks
/// It determines this by requesting the current call stack and checking whether the symbols contain `CoreText`
- (BOOL)isCallStackFromCT {
    // Capture the call stack
    void *callstack[128];
    int frames = backtrace(callstack, 128);
    char **symbols = backtrace_symbols(callstack, frames);
    
    BOOL isFromCoreText = NO;
    for (int i = 0; i < frames; i++) {
        NSString *symbol = [NSString stringWithUTF8String:symbols[i]];
        if ([symbol containsString:@"CoreText"]) {
            isFromCoreText = YES;
            break;
        }
    }
    
    free(symbols);
    return isFromCoreText;
}

@end
