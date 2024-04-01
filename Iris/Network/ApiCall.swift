//
//  ApiCal.swift
//  Iris
//
//  Created by Cristian Ursu on 31/03/2024.
//

import SwiftUI

class ApiCall {
    var endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    func getRandomMangas() async throws -> [MangaModel] {
        let endpoint = self.endpoint + "/manga/random"
        
        guard let url = URL(string: endpoint) else {
            print("-- ERROR -- : Can't access the api url")
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("-- ERROR -- : Api response is not 200")
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([MangaModel].self, from: data)
        } catch {
            print("-- ERROR -- : An error occurred when decoding the body")
            throw APIError.invalidData
        }
    }
    
    func getMangaPages(manga_name: String, chapter: String) async throws -> [String] {
        let endpoint = self.endpoint + "/manga/read/" + manga_name + "/" + chapter
        
        guard let url = URL(string: endpoint) else {
            print("-- ERROR -- : Can't access the api url")
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("-- ERROR -- : Api response is not 200")
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([String].self, from: data)
        } catch {
            print("-- ERROR -- : An error occurred when decoding the body")
            throw APIError.invalidData
        }
    }
    
    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
    
}

var apiCall = ApiCall(endpoint: "https://8b18-2a01-e0a-5c9-e830-ece9-d348-cc9a-2d4.ngrok-free.app")
