//
//  LoanBaseViewController.swift
//  SettingsTask
//
//  Created by Romana on 29/11/22.
//

import UIKit

class LoanBaseViewController: UIViewController {

    var toolbar = LoanToolbar()
    
    func setToolbar(title: String, topBarHt: CGFloat = 90){
        
        view.backgroundColor = .white
       
        toolbar = LoanToolbar(frame: CGRect(x: 0,y: 0,width: self.view.frame.width, height: topBarHt))
        toolbar.title = title
        toolbar.backBtn.addTarget(self, action: #selector(self.backPress), for: .touchUpInside)
       
        self.view.addSubview(toolbar)
    }
    
    @objc func backPress(){
    }

}
