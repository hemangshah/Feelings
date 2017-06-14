//
//  Feelings.swift
//  Feelings
//
//  Created by Hemang Shah on 6/14/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

let leftMarginForRows = 50.0
let topMarginForColumns = 50.0

let heightForRows = 30.0

public class FeelingsView : UIView {
    public var columnTitles = Array<String>()
    public var rowTitles = Array<String>()
    public var fillImage:UIImage?
    public var unfillImage:UIImage?
    
    init(withFrame frame:CGRect, withFillImage fImage:UIImage, withUnFillImage unFImage:UIImage) {
        super.init(frame: frame)
        self.fillImage = fImage
        self.unfillImage = unFImage
        self.backgroundColor = .white
    }
    
    fileprivate func createRows() -> Void {
        let rowLabelPointX:Double = 0.0
        var rowLabelPointY:Double = topMarginForColumns
        let feelingsViewHeight:Double = Double(self.frame.height)
        let dynamicHeight = (feelingsViewHeight - topMarginForColumns) / Double(rowTitles.count)
        
        for index in 0..<self.rowTitles.count {
            let rowLabel = createLabel(withFrame: CGRect.init(x: rowLabelPointX, y: rowLabelPointY, width: leftMarginForRows, height: dynamicHeight), text: rowTitles[index], font: UIFont.boldSystemFont(ofSize: 12.0), textColor: .black, textAlignment: .center)
            rowLabel.numberOfLines = 2
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
            self.addSubview(columnLabel)
            columnLabelPointX = columnLabelPointX + dynamicWidth
        }
    }
    
    fileprivate func createFeelings() -> Void {
        var feelingsLabelPointX:Double = leftMarginForRows
        var feelingsLabelPointY:Double = topMarginForColumns
        let feelingsViewWidth:Double = Double(self.frame.width)
        let dynamicWidth = (feelingsViewWidth - leftMarginForRows) / Double(columnTitles.count)
        
        for _ in 0..<self.rowTitles.count {
            for _ in 0..<self.columnTitles.count {
                let feelingsButton = UIButton()
                feelingsButton.frame = CGRect.init(x: feelingsLabelPointX, y: feelingsLabelPointY, width: dynamicWidth, height: topMarginForColumns)
                feelingsButton.addTarget(self, action: #selector(actionFeelingsTapped), for: .touchUpInside)
                feelingsButton.setImage(unfillImage!, for: .normal)
                feelingsButton.setImage(fillImage!, for: .selected)
                feelingsButton.backgroundColor = .clear
                self.addSubview(feelingsButton)
                feelingsLabelPointX = feelingsLabelPointX + dynamicWidth
            }
            feelingsLabelPointX = leftMarginForRows
            feelingsLabelPointY = feelingsLabelPointY + topMarginForColumns
        }
    }
    
    //MARK: Actions
    @objc fileprivate func actionFeelingsTapped(feelingsButton:UIButton) -> Void {
        print("Tapped!")
        feelingsButton.isSelected = !feelingsButton.isSelected
    }
    
    public func reloadFeelingView() -> Void {
        createRows()
        createColumns()
        createFeelings()
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
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
