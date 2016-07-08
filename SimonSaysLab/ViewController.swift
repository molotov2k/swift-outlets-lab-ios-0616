//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var redButtonOutlet: UIButton!
    @IBOutlet weak var greenButtonOutlet: UIButton!
    @IBOutlet weak var yellowButtonOutlet: UIButton!
    @IBOutlet weak var blueButtonOutlet: UIButton!

    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.hidden = true
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(sender: UIButton) {
        simonSaysGame = SimonSays()

        winLabel.hidden = true
        
        UIView.transitionWithView(startGameButton, duration: 0.9, options: .TransitionFlipFromBottom , animations: {
            self.startGameButton.hidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    private func displayTheColors() {
        self.view.userInteractionEnabled = false
        UIView.transitionWithView(displayColorView, duration: 1.5, options: .TransitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.userInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
    
    @IBAction func redButtonAction(sender: AnyObject) {
        simonSaysGame.guessRed()
        endGame()
    }
    @IBAction func greenButtonAction(sender: AnyObject) {
        simonSaysGame.guessGreen()
        endGame()
    }
    @IBAction func yellowButtonAction(sender: AnyObject) {
        simonSaysGame.guessYellow()
        endGame()
    }
    @IBAction func blueButtonAction(sender: AnyObject) {
        simonSaysGame.guessBlue()
        endGame()
    }
    
    func endGame() {
        if simonSaysGame.endGame() {
            winLabel.hidden = false
            startGameButton.hidden = false
            if simonSaysGame.wonGame() {
                winLabel.text = "You won!"
            } else {
                winLabel.text = "You lost!"
            }
        }
    }
    
    
}
