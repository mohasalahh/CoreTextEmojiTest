//
//  CoreTextCacheManager.swift
//  EmojiTest
//
//  Created by Mohamed Salah on 15/08/2024.
//

import Foundation

@objcMembers
public class CoreTextCacheManager: NSObject {
    
    /// The cached objects of CoreText
    private static var caches = Set<NSCache<AnyObject, AnyObject>>()
    
    /// Stores a specific cache object from the swizzled methods in NSCache-Swizzling
    /// - Parameter cache: the cache object injected from `CoreText`
    static func addCache(_ cache: NSCache<AnyObject, AnyObject>) {
        caches.insert(cache)
    }
    
    /// Used to force empty all captured `CoreText` caches previously injected
    static func emptyCaches() {
        for cache in caches {
            cache.removeAllObjects()
        }
        caches.removeAll()
    }
}
