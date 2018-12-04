// Copyright © 2018 Lumi Technologies.
//
// This file is part of LumiSDK. The full LumiSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit
import LumiSDK

class ViewController: UIViewController {

  @IBOutlet weak var messageTextField: UITextField!
  
  
  @IBOutlet weak var addressTextField: UITextField!
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var dataTextField: UITextField!
  
  @IBOutlet weak var networkTextField: UITextField!
  @IBOutlet weak var nonceTextField: UITextField!
  
  @IBOutlet weak var gasPriceTextField: UITextField!
  @IBOutlet weak var gasLimitTextField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func signMessagePressed(_ sender: Any) {
    let lumiOperation = LumiOperation(.signMessage(message: messageTextField.text ?? ""), completionScheme: "currentAppScheme")
    lumiOperation.execute()
  }
  
  @IBAction func signTransactionPressed(_ sender: Any) {
    let address = addressTextField.text ?? ""
    let amount = amountTextField.text ?? "0x00"
    let data = dataTextField.text ?? "0x00"
    let network = Int(networkTextField.text ?? "1") ?? 1
    let nonce = Int(nonceTextField.text ?? "0") ?? 0
    
    let gasprice = gasPriceTextField.text
    let gaslimit = gasLimitTextField.text
    
   let lumiOperation = LumiOperation(.signTransaction(chainId: network, nonce: nonce, amount: amount, address: address, data: data, gasPrice: gasprice, gasLimit: gaslimit), completionScheme: "currentAppScheme")
    
    lumiOperation.execute()
    
  }
  
  @IBAction func signAndSendTransactionPressed(_ sender: Any) {
    let address = addressTextField.text ?? ""
    let amount = amountTextField.text ?? "0x00"
    let data = dataTextField.text ?? "0x00"
    let network = Int(networkTextField.text ?? "1") ?? 1
    let nonce = Int(nonceTextField.text ?? "0") ?? 0
    
    let gasprice = gasPriceTextField.text
    let gaslimit = gasLimitTextField.text
    
    let lumiOperation = LumiOperation(.signSendTransaction(chainId: network, nonce: nonce, amount: amount, address: address, data: data, gasPrice: gasprice, gasLimit: gaslimit), completionScheme: "currentAppScheme")
    
    lumiOperation.execute()
    
  }
}

