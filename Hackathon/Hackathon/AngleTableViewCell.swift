//
//  AngleTableViewCell.swift
//  Hackathon
//
//  Created by Kan Chen on 4/14/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit

class AngleTableViewCell: UITableViewCell {

    @IBOutlet weak var CompanyImage: AsyncImageView!
    
    @IBOutlet weak var Companytitle: UILabel!
    
    @IBOutlet weak var Jobtitle: UILabel!
    
    var logourl: NSURL? {
        didSet{
            CompanyImage.url = logourl
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
