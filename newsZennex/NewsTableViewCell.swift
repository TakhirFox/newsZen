//
//  NewsTableViewCell.swift
//  newsZennex
//
//  Created by Zakirov Tahir on 13.09.2020.
//  Copyright © 2020 Zakirov Takhir. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var postDescription: UILabel!
    @IBOutlet var postDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
