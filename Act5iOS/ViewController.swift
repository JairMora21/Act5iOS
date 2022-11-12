//
//  ViewController.swift
//  Act5iOS
//
//  Created by Alumno on 12/11/22.
//

import UIKit

//Lista de palabras a usar
var listOfWords = ["telefono", "swift", "mouse", "teclado", "chivas"]

//maximo de intentos
let incorrectMovesAllowed = 7



class ViewController: UIViewController {
    
    //numeros de victorias y derrotas
    
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLoss = 0 {
        didSet {
            newRound()
        }
    }

    //mandamos a llamar la image, y ambos labels (palabra y puntuacion)
    @IBOutlet weak var treeImage: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //Se crea una arreglo de botones del teclado
    @IBOutlet var letterButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }
    
    //se manda a llamar la estructura Game
    var currentGame: Game!
    
    //se crea el metodo new ¡Round para iniciar una nueva partida
    func newRound(){

        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedCharacters: [])
            enableLetterButtons(enable: true)
            updateUI()
        } else {
            enableLetterButtons(enable: false)
        }
        
    }
    
    //Activa o descativa las letras del teclado
    func enableLetterButtons( enable: Bool){
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    //Actualiza la vista, como el arbol cuando cae una manzana, victorias y derrotas
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        
        let separated = letters.joined(separator: " ")
        correctWordLabel.text = separated
        
        
        
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLoss)"
        treeImage.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
        
    }

    //cada que se teclea una letra se inhabilita
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        let letterString = sender.currentTitle!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    //cada que se gana o pierde se actualiza el marcador
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLoss += 1
        } else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        } else {
            updateUI()
        }

        
    }
    
}

