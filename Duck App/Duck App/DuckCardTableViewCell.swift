//
//  DuckCardTableViewCell.swift
//  Duck App
//
//  Created by Auburn University Senior Design on 3/1/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class DuckCardTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var cellImage: UIImageView!  //Table view cell image
    @IBOutlet weak var cellLabel: UILabel!      //Table view cell label
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
