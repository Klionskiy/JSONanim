//
//  AnimationChooserTableViewController.swift
//  JSONcorrect
//
//  Created by Gosha K on 16.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import UIKit

class AnimationChooserTableViewController: UITableViewController
{
    var animations = ["Scaling", "Scaling(Bubbles)", "Rotation", "Spring Animation X", "Spring Animation X/Y", "Move In With Alpha", "Instagram Stories Animation", "Gravity Animation", "Fly In With Alpha"]

    var touchAnim = ["Coloring Cells", "Bounce", "Fade", "Slide"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case 0:
            return animations.count
        default:
            return touchAnim.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section
        {
        case 0:
            return "Appear Animations"
        default:
            return "Select Animations"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "animation", for: indexPath)
            cell.textLabel?.text = animations[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "animation", for: indexPath)
            cell.textLabel?.text = touchAnim[indexPath.row]
            return cell
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch (indexPath.section, indexPath.row)
        {
        case (0, 0):
            SharingManager.animate = 0
        case (0, 1):
            SharingManager.animate = 1
        case (0, 2):
            SharingManager.animate = 2
        case (0, 3):
            SharingManager.animate = 3
        case (0, 4):
            SharingManager.animate = 4
        case (0, 5):
            SharingManager.animate = 5
        case (0, 6):
            SharingManager.animate = 6
        case (0, 7):
            SharingManager.animate = 7
        case (0, 8):
            SharingManager.animate = 8
        case (1, 0):
            SharingManager.touch = 0
        case (1, 1):
            SharingManager.touch = 1
        case (1, 2):
            SharingManager.touch = 2
            SharingManager.animate = -1
        case (1, 3):
            SharingManager.touch = 3
            SharingManager.animate = -1
        default:
            return
        }
    }
}
