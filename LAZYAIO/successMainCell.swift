//
//  successMainCell.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-10-29.
//

import UIKit

class successMainCell: UITableViewCell {

    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSize: UILabel!
    @IBOutlet weak var profileName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
