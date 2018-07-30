//
//  AppDelegate.swift
//  scicharttest
//
//  Created by Arkady Smirnov on 7/29/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import UIKit
import SciChart

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let licencing:String = """
            <LicenseContract>
                <Customer>arkadysmirnov@outlook.com</Customer>
                <OrderId>Trial</OrderId>
                <LicenseCount>1</LicenseCount>
                <IsTrialLicense>true</IsTrialLicense>
                <SupportExpires>08/29/2018 00:00:00</SupportExpires>
                <ProductCode>SC-IOS-2D-ENTERPRISE-SRC</ProductCode>
                <KeyCode>c9152fe1f2e6a4815de1d851848fc27c6cf76eb8c67eeb2ab5a967041d58922cffd8e166a9d66448136d6fef79d15c6dd4838d5cbe27e1ce62b14de40e570129166da2c551d9a07c39fefa075a2d5ed782c8525b5a2b7b333489dda8d45e481115686f69a6bad4e688a6b70aa729fc0940593ab83e73a1e5bbfb57eba19fd88b4924e2a38a034f76659f109c1246d3c08ade0d99a15cfe2a7e813adac9a3db65fb4870fc1c8f4fca54d48af647b7ec</KeyCode>
            </LicenseContract>
            """
        
        SCIChartSurface.setRuntimeLicenseKey(licencing)
        
        return true
    }

}

