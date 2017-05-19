//
//  AppDelegate.swift
//  JSONcorrect
//
//  Created by Gosha K on 12.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        SaveDataToRealm.sharedInstance.saveObjects()
        return true
    }

}

