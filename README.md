# Feelings 🎭

Another rating view to share your **feelings**.

![Build Status](https://travis-ci.org/hemangshah/Feelings.svg?branch=master)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)
![Platform](https://img.shields.io/badge/Platforms-iOS%209.0%20%E2%89%A5-red.svg)
![Swift 3.x](https://img.shields.io/badge/Swift-4.x-blue.svg)
![MadeWithLove](https://img.shields.io/badge/Made%20with%20%E2%9D%A4-India-green.svg)
[![Awesome-Swift](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/matteocrippa/awesome-swift/)

<img src="https://github.com/hemangshah/Feelings/blob/master/Screenshots/Usage.gif"/>

## Installation

> **IMPORTANT**: You will need two images, one is filled and another is unfilled to represents feelings. See this sample images for the same, check it [here](https://github.com/hemangshah/Feelings/tree/master/Feelings/Feelings/Assets.xcassets).

1.**Manually** - Add `FeelingsView.swift` class to your Project. All set.

2.**CocoaPods**: `pod 'FeelingsView'`

# Usage:

### Create Programmatically.

````swift
//Create Sample Arrays
let rows = ["Quality","Price","Value"]
let columns = ["1 Star","2 Star","3 Star","4 Star","5 Star"]
        
//Create FeelingsView
//Note: You should provide two images for FeelingsView. 1. Filled and 2. Unfilled        
let viewFeeling = FeelingsView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
viewFeeling.backgroundColor = UIColor.clear
viewFeeling.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
self.view.addSubview(viewFeeling)
viewFeeling.center = self.view.center
    
//Setting fill/unfill images for FeelingsView
viewFeeling.fillImage = UIImage.init(named: "filled.png")!
viewFeeling.unfillImage = UIImage.init(named: "unfilled.png")!
        
//Setting up values for Feelings
viewFeeling.columnTitles = columns
viewFeeling.rowTitles = rows 
    
//Reload
viewFeeling.reloadFeelingView()
        
//Detect selection of Feelings value
viewFeeling.onFilledCompletion = { (row,column) in
    //Note: row and column are the Int which a user tapped in the FeelingsView
    let rowValue = rows[row]
    let columnValue = columns[column]
    print("\(rowValue) -> \(columnValue)")
}
````
    
> **IMPORTANT**: For customizations see the [example](https://github.com/hemangshah/Feelings/blob/master/Feelings/Feelings/ViewController.swift).

### Create in Storyboard/XIB.

1. Add a `UIView`. Set require size. Add constraints if requires.

2. Change class type from `UIView` to `FeelingsView`.
<img src="https://github.com/hemangshah/Feelings/blob/master/Screenshots/Usage-Screenshot-1.png">

3. Apply the properties for `FeelingsView`.
<img src="https://github.com/hemangshah/Feelings/blob/master/Screenshots/Usage-Screenshot-2.png">

4. Create an `IBOutlet` for `FeelingsView`. Bind it in `IBInspector`.

5. In `viewDidLoad` or at anyplace where you want provide rows and columns titles.

6. Reload `FeelingsView` by calling `reloadFeelingView` function.

7. Detect the taps on `FeelingsView` by implementing `onFilledCompletion` closure block.

# ToDo[s]

- [x] CocoaPods support

You can [watch](https://github.com/hemangshah/Feelings/subscription) to **Feelings** to see continuous updates. Stay tuned.

<b>Have an idea for improvements of this class?
Please open an [issue](https://github.com/hemangshah/Feelings/issues/new).</b>
    
## Credits

<b>[Hemang Shah](https://about.me/hemang.shah)</b>

**You can shoot me an [email](http://www.google.com/recaptcha/mailhide/d?k=01IzGihUsyfigse2G9z80rBw==&c=vU7vyAaau8BctOAIJFwHVbKfgtIqQ4QLJaL73yhnB3k=) to contact.**

## License

The MIT License (MIT)

> Read the [LICENSE](https://github.com/hemangshah/Feelings/blob/master/LICENSE) file for details.
