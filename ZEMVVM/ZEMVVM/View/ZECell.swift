//
//  ZECell.swift
//  ZEMVVM
//
//  Created by 胡春源 on 16/5/20.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class ZECell: UITableViewCell {

    @IBOutlet weak var bigTitleLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
