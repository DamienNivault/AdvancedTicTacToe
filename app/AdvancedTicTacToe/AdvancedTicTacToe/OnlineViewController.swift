//
//  OnlineViewController.swift
//  AdvancedTicTacToe
//
//  Created by Damien Nivault on 30/11/2018.
//  Copyright © 2018 nivault&spault. All rights reserved.
//

import Foundation
import UIKit

class OnlineViewController: UIViewController, UITextFieldDelegate{
    
    var validationLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
        
        
        validationLabel.numberOfLines = 2
        validationLabel.textAlignment = .center
        validationLabel.font.withSize(12)
        validationLabel.textColor = UIColor(red: 51.0/255, green: 153.0/255, blue: 255.0/255, alpha: 0.9)
        self.view.addSubviewGrid(validationLabel, grid: [1, 2, 10, 0.75])
        
        
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        // MARK: - Helper Methods
        }
    override func viewDidAppear(_ animated: Bool) {
        let username = UserDefaults.standard.string(forKey: "username")
        validationLabel.text = username
    }
}
