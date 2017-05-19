//
//  SinglePromoTableViewCell.swift
//  JSONcorrect
//
//  Created by Gosha K on 12.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import UIKit
import Nuke

class SinglePromoTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var singleImage: UIImageView!
    var singlePromo = SinglePromo()
    {
        didSet
        {
            updateUI()
        }
    }

    func updateUI()
    {
        singleImage.image = #imageLiteral(resourceName: "Picture-50")
        if let url = URL(string: singlePromo.image)
        {
            print(url)
            Nuke.loadImage(with: url, into: singleImage)
        }
    }

}
