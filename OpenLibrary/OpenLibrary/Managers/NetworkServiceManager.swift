//
//  NetworkServiceManager.swift
//  OpenLibrary
//
//  Created by mac on 15.04.23.
//

import Foundation

final class NetworkServiceManager {
    static let shared = NetworkServiceManager()
    
    func getJson(with url: String, completion: @escaping (Result<BookObject, Error>) -> Void){
        guard let urlJson = APILibrary.host.getURL(with: url) else { return }
        
        URLSession.shared.dataTask(with: urlJson, completionHandler: { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let object = try JSONDecoder().decode(BookObject.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } catch (let error) {
                completion(.failure(error))
            }
        }).resume()
    }
    
    func getJsonTrending(completion: @escaping (Result<Library, Error>) -> Void){
        guard let urlJson = APILibrary.hostTWO.getURLTrending() else { return }
        
        URLSession.shared.dataTask(with: urlJson, completionHandler: { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let object = try JSONDecoder().decode(Library.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } catch (let error) {
                completion(.failure(error))
            }
        }).resume()
    }
}
