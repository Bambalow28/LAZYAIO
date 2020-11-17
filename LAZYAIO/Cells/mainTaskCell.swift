//
//  mainTaskCell.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-10-29.
//

import UIKit

class mainTaskCell: UITableViewCell {

    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var skuValue: UILabel!
    @IBOutlet weak var size: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
