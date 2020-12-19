//
//  LoginTypes.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import Foundation

enum LoginTypes {
    case email(email: String, password: String)
    case facebook
    case github
    case apple
    case phone
}
