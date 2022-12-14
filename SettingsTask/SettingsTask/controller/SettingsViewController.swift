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
        
//        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
//        alertController.view.translatesAutoresizingMaskIntoConstraints = false
//
//
//        let backView = alertController.view.subviews.first?.subviews.first?.subviews.first
//        backView?.layer.cornerRadius = 10.0
//        backView?.backgroundColor = UIColor.white
//
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
//
//        let constraints = [
//            alertController.view.heightAnchor.constraint(equalToConstant: 450),
//        ]
//        NSLayoutConstraint.activate(constraints)
//
//        alertController.setValue(vc, forKey: "contentViewController")
//
//        self.present(alertController, animated: true) {
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
//            alertController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
//        }
    }
    
    @objc func changePwdBtnClick(sender : UITapGestureRecognizer) {
        
        let vc = StatusViewController()
        
        vc.modalPresentationStyle = .pageSheet
    
//        let vc = ProgressBarViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
//        present(vc , animated: true , completion: nil)
        
    }
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    var alert: CustomPopup!
    @objc func contactBtnClick(sender : UITapGestureRecognizer) {
//        alert = CustomPopup.instanceFromNib()
        alert = CustomPopup()
        alert.frame = self.view.bounds
        self.view.addSubview(alert)
        alert.popupBtn.addTarget(self, action:  #selector(removeAlert), for: .touchUpInside)
    }
    
    @objc func removeAlert(){
        alert.removeFromSuperview()
    }
    
}

