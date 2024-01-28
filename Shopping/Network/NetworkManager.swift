//
//  NetworkManager.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case responseError
    case decodeError
    case serverError(statusCode: Int)
    case unknownError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
}

extension NetworkManager {
    func getHomeData() async throws -> HomeResponse {
        let url = try createURL(path: "/db")
        let data = try await fetchData(from: url)
        do {
            let decodeData = try JSONDecoder().decode(HomeResponse.self, from: data)
            return decodeData
        } catch {
            throw NetworkError.decodeError
        }
    }
}

private extension NetworkManager {
    func createURL(path: String) throws -> URL {
        let urlString = "\(HOST_URL)\(path)"
        guard let url = URL(string: urlString) else { throw NetworkError.urlError }
        return url
    }
    
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return data
            
        default:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
}
