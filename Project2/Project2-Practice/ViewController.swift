//
//  ViewController.swift
//  Project2-Practice
//
//  Created by Ayaka Mihara on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]() //新しい文字列の配列を保持するcountriesという新しいプロパティ
    var score = 0 // 0に設定されたscoreの新しいプロパティ
    var correctAnswer = 0
    var askedQuestions = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }


    // 画面に3つのランダムな旗の画像を表示するメソッド
    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        let uppercasedCountry = countries[correctAnswer].uppercased()
        title = "Score: \(score) - Choose \(uppercasedCountry)'s flag"
        
        askedQuestions += 1 //質問した回数をカウント
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong!"
            score -= 1
        }
       
        // ゲームスタートの設定
        func startNewGame(action: UIAlertAction) {
            score = 0
            askedQuestions = 0
            
            askQuestion()
        }
        //質問を１０回したらゲームオーバー、それ以外は質問続行の設定
        if askedQuestions == 10 {
            let finalAc = UIAlertController(title: "Game over!", message: "You have answered 10 questions. Your total score is \(score).", preferredStyle: .alert)
            finalAc.addAction(UIAlertAction(title: "Start new game!", style: .default, handler: startNewGame))
            present(finalAc, animated: true)
            score = 0
            askedQuestions = 0
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
      
    }
    
}

