//
//  SoundManager.swift
//  GuessIt
//
//  Created by Khawlah on 10/01/2023.
//

import Foundation
import AVKit

enum SoundType: String {
    case successSound = "successSound"
    case wrongSound = "wrongSound"
}

class SoundManager {
    
    static let shared = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound(soundType: SoundType) {
        guard let url = Bundle.main.url(forResource: soundType.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
