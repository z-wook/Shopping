//
//  NetworkManager.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
}

extension NetworkManager {
    func getHomeData() async throws -> HomeResponse {
        let urlString = HOME_API
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
         
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
        let decodeData = try JSONDecoder().decode(HomeResponse.self, from: data)
        return decodeData
    }
}
