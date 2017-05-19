//
//  RealmImageTableViewController.swift
//  jsonCorrectTest
//
//  Created by Gosha K on 11.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class RealmImageTableViewController: UITableViewController, UIGestureRecognizerDelegate
{
    var storedData : AllStoredData?
    var longPress : UILongPressGestureRecognizer?
    
    let realm = try! Realm()
    
    var animate = SharingManager.animate
    var touch = SharingManager.touch
    
    //Gravity usage
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        animate = SharingManager.animate
        touch = SharingManager.touch
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        storedData = AllStoredData()
        
        setLongPress()
        makeBluringBackground()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case 0:
            return 1
        case 1:
            return storedData!.singlePromo.count
        case 2:
            return storedData!.pairPromos.count
        case 3:
            return storedData!.contentPromo.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as? HeaderImageTableViewCell
            {
                performScaling(cell: cell)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "single", for: indexPath) as? SinglePromoTableViewCell
            {
                cell.singlePromo = (storedData?.singlePromo[indexPath.row])!
                appearWithAnimation(tableCell: cell, collectionCell: nil)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "double", for: indexPath) as? DoubleImageTableViewCell
            {
                cell.pairPromo = (storedData?.pairPromos[indexPath.row])!
                appearWithAnimation(tableCell: cell, collectionCell: nil)
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as? ContentPromoTableViewCell
            {
                cell.contentPromo = (storedData?.contentPromo[indexPath.row])!
                appearWithAnimation(tableCell: cell, collectionCell: nil)
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section > 0
        {
            print(indexPath)
            switch touch {
            case 0:
                UIView.animate(withDuration: 0.3, animations: {
                    tableView.cellForRow(at: indexPath)?.backgroundColor = self.getRandomColor()
                })
            case 1:
                bounceOnSelected(cell: tableView.cellForRow(at: indexPath)!)
            case 2:
                tableView.reloadRows(at: [indexPath], with: .fade)
            default:
                tableView.reloadRows(at: [indexPath], with: .bottom)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if animate == 7
        {
            animator = UIDynamicAnimator(referenceView: view)
            gravity = UIGravityBehavior(items: [cell])
            animator.addBehavior(gravity)
        }
    }
    
    // MARK: - Delete from realm and tableView
    
    func deleteRowFromRealm(object: Object)
    {
        try! realm.write
        {
            realm.delete(object)
        }
        storedData = AllStoredData()
        tableView.reloadData()
    }
    
    // MARK: - Handle long press
    
    func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer)
    {
        if (gestureRecognizer.state != UIGestureRecognizerState.ended)
        {
            return
        }
        let location = gestureRecognizer.location(in: self.tableView)
        if let indexPath: IndexPath = self.tableView.indexPathForRow(at: location)
        {
            switch indexPath.section {
            case 0:
                print(indexPath)
                return
            case 1:
                print(indexPath)
                deleteRowFromRealm(object: (storedData?.singlePromo[indexPath.row])!)
            case 2:
                print(indexPath)
                try! realm.write
                {
                    realm.delete((storedData?.pairPromos[indexPath.row].0)!)
                }
                deleteRowFromRealm(object: (storedData?.pairPromos[indexPath.row].1)!)
            case 3:
                print(indexPath)
                deleteRowFromRealm(object: (storedData?.contentPromo[indexPath.row])!)
            default:
                return
            }
        }
    }
    
    func setLongPress()
    {
        longPress?.delegate = self
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(RealmImageTableViewController.handleLongPress(gestureRecognizer:)))
        longPress?.delaysTouchesBegan = true
        tableView.addGestureRecognizer(longPress!)
    }
    
    // MARK: - Refresh
    
    @IBAction func refreshFromJSON(_ sender: UIBarButtonItem)
    {
        SaveDataToRealm.sharedInstance.saveObjects()
        storedData = AllStoredData()
        tableView.reloadData()
    }
    
    // MARK: - Animation functions
    
    func appearWithAnimation(tableCell: UITableViewCell?, collectionCell: UICollectionViewCell?)
    {
        if let tableCell = tableCell
        {
            switch animate
            {
            case 0:
                performScaling(cell: tableCell)
            case 1:
                performBubbleEffect(cell: tableCell)
            case 2:
                performRotation(cell: tableCell)
            case 3:
                performSpringAnimationX(cell: tableCell)
            case 4:
                performSpringAnimationBoth(cell: tableCell)
            case 5:
                performTransformIdentityWithAlpha(cell: tableCell)
            case 6:
                performIntagramAnimation(cell: tableCell)
            case 8:
                performFlyingInWithShadeAndAlpha(cell: tableCell)
            default:
                break
            }
        }
        if let collectionCell = collectionCell
        {
            switch animate
            {
            case 0:
                performScaling(cell: collectionCell)
            case 1:
                performBubbleEffect(cell: collectionCell)
            case 2:
                performRotation(cell: collectionCell)
            case 3:
                performSpringAnimationX(cell: collectionCell)
            case 4:
                performScaling(cell: collectionCell)
            case 5:
                performTransformIdentityWithAlpha(cell: collectionCell)
            case 6:
                performIntagramAnimation(cell: collectionCell)
            case 8:
                performFlyingInWithShadeAndAlpha(cell: collectionCell)
            default:
                break
            }
        }
    }
    
    func performScaling(cell: UIView)
    {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        
        UIView.animate(withDuration: 0.5, animations:
            {
                cell.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1)
        },completion: { finished in
            UIView.animate(withDuration: 0.2, animations:
                {
                    cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        })
    }
    
    func performBubbleEffect(cell: UIView)
    {
        UIView.animate(withDuration: 0.5, animations:
            {
                cell.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1)
        },completion: { _ in
            UIView.animate(withDuration: 0.2, animations:
                {
                    cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        })
    }
    
    func performRotation(cell: UIView)
    {
        var transform = cell.layer.transform
        transform.m34 = 1.0 / -50
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.values = [CATransform3DRotate(transform, 0 * .pi, 0, 0, 1),
                            CATransform3DRotate(transform, 1 * .pi, 0, 0, 1),
                            CATransform3DRotate(transform, 2 * .pi, 0, 0, 1)]
        animation.duration = 1
        cell.layer.add(animation, forKey: animation.keyPath!)
    }
    
    func performSpringAnimationX(cell: UIView)
    {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations:
            {
                cell.center = CGPoint(x: cell.center.x + 75, y: cell.center.y)
        })
    }
    
    func performSpringAnimationBoth(cell: UIView)
    {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.curveEaseIn, animations:
            {
                cell.center = CGPoint(x: cell.center.x + 75, y: cell.center.y + 75)
        })
    }
    
    func performTransformIdentityWithAlpha(cell: UIView)
    {
        cell.alpha = 0
        cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        
        UIView.animate(withDuration: 0.8, animations:
            {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
        })
    }
    
    func performIntagramAnimation(cell: UIView)
    {
        var transfrom = CATransform3DMakeRotation(CGFloat(Double.pi/2), 0.0, 1.0, 0.0)
        transfrom.m34 = 1 / -200
        cell.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
        
        UIView.animate(withDuration: 1, animations:
            {
                cell.layer.transform = transfrom
            },
            completion: { _ in
                UIView.animate(withDuration: 1, animations:
                    {
                        cell.layer.transform = CATransform3DIdentity
            })
        })
    }
    
    func performFlyingInWithShadeAndAlpha(cell: UIView)
    {
        var rotation = CATransform3DMakeRotation(CGFloat(Double.pi/2), 0.0, 0.7, 0.4)
        rotation.m34 = 1.0 / -650
        cell.alpha = 0
        cell.layer.transform = rotation
        cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        UIView.animate(withDuration: 0.8, animations:
            {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1
        })
        
    }
    
    func turnGravityOn(cell: UIView)
    {
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [cell])
        animator.addBehavior(gravity)
    }
    
    func bounceOnSelected(cell: UIView)
    {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations:
            {
                cell.layer.transform = CATransform3DMakeScale(0.95, 0.95, 1.0)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, options: .curveEaseOut, animations:
                    {
                        cell.layer.transform = CATransform3DIdentity
            })
        })
        
    }
    
    //MARK: -  Generate random color
    
    func getRandomColor() -> UIColor
    {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    //MARK - Bluring gray background
    
    func makeBluringBackground()
    {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        tableView.backgroundView = blurView
        tableView.separatorEffect = UIVibrancyEffect(blurEffect: blurView.effect as! UIBlurEffect)
    }
    
}

extension RealmImageTableViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return storedData!.headers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "header", for: indexPath) as? HeaderCollectionViewCell
        {
            cell.header = (storedData?.headers[indexPath.row])!
            appearWithAnimation(tableCell: nil, collectionCell: cell)
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        switch touch
        {
        case 0:
            UIView.animate(withDuration: 0.3, animations: {
                (collectionView.cellForItem(at: indexPath) as? HeaderCollectionViewCell)?.backgroundColor = self.getRandomColor()
            })
        default:
            bounceOnSelected(cell: collectionView.cellForItem(at: indexPath)!)
        }
    }
    
}

