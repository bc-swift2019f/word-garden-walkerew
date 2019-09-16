//
//  ViewController.swift
//  Word Garden
//
//  Created by Emily Walker on 9/15/19.
//  Copyright © 2019 Emily Walker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessLetterField: UITextField!
    
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    var doneKey = 0
    var guessLetter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }

    
    func updateUIAfterGuess(){
        guessLetterField.resignFirstResponder()
        guessLetterField.text = ""
        doneKey = 0
        guessLetter = 0
    }
    
    func formatUserGuessLabel(){
        var revealedWord = ""
        lettersGuessed += guessLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord += " \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    func guessALetter() {
        formatUserGuessLabel()
        print("Guess a letter function called")
        print(wrongGuessesRemaining)
        
        guessCount += 1
        
        // decrements the wrongGuessesRemaining and shows the next flower
        // image with one less pedal
        let currentLetterGuessed = guessLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed){
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        print(wrongGuessesRemaining)
        }
        
        let revealedWord = userGuessLabel.text!
        // Stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you're all out of guesses. Try again?"
        } else if !revealedWord.contains("_") {
            //You've won a game!
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
        } else {
            let guess = ( guessCount == 1 ? "guess" : "guesses")
            guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
    }
    
    //checked
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessLetterField.text?.last {
            guessLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            //disable the button if I don't have a single character in the guessedLetterField
            guessLetterButton.isEnabled = false
        }
    }
    
    // checked
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        print("doneKeyPressed")
        doneKey = 1
        if guessLetter == 0 {
            guessALetter()
        }
        updateUIAfterGuess()
    }
    
    // checked
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        print("guessLetterButtonPressed")
        guessLetter = 1
        if doneKey == 0 {
            guessALetter()
        }
        updateUIAfterGuess()
        
        
    }
    // checked
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses"
        guessCount = 0
    }
    
}

