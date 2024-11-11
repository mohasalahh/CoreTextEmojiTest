//
//  ViewController.swift
//  EmojiTest
//
//  Created by Mohamed Salah on 14/08/2024.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Actions
    
    @IBAction func swizzlingEnabledAc(_ sender: UISwitch) {
        if sender.isOn {
            NSCache<AnyObject, AnyObject>.swizzleNSCacheMethods()
        }else {
            NSCache<AnyObject, AnyObject>.unswizzleNSCacheMethods()
        }
    }
}

