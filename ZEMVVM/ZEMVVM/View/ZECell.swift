//
//  ZECell.swift
//  ZEMVVM
//
//  Created by 胡春源 on 16/5/20.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class ZECell: UITableViewCell {

    @IBOutlet weak var labelButtomConstaranits: NSLayoutConstraint!
    @IBOutlet weak var bigTitleLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let randomNumber = Int.random(0, 1)
        if randomNumber == 0 {
            labelButtomConstaranits.constant = 100
            self.layoutIfNeeded()
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// 随机数...
public extension Int {
    /// SwiftRandom extension
    public static func random(range: Range<Int>) -> Int {
        return random(range.endIndex, range.startIndex)
    }
    
    /// SwiftRandom extension
    public static func random(lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}
