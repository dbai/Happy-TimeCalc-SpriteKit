//
//  GameViewController.swift
//  Happy TimeCalc
//
//  Created by David Pai on 2020/2/28.
//  Copyright © 2020 Pai Bros. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var currentGame: GameScene!
    
//    @IBOutlet var hr1: UITextField!
//    @IBOutlet var min1: UITextField!
//    @IBOutlet var sec1: UITextField!
//    @IBOutlet var hr2: UITextField!
//    @IBOutlet var min2: UITextField!
//    @IBOutlet var sec2: UITextField!
//    @IBOutlet var hrResult: UILabel!
//    @IBOutlet var minResult: UILabel!
//    @IBOutlet var secResult: UILabel!
    
    @IBOutlet weak var hrResult: UILabel!
    @IBOutlet weak var minResult: UILabel!
    @IBOutlet weak var secResult: UILabel!
    
    @IBOutlet weak var addRowButton: UIButton!
    @IBOutlet weak var separator: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    var focusedLabel: UILabel?
    
//    @IBOutlet weak var btn1: UIButton!
//    @IBOutlet weak var btn2: UIButton!
//    @IBOutlet weak var btn3: UIButton!
//    @IBOutlet weak var btn4: UIButton!
//    @IBOutlet weak var btn5: UIButton!
//    @IBOutlet weak var btn6: UIButton!
//    @IBOutlet weak var btn7: UIButton!
//    @IBOutlet weak var btn8: UIButton!
//    @IBOutlet weak var btn9: UIButton!
//    @IBOutlet weak var btn0: UIButton!
//    @IBOutlet weak var btnBackspace: UIButton!
    
    var removeRowButtons = [UIButton]() // 刪列按鈕
    var operatorButtons = [UIButton]() // 時間列前的 + 和 - 按鈕
    var operators = [Bool]() // 每列選到的運算元，true for +, false for -
    var timeRows = [[UILabel]]()
    
    var timeLabelBackgroundColor = UIColor(red: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0)
    var timeLabelBorderColor = UIColor.lightGray.cgColor
    
//    var focused: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
//            focused = hr1
            
            calculateButton.frame.origin.y = separator.frame.origin.y
            
            addRow(UIButton())
            timeRows[0][0].backgroundColor = self.timeLabelBackgroundColor
            focusedLabel = timeRows[0][0]
            addRow(UIButton())
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
//        if !validate() {
//            errorMessage.text = "有錯誤，請修正"
//            return
//        }
        
//        errorMessage.text = ""
//        for i in timeRows {
//            for j in i {
//                j.layer.borderColor = timeLabelBorderColor
//            }
//        }
        
        var totalSec = 0
        var totalSecN = 0
        
        for (i, row) in self.timeRows.enumerated() {
            let hrN = Int(row[0].text!)!
            let minN = Int(row[1].text!)!
            let secN = Int(row[2].text!)!

            totalSecN = hrN * 3600 + minN * 60 + secN
            
            if i == 0 {
                totalSec = totalSecN
            }
            else {
                if operators[i - 1] {
                    totalSec = totalSec + totalSecN
                }
                else {
                    totalSec = totalSec - totalSecN
                }
            }
        }
                
        let hrResult = totalSec / 3600
        let minResult = (totalSec % 3600) / 60
        let secResult = (totalSec % 3600) % 60
        
        self.hrResult.text = String(format: "%02d", hrResult)
        self.minResult.text = String(format: "%02d", minResult)
        self.secResult.text = String(format: "%02d", secResult)
    }
    
    @IBAction func addRow(_ sender: UIButton) {
        // 增加 + 和 - 按鈕
        if timeRows.count != 0 {
            let operatorRow: [UIButton] = [UIButton(type: .system), UIButton(type: .system)]

            if (self.operatorButtons.count == 0) {
                operatorRow[0].frame = CGRect(x: 129, y: 121, width: 30, height: 25) //+
                operatorRow[1].frame = CGRect(x: 167, y: 121, width: 30, height: 25) //-
            }
            else {
                operatorRow[0].frame = CGRect(x: 129/*self.operatorButtons[self.operatorButtons.count - 2].frame.origin.x*/, y: self.operatorButtons[self.operatorButtons.count - 2].frame.origin.y + 75, width: 30, height: 25) //+
                operatorRow[1].frame = CGRect(x: 167/*self.operatorButtons[self.operatorButtons.count - 1].frame.origin.x*/, y: self.operatorButtons[self.operatorButtons.count - 1].frame.origin.y + 75, width: 30, height: 25) //-
            }
            
            // 加進 operatorButtons 陣列以及畫面上
            for (i, button) in operatorRow.enumerated() {
                button.setTitle(i == 0 ? "+" : "-", for: .normal)
                button.setTitleColor(i == 0 ? .systemBlue : .gray, for: .normal)
                button.backgroundColor = i == 0 ? self.timeLabelBackgroundColor : .white
                button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                button.tag = operatorButtons.count
                button.addTarget(self, action: #selector(addOrSubstract(_:)), for: .touchUpInside)
                operatorButtons.append(button)
                self.view.addSubview(button)
            }
            operators.append(true)
        }
        
        // 增加時間欄位列
        let lastRowY = self.timeRows.count == 0 ? 80 : self.timeRows[self.timeRows.count - 1][2].frame.origin.y + 75
        let row: [UILabel] = [UILabel(), UILabel(), UILabel()]
        row[0].frame = CGRect(x: 42, y: lastRowY, width: 54, height: 34)
        row[1].frame = CGRect(x: 135, y: lastRowY, width: 54, height: 34)
        row[2].frame = CGRect(x: 232, y: lastRowY, width: 54, height: 34)
        
        // 加進 timeRows 陣列以及畫面上
        for (i, label) in row.enumerated() {
            label.text = "00"
            label.font = .systemFont(ofSize: 20)
            label.layer.borderWidth = 1
            label.layer.borderColor = timeLabelBorderColor
            label.textAlignment = .center
            label.tag = self.timeRows.count * 3 + i
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(focus(_:))))
            label.isUserInteractionEnabled = true
            self.view.addSubview(label)
        }
        self.timeRows.append(row)
        
        // 增加減列按鈕
        if timeRows.count > 1 {
            let removeButton = UIButton(type: .system)
            removeButton.setTitle("減列", for: .normal)
            removeButton.setTitleColor(.systemBlue, for: .normal)
            removeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            removeButton.frame = CGRect(x: 321, y: removeRowButtons.count == 0 ? 155 : self.removeRowButtons[self.removeRowButtons.count - 1].frame.origin.y + 75, width: 41, height: 36)
            removeButton.tag = self.removeRowButtons.count
            removeButton.addTarget(self, action: #selector(removeRow(_:)), for: .touchUpInside)
            self.view.addSubview(removeButton)
            self.removeRowButtons.append(removeButton)
        }

        // 調整結果列
        adjustSeparatorAndResultLabels(isAppend: true)
                
        refeshRemoveButtons()
    }
    
    @objc func removeRow(_ sender: UIButton) {
        let n = sender.tag
        
        // 判斷欲刪之列是不是最後一列，如果不是，就要把刪除之列後面的列往上移
        var shouldMoveUpRemainingRows = false
        if n + 1 < self.timeRows.count - 1 {
            shouldMoveUpRemainingRows = true
        }
        
        // 刪除時間欄位
        for (_, label) in self.timeRows[n + 1].enumerated() {
            label.removeFromSuperview()
        }
        self.timeRows.remove(at: n + 1)
        // 重新照順序排定時間欄位的 tag
        
        // 刪除 + 和 - 按鈕
        self.operatorButtons[n * 2 + 1].removeFromSuperview()
        self.operatorButtons[n * 2].removeFromSuperview()
        self.operatorButtons.remove(at: n * 2 + 1)
        self.operatorButtons.remove(at: n * 2)
        // 重新照順序排定每列所選運算元按鈕的 tag
        for (i, operatorButton) in self.operatorButtons.enumerated() {
            operatorButton.tag = i
        }
        self.operators.remove(at: n)
        
        // 刪除減列按鈕
        self.removeRowButtons[n].removeFromSuperview()
        self.removeRowButtons.remove(at: n)
        // 重新照順序排定減列按鈕的 tag
        for (i, removeRowButton) in self.removeRowButtons.enumerated() {
            removeRowButton.tag = i
        }

        //若刪的是中間的列，則下面的列要往上移
//        print("operatorButtons.count: \(operatorButtons.count), operators.count: \(operators.count), removeRowButtons.count: \(removeRowButtons.count), timeRows.count: \(timeRows.count)")
        if shouldMoveUpRemainingRows {
            for i in n + 1...self.timeRows.count - 1 {
                self.operatorButtons[(i - 1) * 2].frame.origin.y -= 75
                self.operatorButtons[(i - 1) * 2 + 1].frame.origin.y -= 75

                self.timeRows[i][0].frame.origin.y -= 75
                self.timeRows[i][1].frame.origin.y -= 75
                self.timeRows[i][2].frame.origin.y -= 75
                self.timeRows[i][0].tag = timeRows[i - 1][0].tag + 3
                self.timeRows[i][1].tag = timeRows[i - 1][1].tag + 3
                self.timeRows[i][2].tag = timeRows[i - 1][2].tag + 3

                self.removeRowButtons[i - 1].frame.origin.y -= 75
            }
        }

        // 調整結果列
        adjustSeparatorAndResultLabels(isAppend: false)
        
        refeshRemoveButtons()
        
        // 檢查 focusedLabel 是否在要被移除的列中，如果是就把 focusedLabel 往上移一列
        for i in (n + 1) * 3...(n + 1) * 3 + 2 {
            if i == focusedLabel?.tag {
                if n == timeRows.count - 1 { // 是最後一列
                    focusedLabel = timeRows[n][i % 3]
                    focusedLabel?.backgroundColor = timeLabelBackgroundColor
                    break
                }
                else {
                    focusedLabel = timeRows[n + 1][i % 3]
                    focusedLabel?.backgroundColor = timeLabelBackgroundColor
                    break
                }
            }
        }
    }
    
    func refeshRemoveButtons() {
        if removeRowButtons.count <= 1 {
            for (i, _) in removeRowButtons.enumerated() {
                removeRowButtons[i].isHidden = true
            }
        }
        else {
            for (i, _) in removeRowButtons.enumerated() {
                removeRowButtons[i].isHidden = false
            }
        }
    }
        
    
    @objc func addOrSubstract(_ sender: UIButton) {
        if sender.titleLabel?.text == "+" {
            self.operatorButtons[sender.tag].setTitleColor(.systemBlue, for: .normal)
            self.operatorButtons[sender.tag].backgroundColor = self.timeLabelBackgroundColor
            self.operatorButtons[sender.tag + 1].setTitleColor(.gray, for: .normal)
            self.operatorButtons[sender.tag + 1].backgroundColor = .white
            self.operators[sender.tag / 2] = true
        }
        else {
            self.operatorButtons[sender.tag - 1].setTitleColor(.gray, for: .normal)
            self.operatorButtons[sender.tag - 1].backgroundColor = .white
            self.operatorButtons[sender.tag].setTitleColor(.systemBlue, for: .normal)
            self.operatorButtons[sender.tag].backgroundColor = self.timeLabelBackgroundColor
            self.operators[sender.tag / 2] = false
        }
    }
    
    @IBAction func focus(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else {
            return
        }
        
        for i in self.timeRows {
            for j in i {
                if j.tag == label.tag {
                    self.focusedLabel?.backgroundColor = .white
                    label.backgroundColor = timeLabelBackgroundColor
                    self.focusedLabel = label
                }
            }
        }
        
        validate(number: focusedLabel!.text!)
    }
    
    func adjustSeparatorAndResultLabels(isAppend: Bool) {
        if timeRows.count >= 2 {
            if isAppend {
                self.separator.frame.origin.y += 75
                self.hrResult.frame.origin.y = self.separator.frame.origin.y + 46
                self.minResult.frame.origin.y = self.separator.frame.origin.y + 46
                self.secResult.frame.origin.y = self.separator.frame.origin.y + 46
            }
            else {
                self.separator.frame.origin.y -= 75
                self.hrResult.frame.origin.y = self.separator.frame.origin.y + 46
                self.minResult.frame.origin.y = self.separator.frame.origin.y + 46
                self.secResult.frame.origin.y = self.separator.frame.origin.y + 46
            }
        }
        
        // 調整計算與加列按鈕位置
        addRowButton.frame.origin.y = separator.frame.origin.y
        calculateButton.frame.origin.y = separator.frame.origin.y + 46
    }
    
//    @IBAction func clear(_ sender: UIButton) {
//        for i in timeRows {
//            for j in i {
//                j.text = "00"
//                j.layer.borderColor = timeLabelBorderColor
//            }
//        }
//    }
    
    func validate(number: String) {
        // isUserInteractionEnabled 的行為跟想像中剛好顛倒，待研究
        currentGame.oneNode?.isUserInteractionEnabled = number.count < 3 ? false : true
        currentGame.twoNode?.isUserInteractionEnabled = number.count < 3 ? false : true
        currentGame.threeNode?.isUserInteractionEnabled = number.count < 3 ? false : true
        currentGame.fourNode?.isUserInteractionEnabled = number.count < 3 ? false : true
        currentGame.fiveNode?.isUserInteractionEnabled = number.count < 3 ? false : true
        currentGame.sixNode?.isUserInteractionEnabled = number.count < 3 ? false : true
        currentGame.sevenNode?.isUserInteractionEnabled = number.count < 3 ? false : true
        currentGame.eightNode?.isUserInteractionEnabled = number.count < 3 ? false : true
        currentGame.nineNode?.isUserInteractionEnabled = number.count < 3 ? false : true
        currentGame.zeroNode?.isUserInteractionEnabled = number.count < 3 ? false : true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func timeFieldFocused(_ sender: UITextField) {
        print("Focus on \(sender)")
        sender.text! = ""
//        self.focused = sender
    }
    
}
