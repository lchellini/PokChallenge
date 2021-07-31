//
//  AppInfo.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import Foundation

struct AppInfo {
    struct Names{
        static var appBundleName:String {
            get {guard Bundle.main.infoDictionary != nil else {return ""}
                return Bundle.main.infoDictionary!["CFBundleName"] as! String
            }
        }
        static var appBundleShortVersion:String {
            get {guard Bundle.main.infoDictionary != nil else {return ""}
                return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            }
        }
        static var appBundleBuild:String {
            get {guard Bundle.main.infoDictionary != nil else {return ""}
                return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
            }
        }

    
        init( appBundleName:String, appBundleShortVersion:String, appBundleBuild:String ) {
        }
    }
}
