//
//  LanguageViewController.swift
//  SettingsTask
//
//  Created by Romana on 8/11/22.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func set(_ sender: Any) {
    }
    
    @IBOutlet weak var languageTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageTable.layer.cornerRadius = 20.0

    }

  
}
