//
//  Game.swift
//  Act5iOS
//
//  Created by Alumno on 12/11/22.
//

import Foundation

struct Game{
  
    //se crea las variables
    var word: String
    var incorrectMovesRemaining: Int
    var guessedCharacters: [Character]
    
    
    mutating func playerGuessed(letter: Character) {
        guessedCharacters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
        
    }
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedCharacters.contains(letter) {
                guessedWord += "\(letter) "
            } else {
                guessedWord += "_ "
            }
        }
        return guessedWord.uppercased()
    }
    
}

