//
//  ContentPromoTableViewCell.swift
//  JSONcorrect
//
//  Created by Gosha K on 14.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import UIKit
import Nuke

class ContentPromoTableViewCell: UITableViewCell
{

    @IBOutlet weak var contentImage: UIImageView!
    
    var contentPromo = ContentPromo()
    {
        didSet
        {
            updateUI()
        }
    }
    
    func updateUI()
    {
        contentImage.image = #imageLiteral(resourceName: "Picture-50")
        if let url = URL(string: contentPromo.image)
        {
            print(url)
            Nuke.loadImage(with: url, into: contentImage)
        }
    }

}
