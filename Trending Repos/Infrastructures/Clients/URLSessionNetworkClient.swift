//
//  URLSessionNetworkClient.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

extension URLSession: NetworkClient {
    func perform<T>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
            dataTask(with: request) { data, response, error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                    return completion(.failure(NetworkError.invalidStatusCode))
                }

                guard let data else {
                    return completion(.failure(NetworkError.unknown))
                }

                do {
                    let model = try JSONDecoder.default.decode(T.self, from: data)
                    completion(.success(model))
                } catch let error {
                    completion(.failure(error))
                }
            }.resume()
    }
}
