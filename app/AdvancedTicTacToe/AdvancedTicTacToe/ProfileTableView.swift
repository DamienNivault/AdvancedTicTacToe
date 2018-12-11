//
//  ProfileTableView.swift
//  AdvancedTicTacToe
//
//  Created by Damien Nivault on 11/12/2018.
//  Copyright © 2018 nivault&spault. All rights reserved.
//

import Foundation
import UIKit
class ProfileTableView: UITableViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count", profile.count)
        return profile.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "score")
        print("cell", profile[indexPath.row])
        cell.detailTextLabel?.text = profile[indexPath.row]
        cell.textLabel?.text = "Victories"
        return cell
    }
    
    var validationLabel = UILabel()
    
    let profile = [
        UserDefaults.standard.string(forKey: "victories"),
        UserDefaults.standard.string(forKey: "losses"),
        UserDefaults.standard.string(forKey: "draws")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
