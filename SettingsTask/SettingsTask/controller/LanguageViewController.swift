//
//  LanguageViewController.swift
//  SettingsTask
//
//  Created by Romana on 8/11/22.
//

import UIKit

class LanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func set(_ sender: Any) {
    }
    
    @IBOutlet weak var languageTable: UITableView!
    
    var cellID = "LanguageTableCell"
    
    var languageArray = [LanguageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languageArray.append(LanguageModel(icon: "us_flag", title: "English", isSelected: false))
        languageArray.append(LanguageModel(icon: "us_flag", title: "English", isSelected: false))
        languageArray.append(LanguageModel(icon: "us_flag", title: "English", isSelected: false))
        languageArray.append(LanguageModel(icon: "us_flag", title: "English", isSelected: false))
        languageArray.append(LanguageModel(icon: "us_flag", title: "English", isSelected: false))
        languageArray.append(LanguageModel(icon: "us_flag", title: "English", isSelected: false))
        
        self.languageTable.delegate = self
        self.languageTable.dataSource = self
        
        self.languageTable.register(UINib(nibName: "LanguageTableCell", bundle: nil), forCellReuseIdentifier: cellID)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LanguageTableCell
        
        let object = languageArray[indexPath.row]
        cell.languageIcon.image = UIImage(named: object.icon)
        cell.languageName.text = object.title
        cell.isSelected = object.isSelected
        
        return cell
    }
    
    
}
