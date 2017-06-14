//
//  FeelingsView.swift
//  Feelings
//
//  Created by Hemang Shah on 6/14/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

//You can change this value accordingly and it will update the entire FeelingsView
fileprivate let leftMarginForRows = 50.0
fileprivate let topMarginForColumns = 50.0

@IBDesignable
public class FeelingsView : UIView {
    
    ///columnTitles of Type Array<String>
    public var columnTitles = Array<String>()
    ///rowTitles of Type Array<String>
    public var rowTitles = Array<String>()
    
    //Fonts
    @IBInspectable public var rowTitleFont:UIFont?
    @IBInspectable public var columnTitleFont:UIFont?
    
    //Colors
    @IBInspectable public var rowTitleColor:UIColor?
    @IBInspectable public var columnTitleColor:UIColor?
    
    //Background Colors
    @IBInspectable public var rowTitleBackgroundColor:UIColor?
    @IBInspectable public var columnTitleBackgroundColor:UIColor?
    @IBInspectable public var feelingsButtonsBackgroundColor:UIColor?
    
    //fill Image (Uses to show radio button selection)
    @IBInspectable fileprivate var fillImage:UIImage?
    //unfillImage Image (Uses to show radio button not selected)
    @IBInspectable fileprivate var unfillImage:UIImage?
    
    //Completion Block to Detect selection of Feelings value (row,column).
    public var onFilledCompletion:((_ row:Int, _ column:Int) -> ())? = nil
    
    //MARK:Init
    init(withFrame frame:CGRect, withFillImage fImage:UIImage, withUnFillImage unFImage:UIImage) {
        super.init(frame: frame)
        self.fillImage = fImage
        self.unfillImage = unFImage
        //By default, you can customize it to your wish.
        self.backgroundColor = .clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Create Rows/Columns/Feelings
    fileprivate func createRows() -> Void {
        let rowLabelPointX:Double = 0.0
        var rowLabelPointY:Double = topMarginForColumns
        let feelingsViewHeight:Double = Double(self.frame.height)
        let dynamicHeight = (feelingsViewHeight - topMarginForColumns) / Double(rowTitles.count)
        
        for index in 0..<self.rowTitles.count {
            let rowLabel = createLabel(withFrame: CGRect.init(x: rowLabelPointX, y: rowLabelPointY, width: leftMarginForRows, height: dynamicHeight), text: rowTitles[index], font: UIFont.boldSystemFont(ofSize: 12.0), textColor: .black, textAlignment: .center)
            rowLabel.numberOfLines = 2
            if let rowTitleColor = rowTitleColor {
                rowLabel.textColor = rowTitleColor
            }
            if let rowTitleBackgroundColor = rowTitleBackgroundColor {
                rowLabel.backgroundColor = rowTitleBackgroundColor
            }
            if let rowTitleFont = rowTitleFont {
                rowLabel.font = rowTitleFont
            }
            self.addSubview(rowLabel)
            rowLabelPointY = rowLabelPointY + dynamicHeight
        }
    }
    
    fileprivate func createColumns() -> Void {
        var columnLabelPointX:Double = leftMarginForRows
        let columnLabelPointY:Double = 0.0
        let feelingsViewWidth:Double = Double(self.frame.width)
        let dynamicWidth = (feelingsViewWidth - leftMarginForRows) / Double(columnTitles.count)
        
        for index in 0..<self.columnTitles.count {
            let columnLabel = createLabel(withFrame: CGRect.init(x: columnLabelPointX, y: columnLabelPointY, width: dynamicWidth, height: topMarginForColumns), text: columnTitles[index], font: UIFont.boldSystemFont(ofSize: 12.0), textColor: .black, textAlignment: .center)
            columnLabel.numberOfLines = 2
            if let columnTitleColor = columnTitleColor {
                columnLabel.textColor = columnTitleColor
            }
            if let columnTitleBackgroundColor = columnTitleBackgroundColor {
                columnLabel.backgroundColor = columnTitleBackgroundColor
            }
            if let columnTitleFont = columnTitleFont {
                columnLabel.font = columnTitleFont
            }
            self.addSubview(columnLabel)
            columnLabelPointX = columnLabelPointX + dynamicWidth
        }
    }
    
    fileprivate func createFeelings() -> Void {
        var feelingsViewPointX:Double = leftMarginForRows
        var feelingsViewPointY:Double = topMarginForColumns
        let feelingsViewWidth:Double = Double(self.frame.width)
        let dynamicWidth = (feelingsViewWidth - leftMarginForRows) / Double(columnTitles.count)
        
        for rowIndex in 0..<self.rowTitles.count {
            
            let rowView = UIView.init(frame: CGRect.init(x: feelingsViewPointX, y: feelingsViewPointY, width: dynamicWidth * Double(columnTitles.count), height: topMarginForColumns))
            rowView.tag = (rowIndex + 1)
            rowView.backgroundColor = .clear
            self.addSubview(rowView)
            
            var feelingsButtonPointX:Double = 0.0
            for columnIndex in 0..<self.columnTitles.count {
                let feelingsButton = UIButton()
                feelingsButton.tag = columnIndex + 1
                feelingsButton.frame = CGRect.init(x: feelingsButtonPointX, y: 0.0, width: dynamicWidth, height: topMarginForColumns)
                feelingsButton.addTarget(self, action: #selector(actionFeelingsTapped), for: .touchUpInside)
                feelingsButton.setImage(unfillImage!, for: .normal)
                feelingsButton.setImage(fillImage!, for: .selected)
                feelingsButton.backgroundColor = .clear
                if let feelingsButtonsBackgroundColor = feelingsButtonsBackgroundColor {
                    feelingsButton.backgroundColor = feelingsButtonsBackgroundColor
                }
                rowView.addSubview(feelingsButton)
                feelingsButtonPointX = feelingsButtonPointX + dynamicWidth
            }
            feelingsViewPointX = leftMarginForRows
            feelingsViewPointY = feelingsViewPointY + topMarginForColumns
        }
    }
    
    //MARK: Actions
    @objc fileprivate func actionFeelingsTapped(button:UIButton) -> Void {
        let rowView = button.superview!
        unFilledEveryOneInRow(button: button, withRowView: rowView)
        button.isSelected = !button.isSelected
        if onFilledCompletion != nil {
            onFilledCompletion!(rowView.tag-1, button.tag-1)
        }
    }
    
    //MARK: Helpers
    fileprivate func unFilledEveryOneInRow(button:UIButton, withRowView rowView:UIView) -> Void {
        for case let feelingsButton as UIButton in rowView.subviews {
            feelingsButton.isSelected = false
        }
    }
    
    //MARK: Create Label
    fileprivate func createLabel(withFrame frame:CGRect, text:String, font:UIFont, textColor:UIColor, textAlignment:NSTextAlignment) -> UILabel {
        let label = UILabel.init(frame: frame)
        label.backgroundColor = UIColor.clear
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.minimumScaleFactor = (UIFont.labelFontSize/2)/UIFont.labelFontSize
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    //MARK: Reload Feelings View
    ///FeelingsView should be reload after setting rows and columns titles.
    public func reloadFeelingView() -> Void {
        createRows()
        createColumns()
        createFeelings()
    }
}
