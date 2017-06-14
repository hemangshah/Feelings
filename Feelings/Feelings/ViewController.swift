//
//  ViewController.swift
//  Feelings
//
//  Created by Hemang Shah on 6/14/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
        //Setting up values for FeelingsView
        viewFeeling.columnTitles = columns
        viewFeeling.rowTitles = rows
        
        //Customization Options
        //viewFeeling.backgroundColor = .red
        
        //viewFeeling.rowTitleColor = .white
        //viewFeeling.columnTitleColor = .white
        
        //viewFeeling.rowTitleFont = UIFont.init(name: "Verdana", size: 14.0)
        //viewFeeling.columnTitleFont = UIFont.init(name: "Helvetica", size: 14.0)
        
        //viewFeeling.rowTitleBackgroundColor = .red
        //viewFeeling.columnTitleBackgroundColor = .red
        
        //viewFeeling.feelingsButtonsBackgroundColor = .white
        
        //Reload
        viewFeeling.reloadFeelingView()
        
        //Detect selection of Feelings value
        viewFeeling.onFilledCompletion = { (row,column) in
            //Note: row and column are the Int which a user tapped in the FeelingsView
            let rowValue = rows[row]
            let columnValue = columns[column]
            print("\(rowValue) -> \(columnValue)")
        }
    }
}
