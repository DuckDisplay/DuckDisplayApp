//
//  LeaderboardTableViewCell.swift
//  Duck App
//
//  Created by Auburn University Senior Design on 4/2/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var leaderboardPlace: UILabel!
    @IBOutlet weak var leaderboardName: UILabel!
    @IBOutlet weak var leaderboardState: UILabel!
    @IBOutlet weak var leaderboardScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
