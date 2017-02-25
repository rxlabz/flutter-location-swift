// Copyright 2017 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {

    var locationProvider = LocationProvider()

    override func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {

        print("yo")

        let project = FlutterDartProject(fromDefaultSourceForConfiguration: ())

        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let flutterController = FlutterViewController(project: project, nibName: nil, bundle: nil){
            flutterController.add(locationProvider)
            window.rootViewController = flutterController
            window.makeKeyAndVisible()
        }
        
        return true
    }
}
