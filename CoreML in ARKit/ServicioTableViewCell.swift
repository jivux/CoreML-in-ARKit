//
//  ServicioTableViewCell.swift
//  CoreML in ARKit
//
//  Created by Ivo Reyes Román on 10/29/17.
//  Copyright © 2017 CompanyName. All rights reserved.
//

import UIKit

class ServicioTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
