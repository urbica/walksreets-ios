//
//  AppDelegate.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {        
        // Setting up Fabric
        Fabric.with([Crashlytics.self])
        
        setupWindow()
        OnStartHelper.showStartScreenIfNeeded()
        
        return true
    }
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.makeKeyAndVisible()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


// Mark: - 3D Touch
extension AppDelegate {
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        // TODO: uncomment after onboarding is done
        
        //guard UserDefaults.standard.boolForKey(Config.onboardingWasShownKey) == true else {
        //    return
        //}
        
        
        switch shortcutItem.type {
        case "com.walkstreets-ios.app.Walkstreets.getBack":
            presentRouteCreation()
        case "com.walkstreets-ios.app.Walkstreets.showAddress":
            presentAddress()
        default:
            return
        }
    }
    
    func presentRouteCreation() {
        let identifier = "routeCreationNavID"
        let vc = UIStoryboard.mainInterfaceStoryboard.instantiateViewController(withIdentifier: identifier) as! UINavigationController
        
        window?.rootViewController?.present(vc, animated: true, completion: {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: RouteCreationModuleConstants.walkMe), object: nil)
        })
    }
    
    func presentAddress() {
     
        let identifier = "addressSearchID"

        let navController = UIStoryboard.addressStoryboard.instantiateViewController(withIdentifier: identifier) as! UINavigationController
        window?.rootViewController?.present(navController, animated: false, completion: {
        })
    }
    
}

