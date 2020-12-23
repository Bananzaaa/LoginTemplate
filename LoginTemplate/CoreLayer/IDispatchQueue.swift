//
//  IDispatchQueue.swift
//  TinkoffChatApp
//
//  Created by Ацкий Станислав on 29.11.2020.
//  Copyright © 2020 Ацкий Станислав. All rights reserved.
//

import Foundation

protocol IDispatchQueue {
    func async(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: IDispatchQueue {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .default, flags: [], execute: work)
    }
}
