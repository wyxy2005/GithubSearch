//
//  AppDelegate.swift
//  GithubSearch
//
//  Created by Hiroki Nagasawa on 9/22/15.
//  Copyright © 2015 Hiroki Nagasawa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    let appContext = ApplicationContext()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if let navigation = window?.rootViewController as? UINavigationController,
            let root = navigation.topViewController as? ApplicationContextSettable {
                root.appContext = appContext
        } else {
            fatalError()
        }
        
        return true
    }

}

