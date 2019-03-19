//
//  Alert.swift
//  Mova
//
//  Created by Tarasenko Jurik on 3/19/19.
//  Copyright © 2019 Next Level. All rights reserved.
//

import UIKit

final class Alert {
    private init () {}

    static func showAlert(title: String, msg: String, customActions: [UIAlertAction], completion: ((UIAlertController) -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
            
            if customActions.isEmpty {
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            } else {
                for action in customActions {
                    alert.addAction(action)
                }
            }
            completion?(alert)
        }
    }
}
