//
//  HTTPClient.swift
//  TinkoffChatApp
//
//  Created by Ацкий Станислав on 28.11.2020.
//  Copyright © 2020 Ацкий Станислав. All rights reserved.
//

import Foundation

final class HTTPClient: IHTTPClient {
    func execute(session: URLSession,
                 request: URLRequest,
                 completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
                
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        
        return task
    }
}
