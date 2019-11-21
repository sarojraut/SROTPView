Pod::Spec.new do |s|
  s.name             = 'SROTPView'
  s.version          = '0.1.1'
  s.summary          = 'OTP view is designed to be used as alternative to default textfield and it is beautifully designed'
 
  s.description      = <<-DESC
This OTP view is beautifully design to be used in otp field which support auto population of otp from message and change in the color of empty, filled and active field as well as error 
                       DESC
 
   s.homepage         = 'https://github.com/sarojraut/SROTPView'
  s.license = { :type => 'MIT', :text => <<-LICENSE
                  Copyright (c) 2019 saroj raut

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
                 LICENSE
               }



  s.author           = { 'Saroj Raut' => 'sarojraut09@gmail.com' }
  s.source           = { :git => 'https://github.com/sarojraut/SROTPView.git', :tag => s.version.to_s }
  s.swift_version = '4.0'

 
  s.ios.deployment_target = '10.0'
  s.source_files = 'SROTPView/SROTPView.swift','SROTPView/SROTPTextField.swift' , "LICENSE.txt"
  
 
end


