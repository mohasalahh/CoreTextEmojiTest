//
//  EmojiViewController.swift
//  EmojiTest
//
//  Created by Mohamed Salah on 14/08/2024.
//

import UIKit

class EmojiViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet private weak var emojiCountLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    // Array to hold all emojis
    private let emojis = EmojisProvider.emojis
    
    deinit {
        CoreTextCacheManager.emptyCaches()
    }
    
    // MARK: - UIViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        emojiCountLabel.text = "Emoji count: \(emojis.count)"
    }
    
    // MARK: - Actions
    
    @IBAction func fill70PercentOfMemoryBtnAc(_ sender: UIButton) {
        
        /// This will cause CoreText to free up the cached glyphs
        
        MemoryHelper.shared.fillMemoryLimit(fraction: 0.7)
    }
    
    @IBAction func fill101PercentOfMemoryBtnAc(_ sender: UIButton) {
        
        /// This will cause the system to abruptly crash and terminate the keyboard extension
        
        MemoryHelper.shared.fillMemoryLimit(fraction: 1.02)
    }
}


// MARK: - UICollectionViewDataSource

extension EmojiViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as! EmojiUILabelCollectionViewCell
        cell.emoji = emojis[indexPath.row]
        return cell
    }
}
