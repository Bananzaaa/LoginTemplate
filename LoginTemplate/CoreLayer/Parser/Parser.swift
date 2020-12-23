//
//  Parser.swift
//  TinkoffChatApp
//
//  Created by Ацкий Станислав on 13.11.2020.
//  Copyright © 2020 Ацкий Станислав. All rights reserved.
//

import Foundation

protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}
