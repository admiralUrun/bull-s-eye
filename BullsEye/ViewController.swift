//
//  ViewController.swift
//  BullsEye
//
//  Created by Andrew Yakovenko on 11/22/18.
//  Copyright © 2018 Andrew Yakovenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 0
    var targetValue :Int = 0
    var score = 0
    var roundVaulse = 0
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var roundsLable: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundValue = slider.value.rounded()
        currentValue = Int(roundValue)
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "Probe 03")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHightted = #imageLiteral(resourceName: "Probe 03 copy")
        slider.setThumbImage(thumbImageHightted, for: .highlighted)
        
    }

    @IBAction func showAlert() {
        let points = givePoints(target: targetValue, current: currentValue)
        let title : String
        if points == 200 {
            title = "Perfect !"
        } else if points >= 90 {
            title = "You almoste had it"
        } else if points == 10 {
            title = "It's ok"
        } else {
            title = "Nope"
        }
        
        let message = "The value of the slider is now \(currentValue)" + "\nThe target value : \(targetValue)"
        
        let warning = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Sure", style: .default, handler: { xx -> Void in
            self.startNewRound()
        })
        
        warning.addAction(action)
        
        present(warning, animated: true, completion: nil)
        
    }
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundValue = slider.value.rounded()
        currentValue = Int(roundValue)
    }
    
    @IBAction func restartButton() {
        let message = "Are you sure ?"
        let alert = UIAlertController(title: "Gama will be restarted !!!", message: message, preferredStyle: .alert)
        
        let restar = UIAlertAction(title: "Sure", style: .default, handler: {
            actioni in
            self.startNewRound()
        })
        let backToGame = UIAlertAction(title: "NO, go back plz", style: .default , handler: nil)
        
        alert.addAction(restar)
        alert.addAction(backToGame)
        
    }
    
   
    func startNewRound () {
        score += givePoints(target: targetValue, current: currentValue)
        targetValue = Int.random(in: 1 ... 100)
        currentValue = 50
        slider.value = Float(currentValue)
        roundVaulse += 1
        updateLabels()
    }
    
    func givePoints(target:Int, current:Int) -> Int {
        let difference = target - current
        switch abs(difference) {
        case 0:
            return 200
        case 1 ..< 10 :
            return 100 - difference
        case 10 ..< 20 :
            return 10
        default:
            return 0
        }
    }
    
    func updateLabels() {
        targetLable.text = String(targetValue)
        scoreLable.text = String(score)
        roundsLable.text = String(roundVaulse)
    }
    
    func newGame() {
        currentValue = 0
        targetValue = 0
        score = 0
        roundVaulse = 0
        
        startNewRound()
    }
    
    
    
    
    
    
    
    
    
}



