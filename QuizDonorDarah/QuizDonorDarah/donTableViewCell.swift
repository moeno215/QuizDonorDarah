//
//  donTableViewCell.swift
//  QuizDonorDarah
//
//  Created by Maulana Hasbi on 11/8/17.
//  Copyright © 2017 SMK IDN. All rights reserved.
//

import UIKit

class donTableViewCell: UITableViewCell {

    @IBOutlet weak var instansi: UILabel!
    @IBOutlet weak var donor: UILabel!
    @IBOutlet weak var jam: UILabel!
    @IBOutlet weak var alamat: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
