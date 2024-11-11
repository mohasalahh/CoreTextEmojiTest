//
//  EmojisProvider.swift
//  EmojiTest
//
//  Created by Mohamed Salah on 15/08/2024.
//

import Foundation

struct EmojisProvider {
    static var emojis: [String] {
        guard let emojisURL = Bundle.main.url(forResource: "emojis", withExtension: "json") else {
            assertionFailure("Emojis File is not in bundle")
            return []
        }
        
        do {
            let data = try Data(contentsOf: emojisURL)
            let jsonData = try JSONDecoder().decode([String].self, from: data)
            return jsonData
        } catch {
            assertionFailure("Error deconding emoji file \(error)")
        }
        return []
    }
}
