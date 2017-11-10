//
//  GuruTableViewCell.swift
//  Data_Guru_IDN
//
//  Created by Jun  on 11/10/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class GuruTableViewCell: UITableViewCell {

    @IBOutlet weak var namaadesc: UILabel!
    @IBOutlet weak var nisdesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
