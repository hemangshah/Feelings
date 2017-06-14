# Feelings 🎭

Another rating view to share your **feelings**.

![Build Status](https://travis-ci.org/hemangshah/Feelings.svg?branch=master)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)
![Platform](https://img.shields.io/badge/Platforms-iOS-red.svg)
![Swift 4.x](https://img.shields.io/badge/Swift-4.x-blue.svg)
![Swift 3.x](https://img.shields.io/badge/Swift-3.x-blue.svg)
![MadeWithLove](https://img.shields.io/badge/Made%20with%20%E2%9D%A4-India-green.svg)
[![Blog](https://img.shields.io/badge/Blog-iKiwiTech.com-blue.svg)](http://www.ikiwitech.com)

<img src="https://github.com/hemangshah/Feelings/blob/master/Screenshots/Screenshot-1.png">

# Usage:

    //Create Sample Arrays
    let rows = ["Quality","Price","Value"]
    let columns = ["1 Star","2 Star","3 Star","4 Star","5 Star"]
        
    //Create FeelingsView
    //Note: You should provide two images for FeelingsView. 1. Filled and 2. Unfilled        
    let viewFeeling = FeelingsView.init(withFrame: CGRect.init(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
    viewFeeling.backgroundColor = UIColor.clear
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
    
> For customization see the example project.

# ToDos:

- [x] Customization Options.
- [x] Customize Fonts, Text/ Background.
- [x] Code Refactoring.

You can [watch](https://github.com/hemangshah/Feelings/subscription) to **Feelings** to see continuous updates. Stay tuned.

<b>Have an idea for improvements of this class?
Please open an [issue](https://github.com/hemangshah/Feelings/issues/new).</b>
    
## Credits

<b>[Hemang Shah](https://about.me/hemang.shah)</b>

**You can shoot me an [email](http://www.google.com/recaptcha/mailhide/d?k=01IzGihUsyfigse2G9z80rBw==&c=vU7vyAaau8BctOAIJFwHVbKfgtIqQ4QLJaL73yhnB3k=) to contact.**

## License

The MIT License (MIT)

> Read the [LICENSE](https://github.com/hemangshah/Feelings/blob/master/LICENSE) file for details.
