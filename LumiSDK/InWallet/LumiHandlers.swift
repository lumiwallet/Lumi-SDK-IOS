// Copyright © 2018 Lumi Technologies.
//
// This file is part of LumiSDK. The full LumiSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public enum LumiOperationResult {
  case success(result: String, walletInfo: LumiWalletInfoResponse)
  case error(LumiOperationErrors, walletInfo: LumiWalletInfoResponse)
}

extension LumiOperationResult {
  
  var json: Data {
    switch self {
    case let .success(result: result, walletInfo: info):
      let resultDictionary: [String: Any] = ["success": true, "result": result, "data": info.dictionary]
      let jsonData = try! JSONSerialization.data(withJSONObject: resultDictionary, options: [])
      return jsonData
      
    case let .error(error, walletInfo: _):
      let resultDictionary: [String: Any] = ["success": false, "error": error.rawValue]
      let jsonData = try! JSONSerialization.data(withJSONObject: resultDictionary, options: [])
      return jsonData
    }
  }
  
}


public enum LumiOperationErrors: String {
  case wrongNetwork = "WrongNetwork"
  case wrongRequest = "WrongRequest"
  case accountsIsWrong = "AccountsIsWrong"
  case transactionWillFail = "TransactionWillFail"
  case operationCanceled = "OperationCanceled"
  
  var json: Data {
    let resultDictionary: [String: Any] = ["error" : self.rawValue]
    let jsonData = try! JSONSerialization.data(withJSONObject: resultDictionary, options: [])
    
    return jsonData
  }
}

public struct LumiWalletInfoResponse {
  let address: String
  let balance: String
  var network: String
  
  public init(address: String, balance: String, network: String) {
    self.address = address
    self.balance = balance
    self.network = network
  }
  
  public var dictionary: [String: Any] {
    return ["account" : address,
            "amount" : balance,
            "network" : network]
  }
}


public class LumiURLHandler {
  
  public let command: LumiEthereumCommand
  private let completion: String
  
  
  public required init?(url: URL) {
    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    guard let _command = LumiEthereumCommand(url: url) else { return nil }
    guard let _completion = components?.queryItems?.first(where: { $0.name == "completion" })?.value else { return nil }
    
    command = _command
    completion = _completion
  }
  
  private func prepareCompletionComponents() -> URLComponents? {
    guard let components = URLComponents(string: completion) else { return nil }
    return components
  }
  
  
  public func complete(with result: LumiOperationResult) {
    if var components = prepareCompletionComponents() {
      let queryItem = URLQueryItem(name: "result", value: String.init(data: result.json, encoding: .utf8))
      components.queryItems = [queryItem]
      
      UIApplication.shared.open(components.url!, options: [:], completionHandler: nil)
    }
  }
  
}
