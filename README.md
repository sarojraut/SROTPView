# SROTPView

[![CI Status](https://img.shields.io/travis/sarojraut09@gmail.com/SROTPView.svg?style=flat)](https://travis-ci.org/sarojraut09@gmail.com/SROTPView)
[![Version](https://img.shields.io/cocoapods/v/SROTPView.svg?style=flat)](https://cocoapods.org/pods/SROTPView)
[![License](https://img.shields.io/cocoapods/l/SROTPView.svg?style=flat)](https://cocoapods.org/pods/SROTPView)
[![Platform](https://img.shields.io/cocoapods/p/SROTPView.svg?style=flat)](https://cocoapods.org/pods/SROTPView)

## Example
![alt text](https://github.com/sarojraut/SROTPView/blob/master/screenshots/underline.png)
![alt text](https://github.com/sarojraut/SROTPView/blob/master/screenshots/rounded.png)
![alt text](https://github.com/sarojraut/SROTPView/blob/master/screenshots/pasted.png)
![alt text](https://github.com/sarojraut/SROTPView/blob/master/screenshots/filled.png)



To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 11.0+
- Xcode 11

## Installation

SROTPView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SROTPView'
```

#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/SROTPView.framework` to an iOS project.

```
github "sarojraut/SROTPView"
```
#### Manually
1. Download and drop ```SROTPView.swift and SROTPTextField.swift``` in your project.  
2. Congratulations!  

## Usage example

```swift
import UIKit
import SROTPView

class ClassThatUseThisLibrary: UIViewController {

    @IBOutlet weak var otpView: SROTPView! //dont use SROTPField use SROTPView
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        otpView.otpTextFieldsCount = 6
        otpView.otpTextFieldActiveBorderColor = UIColor.white
        otpView.otpTextFieldDefaultBorderColor = UIColor.green
        otpView.otpTextFieldFontColor = UIColor.green
        otpView.activeHeight = 4
        otpView.inactiveHeight = 2
        otpView.otpType = .Rounded //.Rounded for round
        otpView.otpEnteredString = { pin in
            print("The entered pin is \(pin)")
        }
        otpView.setUpOtpView()
    }
       
    override func viewDidAppear(_ animated: Bool) {
               otpView.initializeUI()
        }
    
}

```

## Contribute

We would love you for the contribution to **SROTPView**, check the ``LICENSE`` file for more info.
## Author

sarojraut09@gmail.com

## Apps Using SROTPView
AeonWallet Cambodia
https://apps.apple.com/kh/app/aeon-wallet-cambodia/id1328330562
AeonWallet agent/merchant
https://apps.apple.com/kh/app/aeon-wallet-agent-merchant/id1328867502
Global Smart Plus
https://apps.apple.com/np/app/global-smart-plus/id1565283667

## License

SROTPView is available under the MIT license. See the LICENSE file for more info.

Copyright (c) 2019 sarojraut09@gmail.com 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


