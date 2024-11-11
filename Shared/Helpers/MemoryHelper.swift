//
//  MemoryHelper.swift
//  EmojiTest
//
//  Created by Mohamed Salah on 11/11/2024.
//

import MachO

class MemoryHelper {
    
    // MARK: - Singleton
    
    static let shared = MemoryHelper()
    private init() { }
    
    // MARK: -
    
    private static func currentTotalMemoryUseInBytes() -> Int64 {
        var info = task_vm_info_data_t()
        var count = mach_msg_type_number_t(MemoryLayout.size(ofValue: info) / MemoryLayout<Int32>.size)

        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
            }
        }

        if kerr == KERN_SUCCESS {
            let size = Int64(info.phys_footprint)
            return size
        } else {
            return -1
        }
    }
    
    /// Total memory limit
    private let memoryLimitInMBs: Int64 = 77
    private var dummyPointer: UnsafeMutableRawPointer?
    
    
    /// Fills the memory by allocating a dummy pointer
    /// - Parameter fraction: the amount of memory relative to the memory limit to allocate
    func fillMemoryLimit(fraction: Double) {
        if dummyPointer != nil { free(dummyPointer) }
        let currentMemoryUsageInBytes = Self.currentTotalMemoryUseInBytes()
        let limit: Int64 = memoryLimitInMBs * 1_024 * 1_024
        
        let target = Int(Int64(fraction * Double(limit)) - currentMemoryUsageInBytes)
        dummyPointer = malloc(target)
        
        if dummyPointer != nil {
            // Initialize the allocated memory with a specific value (e.g., 2)
            memset(dummyPointer, 2, target)
        }
    }
}
