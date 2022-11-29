//
//  CustomProgressBar.swift
//  SettingsTask
//
//  Created by Romana on 26/11/22.
//

import UIKit

class CustomProgressBar: UIView {

    var progressBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        return view
    }()
    

    
    var progressHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUI()
    }
    
    func setUI() {
        
        self.addSubview(progressBar)
        self.addSubview(progressHolder)
        
        
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: 20),
            progressBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            progressBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            progressHolder.heightAnchor.constraint(equalToConstant: 60),
            progressHolder.widthAnchor.constraint(equalToConstant: 60),
            progressHolder.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            progressHolder.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        progressBar.layer.cornerRadius = 20 / 2
        progressHolder.layer.cornerRadius = 60/2
        
        progressHolder.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.holderMove(sender: ))))
       
    }
    
    
    private var initialCenter: CGPoint = .zero
    
    @objc func holderMove(sender : UIPanGestureRecognizer) {
//        print("holder Click")
//        var translation = sender.translation(in: progressHolder)
//        print("translation \(translation)")
        
//        let translation = sender.translation(in: self)
//        initialCenter = progressHolder.center
//        progressHolder.center = CGPoint(x: initialCenter.x + translation.x,
//                                        y: initialCenter.y)
//        print("width  \(progressBar.bounds.maxX)")
        if sender.state == UIGestureRecognizer.State.began ||
            sender.state == UIGestureRecognizer.State.changed {
            
                let translation = sender.translation(in: self)
            print("translation  \(translation.x)")
            if ((translation.x < progressBar.bounds.maxX) &&
                (translation.x > progressBar.bounds.minX)){
                
                progressHolder.center = CGPoint(x: progressHolder.center.x + translation.x, y: progressHolder.center.y)
            }else{
//                progressHolder.center = CGPoint(x: progressHolder.center.x + translation.x, y: progressHolder.center.y)
            }
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self)
            }
        
      
    }

}
