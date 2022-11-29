//
//  StatusViewController.swift
//  SettingsTask
//
//  Created by Romana on 29/11/22.
//

import UIKit

class StatusViewController: LoanBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var statusTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    var cellID = "LoanStatusCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setToolbar(title: "Status")
        
//        setEmptyView()
        
        setTableView()
    }
    
    func setEmptyView(){
        self.view.addSubview(emptyView)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        emptyView.addSubview(stackView)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "no_status")
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = UIColor.blue
        label.text = "You haven’t take any loan yet!"
        
        let subLabel = UILabel()
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.numberOfLines = 0
        subLabel.font = UIFont.boldSystemFont(ofSize: 14)
        subLabel.textAlignment = .center
        subLabel.textColor = UIColor.gray
        subLabel.text = "Apply for a loan to see the status here"
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(subLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -15),
                
            emptyView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.toolbar.bounds.height),
            emptyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func setTableView(){
        self.view.addSubview(statusTableView)
        
        NSLayoutConstraint.activate([
            statusTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.toolbar.bounds.height + 15),
            statusTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -15),
            statusTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            statusTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
        ])
        
        self.statusTableView.delegate = self
        self.statusTableView.dataSource = self
        self.statusTableView.register(UINib(nibName: "LoanStatusCell", bundle: nil), forCellReuseIdentifier: cellID)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LoanStatusCell
        
        return cell
    }

}
