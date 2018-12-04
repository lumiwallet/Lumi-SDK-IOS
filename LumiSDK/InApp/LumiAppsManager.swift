// Copyright © 2018 Lumi Technologies.
//
// This file is part of LumiSDK. The full LumiSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public struct LumiApp {
  var name: String
  var scheme: String
  var installUrl: String
}

public class LumiAppsManager {
  static let apps = [ LumiApp(name: "LumiCollect", scheme: "lumicollect", installUrl: ""),
                      LumiApp(name: "Lumi", scheme: "lumiwallet", installUrl: "")]
  
  public static var availableApps = {
    return apps.filter({ (app) -> Bool in
      UIApplication.shared.canOpenURL(URL(string: "\(app.scheme)://")!)
    })
  }()
}
