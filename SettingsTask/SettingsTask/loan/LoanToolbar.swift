//
//  LoanToolbar.swift
//  SettingsTask
//
//  Created by Romana on 29/11/22.
//

import UIKit

class LoanToolbar: UIView {

    var pageTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .center
        view.textColor = UIColor.white
        return view
    }()
  
    var backBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "ic_arrow_back"), for: .normal)
        return view
    }()
    
    var deleteBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "ic_arrow_back"), for: .normal)
        return view
    }()
  
    var title = "page title" { didSet{ updateUI() } }
    fileprivate let btnSize: CGFloat = 35
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        
        let headerBg = UIView()
        headerBg.translatesAutoresizingMaskIntoConstraints = false
        headerBg.backgroundColor = .white
        
        let bgImage = UIImageView()
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        bgImage.image = UIImage(named: "toolbar_bg")
        
        headerBg.addSubview(bgImage)
        headerBg.addSubview(pageTitle)
        headerBg.addSubview(backBtn)
        headerBg.addSubview(deleteBtn)
        
        addSubview(headerBg)
        
        let constraints = [
            
            backBtn.heightAnchor.constraint(equalToConstant: btnSize),
            backBtn.widthAnchor.constraint(equalToConstant: btnSize),
            backBtn.leadingAnchor.constraint(equalTo: headerBg.leadingAnchor, constant: 15),
            backBtn.bottomAnchor.constraint(equalTo: headerBg.bottomAnchor, constant: -5),
            
            
            deleteBtn.heightAnchor.constraint(equalToConstant: btnSize),
            deleteBtn.widthAnchor.constraint(equalToConstant: btnSize),
            deleteBtn.trailingAnchor.constraint(equalTo: headerBg.trailingAnchor, constant: -15),
            deleteBtn.bottomAnchor.constraint(equalTo: headerBg.bottomAnchor, constant: -5),
            
            pageTitle.heightAnchor.constraint(equalToConstant: btnSize),
            pageTitle.centerXAnchor.constraint(equalTo: headerBg.centerXAnchor),
            pageTitle.bottomAnchor.constraint(equalTo: headerBg.bottomAnchor, constant: -5),
            
            bgImage.topAnchor.constraint(equalTo: headerBg.topAnchor, constant: 0),
            bgImage.leadingAnchor.constraint(equalTo: headerBg.leadingAnchor, constant: 0),
            bgImage.trailingAnchor.constraint(equalTo: headerBg.trailingAnchor, constant: 0),
            bgImage.bottomAnchor.constraint(equalTo: headerBg.bottomAnchor, constant: 0),
            
            headerBg.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            headerBg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            headerBg.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            headerBg.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func updateUI() {
        
        if(!title.isEmpty){
            pageTitle.text = title
        }
        
        setNeedsDisplay()
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
}

