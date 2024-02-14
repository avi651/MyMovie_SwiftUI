//
//  MovieAPIService.swift
//  TheMovie
//
//  Created by Avinash on 14/02/24.
//

import Foundation

class MovieNetworkService {
    public static func fetch<T: Decodable>(type: T.Type, url: URL?, httpMethod: String, completion: @escaping(Result<T,MovieAPIError>) -> Void) {
        guard let url = url else {
            let error = MovieAPIError.badURL
            completion(Result.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(MovieAPIError.urlSession(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(MovieAPIError.badResponse(response.statusCode)))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(.decoding(error as? DecodingError)))
                }
            }
        }.resume()
    }
}
