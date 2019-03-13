//
//  ZYtestController.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/3/6.
//  Copyright © 2019 石志愿. All rights reserved.
//

import UIKit

class ZYtestController: ZYBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        title = "push"
        
        let textField = UITextField(frame: CGRect(x: 15, y: 100, width: ZYTheme.screenWidth - 30, height: 30))
        textField.backgroundColor = UIColor.gray
        textField.delegate = self
        self.view.addSubview(textField)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ZYtestController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" || string == "\n" {
            return true
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            print(text.checkNumOrLetStrForN(n: 6, to: 11))
            print(text.pinYin(), text.firstLetter())
            if text.count > 5 {
                print(text.zy_subString(rang: NSRange(location: 1, length: 3)))
            }
        }
    }
}
