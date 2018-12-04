// Copyright © 2018 Lumi Technologies.
//
// This file is part of LumiSDK. The full LumiSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public class LumiOperation {
  var command: LumiEthereumCommand
  
  var completionScheme: String

  
  public init(_ command: LumiEthereumCommand, completionScheme: String) {
    self.command = command
    self.completionScheme = completionScheme
  }
  
  
  private func requestUrl(scheme: String) -> URL {
    var components = URLComponents()
    components.scheme = scheme
    components.host = command.blockchain + "." + command.name
    components.queryItems = command.queryItems
    components.queryItems?.append(URLQueryItem(name: "completion", value: completionUrl().absoluteString))
    return components.url!
  }
  
  
  private func completionUrl() -> URL {
    var components = URLComponents()
    components.scheme = completionScheme
    components.host = command.blockchain + "." + command.name
    return components.url!
  }
  
  
  public func execute() {
    guard let app = LumiAppsManager.apps.first else {
      return
    }
    
    if #available(iOS 10.0, *) {
      UIApplication.shared.open(requestUrl(scheme: app.scheme), options: [:], completionHandler: nil)
    } else {
      UIApplication.shared.openURL(requestUrl(scheme: app.scheme))
    }
  }
  
}
