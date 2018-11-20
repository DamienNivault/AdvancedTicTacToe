//
//  ViewController.swift
//  AdvancedTicTacToe
//
//  Created by Damien Nivault on 20/11/2018.
//  Copyright © 2018 nivault&spault. All rights reserved.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController, UITextFieldDelegate{


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
        
        let username = UITextField()
        username.placeholder = "Username"
        username.backgroundColor = UIColor.white
        username.layer.cornerRadius = 5
        username.alpha = 0.7;
        username.setLeftPaddingPoints(15)
        username.keyboardAppearance = UIKeyboardAppearance.dark;
        username.returnKeyType = UIReturnKeyType.continue
        username.delegate = self
        username.tag = 1
        self.view.addSubviewGrid(username, grid: [1, 3, 10, 0.75])
        
        let labelEmail = UITextField()
        labelEmail.placeholder = "Email"
        labelEmail.backgroundColor = UIColor.white
        labelEmail.layer.cornerRadius = 5
        labelEmail.alpha = 0.7;
        labelEmail.setLeftPaddingPoints(15)
        labelEmail.keyboardAppearance = UIKeyboardAppearance.dark;
        labelEmail.keyboardType = UIKeyboardType.emailAddress
        labelEmail.returnKeyType = UIReturnKeyType.continue
        labelEmail.delegate = self
        labelEmail.tag = 2
        self.view.addSubviewGrid(labelEmail, grid: [1, 4, 10, 0.75])
        
        let labelPassword = UITextField()
        
        labelPassword.placeholder = "Password"
        labelPassword.backgroundColor = UIColor.white
        labelPassword.layer.cornerRadius = 5
        labelPassword.alpha = 0.7;
        labelPassword.isSecureTextEntry = true
        labelPassword.setLeftPaddingPoints(15)
        labelPassword.keyboardAppearance = UIKeyboardAppearance.dark;
        labelPassword.returnKeyType = UIReturnKeyType.continue
        labelPassword.delegate = self
        labelPassword.tag = 3
        self.view.addSubviewGrid(labelPassword, grid: [1, 5, 10, 0.75])
     
        let labelVerifPassword = UITextField()
        labelVerifPassword.placeholder = "Password Verification"
        labelVerifPassword.backgroundColor = UIColor.white
        labelVerifPassword.layer.cornerRadius = 5
        labelVerifPassword.alpha = 0.9;
        labelVerifPassword.isSecureTextEntry = true
        labelVerifPassword.setLeftPaddingPoints(15)
        labelVerifPassword.keyboardAppearance = UIKeyboardAppearance.dark;
        labelVerifPassword.returnKeyType = UIReturnKeyType.join
        labelVerifPassword.delegate = self
        labelVerifPassword.tag = 4
        self.view.addSubviewGrid(labelVerifPassword, grid: [1, 6, 10, 0.75])
        let button = UIButton()
        button.backgroundColor = UIColor(red: 51.0/255, green: 153.0/255, blue: 255.0/255, alpha: 0.9)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubviewGrid(button, grid: [1,10,10,1])
        
       
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    
    }

}


extension UIView {
    
    func addSubviewGrid(_ view: UIView, grid: [CGFloat]) {
        view.frame = CGRect(x: self.frame.width/12*CGFloat(grid[0]), y: self.frame.height/12*CGFloat(grid[1]), width: self.frame.width/12*CGFloat(grid[2]), height: self.frame.height/12*CGFloat(grid[3]))
        self.addSubview(view)
    }
}
