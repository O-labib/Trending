//
//  NetworkClient.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

protocol NetworkClient {
    func perform<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}
