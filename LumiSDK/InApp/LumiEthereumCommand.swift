// Copyright © 2018 Lumi Technologies.
//
// This file is part of LumiSDK. The full LumiSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public enum LumiEthereumCommand {
  case signMessage(message: String)
  
  case signTransaction(chainId: Int?, nonce: Int?, amount: String, address: String, data: String, gasPrice: String?, gasLimit: String?)
  
  case signSendTransaction(chainId: Int?, nonce: Int?, amount: String, address: String, data: String, gasPrice: String?, gasLimit: String?)
}

public extension LumiEthereumCommand {
  public init?(url: URL) {
    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    guard let host = components?.host else { return nil }
    guard let command = host.split(separator: ".").last?.dropLast() else { return nil }
    guard let queryItems = components?.queryItems else { return nil }
    
    switch command {
    case "signMessage":
      guard let message = queryItems.first(where: { $0.name == "message" })?.value else { return nil }
      
      self = .signMessage(message: message)
      
    case "signTransaction":
      guard let amount = queryItems.first(where: { $0.name == "amount" })?.value,
            let address = queryItems.first(where: { $0.name == "address" })?.value,
            let data = queryItems.first(where: { $0.name == "data" } )?.value else { return nil }
      
      let chainid = queryItems.first(where: { $0.name == "chainId" })?.value
      let nonce = queryItems.first(where: { $0.name == "nonce" })?.value
      
      let gasPrice = queryItems.first(where: { $0.name == "gasPrice" })?.value
      let gasLimit = queryItems.first(where: { $0.name == "gasLimit" })?.value
      
      self = .signTransaction(chainId: Int(chainid ?? ""), nonce: Int(nonce ?? ""), amount: amount, address: address, data: data, gasPrice: gasPrice, gasLimit: gasLimit)
      
    case "signSendTransaction":
      guard let amount = queryItems.first(where: { $0.name == "amount" })?.value,
            let address = queryItems.first(where: { $0.name == "address" })?.value,
            let data = queryItems.first(where: { $0.name == "data" } )?.value else { return nil }
      
      let chainid = queryItems.first(where: { $0.name == "chainId" })?.value
      let nonce = queryItems.first(where: { $0.name == "nonce" })?.value
      
      let gasPrice = queryItems.first(where: { $0.name == "gasPrice" })?.value
      let gasLimit = queryItems.first(where: { $0.name == "gasLimit" })?.value
      
      self = .signSendTransaction(chainId: Int(chainid ?? ""), nonce: Int(nonce ?? ""), amount: amount, address: address, data: data, gasPrice: gasPrice, gasLimit: gasLimit)
    default:
      return nil
    }
  }
}


public extension LumiEthereumCommand {
  
  var queryItems: [URLQueryItem] {
    switch self {
      
    case let .signMessage(message: message):
      return [URLQueryItem(name: "message", value: message)]
    
    case let .signTransaction(chainId, nonce, amount, address, data, gasPrice, gasLimit):
      var queryItems = [URLQueryItem(name: "amount", value: amount),
                        URLQueryItem(name: "address", value: address),
                        URLQueryItem(name: "data", value: data)]
      
      if let _ = chainId { queryItems.append(URLQueryItem(name: "chainId", value: "\(chainId!)")) }
      if let _ = nonce { queryItems.append(URLQueryItem(name: "nonce", value: "\(nonce!)")) }
      
      if let _ = gasPrice, let _ = gasLimit {
        queryItems.append(contentsOf: [URLQueryItem(name: "gasPrice", value: gasPrice),
                                       URLQueryItem(name: "gasLimit", value: gasLimit)])
      }
      
      return queryItems
      
    case let .signSendTransaction(chainId, nonce, amount, address, data, gasPrice, gasLimit):
      var queryItems = [URLQueryItem(name: "amount", value: amount),
                        URLQueryItem(name: "address", value: address),
                        URLQueryItem(name: "data", value: data)]
      
      if let _ = chainId { queryItems.append(URLQueryItem(name: "chainId", value: "\(chainId!)")) }
      if let _ = nonce { queryItems.append(URLQueryItem(name: "nonce", value: "\(nonce!)")) }
      
      if let _ = gasPrice, let _ = gasLimit {
        queryItems.append(contentsOf: [URLQueryItem(name: "gasPrice", value: gasPrice),
                                       URLQueryItem(name: "gasLimit", value: gasLimit)])
      }
      
      return queryItems
    }
  }
}


public extension LumiEthereumCommand {
  
  var blockchain: String { return "ethereum" }
  
  var name: String {
    switch self {
    case .signMessage:
      return "signMessage/"
    case .signTransaction:
      return "signTransaction/"
    case .signSendTransaction:
      return "signSendTransaction/"
    }
  }
}



