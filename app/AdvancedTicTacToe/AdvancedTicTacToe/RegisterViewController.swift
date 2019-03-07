//
//  ViewController.swift
//  AdvancedTicTacToe
//
//  Created by Damien Nivault on 20/11/2018.
//  Copyright © 2018 nivault&spault. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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

class RegisterViewController: UIViewController, UITextFieldDelegate{
   
    var validationLabel = UILabel()
    var username = UITextField()
    var labelEmail = UITextField()
    var labelPassword = UITextField()
    var labelVerifPassword = UITextField()
    
    @objc func loginForm() {
        print("in login func")
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json",
            ]
        
        let parameters = [
            "login": labelEmail.text!,
            "password": labelPassword.text!
        ]
        Alamofire.request("https://tictactoe.spau.lt/users/authenticate", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
            
            let json = JSON(response.result.value!)
            let token = json["token"].stringValue
            let username = json["username"].stringValue
            let victories = json["victories"].intValue
            let losses = json["losses"].intValue
            let draws = json["draws"].intValue
            let defaults = UserDefaults.standard
            defaults.set(token, forKey: "token")
            defaults.set(victories, forKey: "victories")
            defaults.set(losses, forKey: "losses")
            defaults.set(draws, forKey: "draws")
            defaults.set(username, forKey: "username")
            defaults.set(draws, forKey: "draws")
            self.present( UIStoryboard(name: "OnlineStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MainOnlineStoryBoard") as UIViewController, animated: true, completion: nil)
        }
    }
    @objc func submitForm() {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json",
        ]
        
        let parameters = [
            "username": username.text!,
            "email": labelEmail.text!,
            "password": labelPassword.text!,
            "passwordConfirm": labelVerifPassword.text!
        ]
        Alamofire.request("https://tictactoe.spau.lt/users/register", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
            self.loginForm()
            print("Response JSON: \(response.result.value ?? "error")")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
        
       
        validationLabel.text = "Validation label"
        validationLabel.numberOfLines = 2
        validationLabel.textAlignment = .center
        validationLabel.font.withSize(12)
        validationLabel.textColor = UIColor(red: 51.0/255, green: 153.0/255, blue: 255.0/255, alpha: 0.9)
        self.view.addSubviewGrid(validationLabel, grid: [1, 2, 10, 0.75])
        
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
        self.view.addSubviewGrid(button, grid: [1, 8,10,1])
        
        button.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        
       
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    
    }
    func setupView() {
        // Configure Password Validation Label
        validationLabel.isHidden = true
    }
    func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }
        
        if textField == labelPassword {
            return (text.count >= 6, "Your password is too short.")
        } else if(labelPassword != labelVerifPassword) {
            return (text.count >= 6, "Your password is too short.")
        }
        
        return (text.count > 0, "This field cannot be empty.")
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("in function")
        switch textField {
        case username:
            print("textfield", textField)
            labelEmail.becomeFirstResponder()
        case labelEmail:
            labelPassword.becomeFirstResponder()
        case labelPassword:
            let (valid, message) = validate(textField)
            
            if valid {
                labelVerifPassword.becomeFirstResponder()
            }
            
            // Update Password Validation Label
            self.validationLabel.text = message
            
            // Show/Hide Password Validation Label
            UIView.animate(withDuration: 0.25, animations: {
                self.validationLabel.isHidden = valid
            })
        default:
            labelVerifPassword.resignFirstResponder()
        }
        
        return true
    }
}


extension UIView {
    
    func addSubviewGrid(_ view: UIView, grid: [CGFloat]) {
        view.frame = CGRect(x: self.frame.width/12*CGFloat(grid[0]), y: self.frame.height/12*CGFloat(grid[1]), width: self.frame.width/12*CGFloat(grid[2]), height: self.frame.height/12*CGFloat(grid[3]))
        self.addSubview(view)
    }
}


