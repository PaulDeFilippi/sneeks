//
//  Constants.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 1/12/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import Foundation
import UIKit

struct Storyboard {
    static let LoginStoryboard = "LoginStoryboard"
    static let Main = "Main"
}

struct StoryboardId {
    static let LoginVC = "loginVC"
}

struct AppImages {
    static let GreenCheck = "green_check"
    static let RedCheck = "red_check"
}

struct AppColors {
    static let LightBlue = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    static let Purple = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 1, alpha: 1)
    static let Violet = #colorLiteral(red: 0.6866183281, green: 0.2397463322, blue: 1, alpha: 1)
}

struct Identifiers {
    static let CategoryCell = "CategoryCell"
    static let ProductCell = "ProductCell"
}

struct Segues {
    static let ToProducts = "toProductsVC"
}
