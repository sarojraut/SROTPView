Pod::Spec.new do |s|
  s.name             = 'SROTPView'
  s.version          = '0.1.0'
  s.summary          = 'OTP view is designed to be used as alternative to default textfield and it is beautifully designed'
 
  s.description      = <<-DESC
This OTP view is beautifully design to be used in otp field which support auto population of otp from message and change in the color of empty, filled and active field as well as error 
                       DESC
 
  s.homepage         = 'https://github.com/sarojraut/SROTPView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Saroj Raut' => 'sarojraut09@gmail.com' }
  s.source           = { :git => 'https://github.com/sarojraut/FantasticView.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'SROTPView/SROTPView.swift','SROTPView/SROTPTextField.swift'
  
 
end