//
//  IHTTPClient.swift
//  TinkoffChatApp
//
//  Created by Ацкий Станислав on 28.11.2020.
//  Copyright © 2020 Ацкий Станислав. All rights reserved.
//

import Foundation

protocol IHTTPClient {
    func execute(session: URLSession,
                 request: URLRequest,
                 completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask
}
