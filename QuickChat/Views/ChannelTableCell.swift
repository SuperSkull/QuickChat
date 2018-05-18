//
//  ChannelTableCell.swift
//  QuickChat
//
//  Created by thanhbh on 5/18/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

class ChannelTableCell: UITableViewCell {

    @IBOutlet weak var txtChannel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if selected {
            layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2475385274)
        } else {
            layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel) {
        txtChannel.text = "#\(channel.name)"
    }
}
