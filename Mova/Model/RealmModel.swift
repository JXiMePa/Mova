//
//  RealmModel.swift
//  Mova
//
//  Created by Tarasenko Jurik on 3/19/19.
//  Copyright © 2019 Next Level. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmModel: Object {
    
    @objc dynamic var searchText = ""
    @objc dynamic var imageString = ""
}
