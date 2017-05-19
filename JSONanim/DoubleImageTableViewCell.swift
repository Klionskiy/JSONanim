//
//  DoubleImageTableViewCell.swift
//  jsonCorrectTest
//
//  Created by Gosha K on 11.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import UIKit
import Nuke

class DoubleImageTableViewCell: UITableViewCell
{

    @IBOutlet weak var firstDoubleImage: UIImageView!
    @IBOutlet weak var secondDoubleImage: UIImageView!
    
    var pairPromo = (PairPromo(), PairPromo())
    {
        didSet
        {
            updateUI()
        }
    }
    
    func updateUI()
    {
        firstDoubleImage.image = #imageLiteral(resourceName: "Picture-50")
        secondDoubleImage.image = #imageLiteral(resourceName: "Picture-50")
        if let url = URL(string: pairPromo.0.image)
        {
            print(url)
            Nuke.loadImage(with: url, into: firstDoubleImage)
        }
        if let url = URL(string: pairPromo.1.image)
        {
            print(url)
            Nuke.loadImage(with: url, into: secondDoubleImage)
        }
    }

}
