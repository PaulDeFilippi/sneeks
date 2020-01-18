//
//  Category.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 1/15/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imgUrl: String
    var isActive: Bool
    var timeStamp: Timestamp
}
