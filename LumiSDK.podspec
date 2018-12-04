#
#  Be sure to run `pod spec lint LumiSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LumiSDK"
  s.version      = "0.0.1"
  s.summary      = "SDK for signing messages and transactions via Lumi Collect app"
  s.homepage	 = "https://lumiwallet.com/"

  s.author       = { 'Benjamin West' => 'benjiwest'}

  s.platform     = :ios, '10.0'
  s.source       = { :git => 'https://github.com/benjiwest/Lumi-SDK-IOS.git', :tag => s.version }

  s.source_files  = 'LumiSDK', 'LumiSDK/**/*{h,m,c,swift}'

end
