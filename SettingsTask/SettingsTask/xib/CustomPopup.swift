//
//  CustomPopup.swift
//  SettingsTask
//
//  Created by Romana on 19/11/22.
//

import UIKit

class CustomPopup: UIView {

    @IBOutlet weak var rootBg: UIView!
    
    var popupBg: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var popupIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "check_on")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var popupTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = "SUCCESS !!!!! SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS v"
        return view
    }()
    
    var popupMsg: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = "message message message message message message message message  message message message v v message "
        return view
    }()
    
    var popupBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.setTitle("login", for: .normal)
        return view
    }()
    
    
    class func instanceFromNib() -> CustomPopup {
           let view = UINib(nibName: "CustomPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomPopup
           view.setComponent()
           return view
       }
    
    func setComponent() {
        
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        
        stackView.addArrangedSubview(popupIcon)
        stackView.addArrangedSubview(popupTitle)
        stackView.addArrangedSubview(popupMsg)
//        stackView.addArrangedSubview(popupBtn)
        
        rootBg.addSubview(popupBg)
        rootBg.addSubview(stackView)
        rootBg.addSubview(popupBtn)
        
        
        
        let constraints = [
            popupIcon.heightAnchor.constraint(equalToConstant: 50),
            popupBtn.heightAnchor.constraint(equalToConstant: 40),
            popupBtn.widthAnchor.constraint(equalToConstant: 120),
            popupBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            popupBtn.centerXAnchor.constraint(equalTo: self.rootBg.centerXAnchor),
            
            
            stackView.centerYAnchor.constraint(equalTo: self.rootBg.centerYAnchor, constant: -40),
            stackView.leadingAnchor.constraint(equalTo: self.rootBg.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: self.rootBg.trailingAnchor, constant: -40),
            
            popupBg.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -15),
            popupBg.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -15),
            popupBg.bottomAnchor.constraint(equalTo: popupBtn.bottomAnchor, constant: 15),
            popupBg.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 15),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        self.rootBg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismiss(sender: ))))
        
    }
    @objc func dismiss(sender : UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
    
    override class func awakeFromNib() {
        
    }
    

}
