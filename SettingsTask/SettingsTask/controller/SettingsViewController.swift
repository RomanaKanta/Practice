//
//  SettingsViewController.swift
//  SettingsTask
//
//  Created by Romana on 7/11/22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var languageBtn: BorderView!
    
    @IBOutlet weak var changePwdBtn: BorderView!
    
    @IBOutlet weak var contactBtn: BorderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.languageBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.languageBtnClick(sender: ))))
        
        self.changePwdBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changePwdBtnClick(sender: ))))
        
        self.contactBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.contactBtnClick(sender: ))))
        
    }
    
    @objc func languageBtnClick(sender : UITapGestureRecognizer) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        present(vc , animated: true , completion: nil)
        
    }

    @objc func changePwdBtnClick(sender : UITapGestureRecognizer) {
        let actionSheetController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)

        let backView = actionSheetController.view.subviews.last?.subviews.last
           backView?.layer.cornerRadius = 10.0
           backView?.backgroundColor = UIColor.yellow
        
        
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        actionSheetController.setValue(vc, forKey: "contentViewController")
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
   
    @objc func contactBtnClick(sender : UITapGestureRecognizer) {
        
    }

}

