//
//  RequestSender.swift
//  TinkoffChatApp
//
//  Created by Ацкий Станислав on 13.11.2020.
//  Copyright © 2020 Ацкий Станислав. All rights reserved.
//

import Foundation

struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}

protocol IRequestSender {
    func send<Parser>(requestConfig config: RequestConfig<Parser>,
                      _ completion: @escaping(Result<Parser.Model, RequestSenderError>) -> Void)
    func cancel(request: IRequest)
}

final class RequestSender: IRequestSender {
        
    private let session: URLSession
    private let httpClient: IHTTPClient
    
    private var activeTasks = [URLSessionTask]()
    
    // MARK: - Init
    
    init(session: URLSession, httpClient: IHTTPClient) {
        self.session = session
        self.httpClient = httpClient
    }
    
    // MARK: - IRequestSender
    
    func send<Parser>(requestConfig config: RequestConfig<Parser>,
                      _ completion: @escaping (Result<Parser.Model, RequestSenderError>) -> Void) {
        guard let urlRequest = config.request.urlRequest else {
            completion(.failure(.unknowned("stringURL can't be parsed to URL")))
            return
        }
        
        let task = httpClient.execute(session: session,
                                      request: urlRequest) { result in
            switch result {
            case .success(let data):
                guard let model: Parser.Model = config.parser.parse(data: data) else {
                    completion(.failure(.unknowned("received data can't be parsed")))
                    return
                }
                completion(.success(model))
            case .failure(let error):
                completion(.failure(.unknowned(error.localizedDescription)))
                return
            }
        }

        appendInActiveTasks(task)
    }

    func cancel(request: IRequest) {
        DispatchQueue.global().async { [weak self] in
            self?.activeTasks
                .filter { $0.state == .running }
                .filter { $0.currentRequest?.url == request.urlRequest?.url }
                .forEach { $0.cancel() }
        }
    }
    
    // MARK: - Helpful
    
    private func appendInActiveTasks(_ task: URLSessionTask) {
        activeTasks = activeTasks.filter { $0.state == .running }
        activeTasks += [task]
    }
    
}
