//
//  ViewController.swift
//  calculatorApp
//
//  Created by 岩永彩里 on 2018/06/28.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit
//import Foundation
import Expression

class ViewController: UIViewController {
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonDot: UIButton!
    @IBOutlet weak var buttonLeftBracket: UIButton!
    @IBOutlet weak var buttonRightBracket: UIButton!
    @IBOutlet weak var buttonDivision: UIButton!
    @IBOutlet weak var buttonMultiplication: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonAC: UIButton!
    @IBOutlet weak var buttonTotal: UIButton!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var mickey: UIImageView!
    
    var sum: String = ""
    var isTapOperateButton: Bool = false
    var tapOperateButtonTitle: String = ""
    var tapNumericButtonTitle: String = ""
    
    
   // init(){
       // resultLabel = UILabel()
     //  isTapOperateButton = false
     //   tapOperateButtonTitle = ""
     //   sum = 0
        
     //   super.init(nibName: nil, bundle: nil)
   // }
    
    //required init?(coder aDecoder: NSCoder) {
      //  fatalError("init(coder:) has not been implemented")
    //}
    
    private struct Constant {
        static let operateButtonLabels = "C=+-x÷"
        static let operateButtonLabels2 = "+-x÷"
        static let operateButtonLabels3 = "123456789("
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         //mickey.image = UIImage(named: "ミッキー１.png")
        button0.layer.cornerRadius = button0.frame.width / 4
         button1.layer.cornerRadius = button1.frame.width / 4
         button2.layer.cornerRadius = button2.frame.width / 4
         button3.layer.cornerRadius = button3.frame.width / 4
         button4.layer.cornerRadius = button4.frame.width / 4
         button5.layer.cornerRadius = button5.frame.width / 4
         button6.layer.cornerRadius = button6.frame.width / 4
         button7.layer.cornerRadius = button7.frame.width / 4
        button8.layer.cornerRadius = button8.frame.width / 4
        button9.layer.cornerRadius = button9.frame.width / 4
        buttonDot.layer.cornerRadius = buttonDot.frame.width / 4
        buttonLeftBracket.layer.cornerRadius = buttonLeftBracket.frame.width / 4
        buttonRightBracket.layer.cornerRadius = buttonRightBracket.frame.width / 4
        buttonDivision.layer.cornerRadius = buttonDivision.frame.width / 4
        buttonMultiplication.layer.cornerRadius = buttonMultiplication.frame.width / 4
        buttonMinus.layer.cornerRadius = buttonMinus.frame.width / 4
        buttonPlus.layer.cornerRadius = buttonPlus.frame.width / 4
        buttonAC.layer.cornerRadius = buttonAC.frame.width / 4
        buttonTotal.layer.cornerRadius = buttonTotal.frame.width / 15
        
        
        self.view.backgroundColor = UIColor.black
        buttonDivision.layer.borderColor = UIColor.white.cgColor
        buttonDivision.layer.borderWidth = 2
        buttonMultiplication.layer.borderColor = UIColor.white.cgColor
        buttonMultiplication.layer.borderWidth = 2
        buttonMinus.layer.borderColor = UIColor.white.cgColor
        buttonMinus.layer.borderWidth = 2
        buttonPlus.layer.borderColor = UIColor.white.cgColor
        buttonPlus.layer.borderWidth = 2
        buttonTotal.layer.borderColor = UIColor.white.cgColor
        buttonTotal.layer.borderWidth = 1
        
        resultLabel.adjustsFontSizeToFitWidth = true
        formulaLabel.adjustsFontSizeToFitWidth = true
        resultLabel.text = "0"
        formulaLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //ボタンを押されたときのアクション
    @IBAction func inputFormula(_ sender: UIButton) {
        //***guard let formulaText = formulaLabel.text else{
        guard let resultText = resultLabel.text else{
            return
        }
        guard let senderedText = sender.titleLabel!.text else{
            return
        }
        //①様々な制約
        //イコールでの画像の切り替える
        if sender.titleLabel!.text == "="{
            mickey.image = UIImage(named: "calculated.png")
            
        //+-x÷が押されたら、下段の数字と+-x÷を上段に追加する。(下の計算ボタンの処理に入れるのなぜかならなかった、、、のでここで実装)
        }else if Constant.operateButtonLabels2.contains(senderedText) {
            
            if tapNumericButtonTitle == "" && senderedText == "-"{ //最初に-が入力された場合は下の実装を適用する
                didTapOperateButton(buttonTitle: senderedText)
            
            //記号続きで入力された場合...後に押された記号を優先する
            }else if Constant.operateButtonLabels2.contains(senderedText) && Constant.operateButtonLabels2.contains(String(formulaLabel.text!.suffix(1))) && isTapOperateButton{
            formulaLabel.text = String(formulaLabel.text!.prefix(formulaLabel.text!.count - 1)) + senderedText
            resultLabel.text = resultText
                
            }else{
            formulaLabel.text = formulaLabel.text! + resultText + senderedText
            resultLabel.text = resultText
            }
            
        //イコール以外の画像を指定
        }else {
            mickey.image = UIImage(named: "calculating.png")
        }

        
        //②数字のボタンか計算ボタンかで場合わけ
        if let buttonTitle = sender.titleLabel?.text {
            if Constant.operateButtonLabels.contains(buttonTitle) {
                didTapOperateButton(buttonTitle: buttonTitle)
                isTapOperateButton = true
            } else {
                didTapNumericButton(buttonTitle: buttonTitle)
                isTapOperateButton = false
            }
        }
    }
    
    
    //②ーA.数字のボタンの時の処理
    func didTapNumericButton(buttonTitle: String) {
        
        //基本的処理
        if isTapOperateButton {
            if  buttonTitle != "." && buttonTitle != ")"{
                if tapNumericButtonTitle == "" && tapOperateButtonTitle == "-"{ //最初に-を押した後に数字を入力された場合（-2などと表示する場合）
                    resultLabel.text = tapOperateButtonTitle + buttonTitle
                }else{                                                          //基本的に最初は、0を消して入力された数字を表示する
                    resultLabel.text =  buttonTitle
                }
            }else if buttonTitle == "." { //Cを押した後に小数点押された場合
                resultLabel.text = "0."
            }
        }else if resultLabel.text == "0" &&  buttonTitle == "."{  //最初に小数点押された場合
            resultLabel.text = "0."
        }else if resultLabel.text == "0" && buttonTitle == "0" {  //連続して0が押された場合
            resultLabel.text = resultLabel.text
        }else if resultLabel.text == "0" && Constant.operateButtonLabels3.contains(buttonTitle) {  //最初に数字が押された場合(表示されてる0を消す)
            resultLabel.text = buttonTitle
        }else if resultLabel.text!.contains(".") && buttonTitle == "."{//小数点が２回押された場合(2回目のは表示されない)
            if isTapOperateButton && Constant.operateButtonLabels2.contains(tapOperateButtonTitle)  && buttonTitle == "." {
                resultLabel.text =  "0."    //+-x÷のあとに小数点が押された場合（自動で"0."と表示させる）
            }else {
            resultLabel.text = resultLabel.text
            }
        }else if resultLabel.text!.contains("(") && buttonTitle == "("{ //連続して(が押された場合
            resultLabel.text = resultLabel.text
        }else if buttonTitle == ")" {  //最初に)が押された場合
            if  resultLabel.text == "0" {
                resultLabel.text = resultLabel.text
            }else{
                resultLabel.text = resultLabel.text! + buttonTitle
            }
        }else {
            resultLabel.text = resultLabel.text! + buttonTitle
        }
        
       
        //イコールで一度計算した後の処理
        if  isTapOperateButton && tapOperateButtonTitle == "="{
            if buttonTitle == "."{
            resultLabel.text = "0."
            formulaLabel.text = ""
            }else{
            resultLabel.text = buttonTitle
            formulaLabel.text = ""
            }
        }else{
        }
        tapNumericButtonTitle = buttonTitle
    }
    
    //②ーB.計算ボタンが押された時の処理
    func didTapOperateButton(buttonTitle: String) {
            guard let resultLabelText = resultLabel.text
                 else {
                    return
            }
            if buttonTitle == "C" {
                resultLabel.text = "0"
                formulaLabel.text = ""
                tapOperateButtonTitle = ""
                tapNumericButtonTitle = ""
                return
            }
            if buttonTitle == "=" {
                 let finalFormula = formulaLabel.text! + resultLabelText
                 let formula: String = formatFormula(finalFormula)
                 let finalanswer = evalFormula(formula)
                
                if tapOperateButtonTitle == "="{ //イコールが連打された時は、上下段とも表示を変えない
                resultLabel.text = resultLabel.text
                formulaLabel.text = formulaLabel.text
                }else{
                 resultLabel.text = finalanswer
                 formulaLabel.text = finalFormula
                 sum = finalanswer
                 tapOperateButtonTitle = buttonTitle
                }
            }
            if buttonTitle == "-" || buttonTitle == "+" || buttonTitle == "x" || buttonTitle == "÷" {
                
                if  isTapOperateButton {
                    if tapOperateButtonTitle == "="  {
                        formulaLabel.text = sum + buttonTitle
                        resultLabel.text = sum
                    }else if tapOperateButtonTitle == "" || resultLabel.text == "0" { //最初とCを押した後の計算
                        switch buttonTitle {
                        case "-" :
                            
                            formulaLabel.text = ""
                            resultLabel.text = "0"
                            
                        case "+" :
                            formulaLabel.text = ""
                            resultLabel.text = "0"
                            
                        default : break
                        }
                    }
                }
                tapOperateButtonTitle = buttonTitle
            }
    }
            
            //if tapOperateButtonTitle == "" || tapOperateButtonTitle == "=" {
              //  sum = displayNumericValue
                //resultラベルに表示されたそれまでの合計をsumに代入
              //  tapOperateButtonTitle = buttonTitle
              //  return
            //}
        
            //switch tapOperateButtonTitle {
            //case "+":
            //    sum += displayNumericValue
            //case "-":
            //    sum -= displayNumericValue
            //case "x":
            //    sum *= displayNumericValue
            //case "÷":
            //    sum /= displayNumericValue
            //default:
            //    return
            //}
        
        
            //tapOperateButtonTitle = buttonTitle
            

    
    func formatAnswer(_ answer: String) -> String {
        // 答えの小数点以下が`.0`だった場合は、`.0`を削除して答えを整数で表示する
        let formattedAnswer: String = answer.replacingOccurrences(
            of: "\\.0$",
            with: "",
            options: NSString.CompareOptions.regularExpression,
            range: nil)
        return formattedAnswer
    }
    
    func evalFormula(_ formulaLabelText: String) -> String {
        do {
            // Expressionで文字列の計算式を評価して答えを求める
            let expression = Expression(formulaLabelText)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            // 計算式が不当だった場合
            return "正しい式かな？"
        }
    }
    
    func formatFormula(_ formula: String) -> String {
        // 入力された整数には`.0`を追加して小数として評価する
        // また`÷`を`/`に、`×`を`*`に置換する
        let formattedFormula: String = formula.replacingOccurrences(
            of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
            with: "$1.0",
            options: NSString.CompareOptions.regularExpression,
            range: nil
            ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "x", with: "*")
        return formattedFormula
    }

    
    
    
    // 変数の定義
    //double value = 0.1;
    // NSNumberにいったん変換する
    //NSNumber* number = [[NSNumber alloc] initWithDouble:sum];
    // 小数点以下の0を除去して文字列に変換する
    //NSString* strings = [number stringValue];
    // 結果をコンソールへ出力する
    //NSLog( @"%@", strings );



}


