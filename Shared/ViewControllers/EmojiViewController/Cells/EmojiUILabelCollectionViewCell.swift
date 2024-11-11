//
//  EmojiUILabelCollectionViewCell.swift
//  EmojiTest
//
//  Created by Mohamed Salah on 14/08/2024.
//

import UIKit

class EmojiUILabelCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var emojiLabel: UILabel!
    
    var emoji: String {
        set {
            emojiLabel.text = newValue
        }
        get {
            emojiLabel.text ?? ""
        }
    }
}
