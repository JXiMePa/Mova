//
//  CustomUIImage.swift
//  Mova
//
//  Created by Tarasenko Jurik on 3/19/19.
//  Copyright © 2019 Next Level. All rights reserved.
//

import Foundation

import UIKit
import SDWebImage

final class CustomUIImage: UIImageView {
    
   private let spiner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.color = .blue
        spiner.hidesWhenStopped = true
        return spiner
    }()
    
    var setImageFromStringUrl: String? {
        didSet {
            if let urlString = setImageFromStringUrl, let url = URL(string: urlString) {
                sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"),
                            options: SDWebImageOptions()) { [weak self] _,_,_,_ in
                                self?.spiner.stopAnimating()
                }
            } else {
                self.image = UIImage(named: "placeholder")
                self.spiner.stopAnimating()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(spiner)
        _ = spiner.anchor(centerX: self.centerXAnchor, centerY: self.centerYAnchor)
        spiner.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
