//
//  FeelingsView.swift
//  Feelings
//
//  Created by Hemang Shah on 6/14/17.
//  Copyright © 2017 Hemang Shah. All rights reserved.
//

import UIKit

//Credits for the Animation: [SeanAllen] https://gist.github.com/SAllen0400/a09754049fcdcc00695291b3a011fbbd

fileprivate extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}

//You can change this value accordingly and it will update the entire FeelingsView
fileprivate let leftMarginForRows = 50.0
fileprivate let topMarginForColumns = 50.0

public enum FeelingsViewButtonTapAnimationType: Int {
    case None
    case Pulse
    case Flash
    case Shake
}

@IBDesignable
public class FeelingsView : UIView {
    
    ///columnTitles of Type Array<String>
    public var columnTitles = Array<String>()
    ///rowTitles of Type Array<String>
    public var rowTitles = Array<String>()
    ///Animation Type for the Feelings Button Taps.
    public var feelingsButtonAnimationType: FeelingsViewButtonTapAnimationType = .None
    ///Default Feelings Value.
    public var defaultFeeligns:Int = -1
    
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
    @IBInspectable public var fillImage:UIImage? = nil
    //unfillImage Image (Uses to show radio button not selected)
    @IBInspectable public var unfillImage:UIImage? = nil
    
    //Completion Block to Detect selection of Feelings value (row,column).
    public var onFilledCompletion:((_ row:Int, _ column:Int) -> ())? = nil
    
    //MARK:Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
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
                if defaultFeeligns >= 1 && defaultFeeligns <= columnTitles.count {
                    if defaultFeeligns == (columnIndex + 1) {
                        actionFeelingsTapped(button: feelingsButton)
                    }
                }
            }
            feelingsViewPointX = leftMarginForRows
            feelingsViewPointY = feelingsViewPointY + topMarginForColumns
        }
    }
    
    //MARK: Actions
    @objc fileprivate func actionFeelingsTapped(button:UIButton) -> Void {
        if feelingsButtonAnimationType != .None {
            if feelingsButtonAnimationType == .Pulse {
                button.pulsate()
            } else if feelingsButtonAnimationType == .Flash {
                button.flash()
            } else if feelingsButtonAnimationType == .Shake {
                button.shake()
            }
        }
        
        let rowView = button.superview!
        unFilledEveryOneInRow(button: button, withRowView: rowView)
        button.isSelected = !button.isSelected
        button.isUserInteractionEnabled = !button.isUserInteractionEnabled
        if onFilledCompletion != nil {
            onFilledCompletion!(rowView.tag-1, button.tag-1)
        }
    }
    
    //MARK: Helpers
    fileprivate func unFilledEveryOneInRow(button:UIButton, withRowView rowView:UIView) -> Void {
        for case let feelingsButton as UIButton in rowView.subviews {
            feelingsButton.isSelected = false
            feelingsButton.isUserInteractionEnabled = true
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
        guard fillImage != nil || unfillImage != nil else {
            print("You forgot to provide fillImage or unfillImage.")
            return
        }
        
        guard rowTitles.count > 0 && columnTitles.count > 0 else {
            print("You forgot to provide rowTitles or columnTitles values.")
            return
        }
        createRows()
        createColumns()
        createFeelings()
    }
}
