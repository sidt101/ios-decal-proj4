//
//  EventTableViewCell.swift
//  Sappenin
//
//  Created by Siddhant K Tandon on 4/22/16.
//  Copyright © 2016 Siddhant K Tandon. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {


    
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var distanceFromCurrentLocationLabel: UILabel!
    @IBOutlet weak var eventThumbnailImage: UIImageView!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
