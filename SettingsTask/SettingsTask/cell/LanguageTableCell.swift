//
//  LanguageTableCell.swift
//  SettingsTask
//
//  Created by Romana on 8/11/22.
//

import UIKit

class LanguageTableCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var languageIcon: UIImageView!
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var selectIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            bgView.backgroundColor = UIColor(red: 0.87, green: 0.90, blue: 1.00, alpha: 1.00)
            selectIcon.image = UIImage(named: "check_on")
            languageName.textColor = UIColor(red: 0.09, green: 0.23, blue: 0.87, alpha: 1.00)
        }else{
            bgView.backgroundColor = UIColor.white
            selectIcon.image = UIImage(named: "check_off")
            languageName.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
        }
    }
    
}
