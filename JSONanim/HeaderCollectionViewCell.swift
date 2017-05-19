//
//  HeaderCollectionViewCell.swift
//  JSONcorrect
//
//  Created by Gosha K on 14.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import UIKit
import Nuke

class HeaderCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var headerImage: UIImageView!
    
    var header = Header()
    {
        didSet
        {
            updateUI()
        }
    }
    
    func updateUI()
    {
        headerImage.image = #imageLiteral(resourceName: "Picture-50")
        if let url = URL(string: header.image)
        {
            print(url)
            Nuke.loadImage(with: url, into: headerImage)
        }
    }
    
    
}
