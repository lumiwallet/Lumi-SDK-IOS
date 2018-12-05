
Pod::Spec.new do |s|

  s.name         = "LumiSDK"
  s.version      = "0.0.2"
  s.summary      = "SDK for signing messages and transactions via Lumi Collect app"
  s.homepage	 = "https://lumiwallet.com/"

  s.author       = { 'Benjamin West' => 'benjiwest'}

  s.platform     = :ios, '10.0'
  s.source       = { :git => 'https://github.com/lumitechnologies/Lumi-SDK-IOS.git', :tag => s.version }

  s.source_files  = 'LumiSDK', 'LumiSDK/**/*{h,m,c,swift}'

end
