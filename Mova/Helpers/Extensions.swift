//
//  Extensions.swift
//  Mova
//
//  Created by Tarasenko Jurik on 3/19/19.
//  Copyright © 2019 Next Level. All rights reserved.
//

import UIKit

extension NSObject {
    class var identifier: String {
        return String(describing: self)
    }
}

extension UIColor {
    
    class func hexStr (_ hexStr : String, alpha : CGFloat) -> UIColor {
        var hexStr = hexStr
        hexStr = hexStr.replacingOccurrences(of: "#", with: "") as String
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string", terminator: "")
            return UIColor.white;
        }
    }
}

extension UIView {
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let centrX = centerX {
            anchors.append(centerXAnchor.constraint(equalTo: centrX))
        }
        
        if let centrY = centerY {
            anchors.append(centerYAnchor.constraint(equalTo: centrY))
        }
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    var borderColor: UIColor? {
        get { if let color = layer.borderColor {
            return UIColor(cgColor: color)
            }
            return nil
        }
        set { if let color = newValue {
            layer.borderColor = color.cgColor
        } else {
            layer.borderColor = nil
            }
        }
    }
}
