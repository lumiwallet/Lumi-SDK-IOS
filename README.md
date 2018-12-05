# Lumi-SDK-IOS
SDK for signing messages and transactions via Lumi Collect app

## Add dependency

LumiSDK is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```
pod 'LumiSDK'

```

Run 'pod install'

## Handle Lumi callbacks

In your AppDelegate add ‘import LumiSDK’ to the top of your file. 
Within your ‘func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool’ method add this: 

```
let handler = LumiURLHandler(url: url)

```

“Handler” contains the information about the executed command type, the result itself is presented in the URL in JSON format (the “result” parameter). 

## Create and execute the operation with Lumi wallet 

To create a wallet operation you need to add ‘import LumiSDK’ to the top of your file


* To sign a message add the following code. Do not forget to replace “message” with a message that needs to be signed and to add currentAppScheme to your schema (your scheme setup is described below)

```
let lumiOperation = LumiOperation(.signMessage(message: message), completionScheme: currentAppScheme)

```

Network, nonce,  gasPrice, gasLimit are optional parameters and Lumi Collect does not process them at the time, but we will do that soon. Please do not forget to substitute all the parameters with yours and currentAppScheme with your schema which is described below.

* Add the following code for signing the transaction

```
let lumiOperation = LumiOperation(.signTransaction(chainId: network, nonce: nonce, amount: amount, address: address, data: data, gasPrice: gasprice, gasLimit: gaslimit), completionScheme: currentAppScheme)

```

Network, nonce,  gasPrice, gasLimit are optional parameters and Lumi Collect does not process them at the time, but we will do that soon. Please do not forget to substitute all the parameters with yours and currentAppScheme with your scheme which is described below.


* Add the following code for signing and sending the transaction

```
let lumiOperation = LumiOperation(.signSendTransaction(chainId: network, nonce: nonce, amount: amount, address: address, data: data, gasPrice: gasprice, gasLimit: gaslimit), completionScheme: currentAppScheme)

```

Network, nonce,  gasPrice, gasLimit are optional parameters and Lumi Collect does not process them at the time, but we will do that soon. Please do not forget to substitute all the parameters with yours and currentAppScheme with your scheme which is described below.


* The wallet operations must be executed with the following code:

```
lumiOperation.execute()

```

## Register a scheme for your app

Open Xcode an click on your project. Go to the 'Info' tab and expand the 'URL Types' group. Click on the `+` button to add a new scheme. Enter a custom scheme name in 'URL Schemes'.

![Adding a scheme](docs/scheme.png)

## Example

LumiSDK includes an example project with the above code. To run the example project clone the repo. Open `LumiSDK.xcworkspace`, chose LumiSDKExample target and run. Make sure that you have LumiCollect installed on the device or simulator to test the full callback flow.

## License

LumiSDK is available under the MIT license. See the LICENSE file for more info.


