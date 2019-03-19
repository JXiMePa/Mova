//
//  ResultCell.swift
//  Mova
//
//  Created by Tarasenko Jurik on 3/19/19.
//  Copyright © 2019 Next Level. All rights reserved.
//

import UIKit

final class ResultCell: BaseCell {
    
    //MARK: Views
    private let searchImage: CustomUIImage = {
       let image = CustomUIImage()
        image.contentMode = UIView.ContentMode.scaleAspectFit
        image.backgroundColor = UIColor.hexStr(HexColors.lightGray, alpha: 1)
        return image
    }()
    
    private let searchText: UILabel = {
       let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.backgroundColor = UIColor.hexStr(HexColors.lightGray, alpha: 1)
        return label
    }()
    
    //MARK: Property

    var setImage: String? {
        get { return "" }
        set { searchImage.setImageFromStringUrl = newValue }
    }
    
    var setText: String? {
        get { return searchText.text }
        set { searchText.text = newValue }
    }

    //MARK Func
    override func setupViews() {
        self.cornerRadius = 15
        
        addSubview(searchImage)
        _ = searchImage.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, bottomConstant: 40)
        
        addSubview(searchText)
        _ = searchText.anchor(searchImage.bottomAnchor, left: searchImage.leftAnchor, bottom: bottomAnchor, right: searchImage.rightAnchor, centerX: nil, centerY: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }

}
