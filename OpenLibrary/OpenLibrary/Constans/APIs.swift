//
//  APIs.swift
//  OpenLibrary
//
//  Created by mac on 16.04.23.
//

import Foundation


enum APILibrary: String {
    case host = "https://openlibrary.org/search.json?q=%@&"
    case hostTWO = "https://openlibrary.org/trending/now.json"
    
    var url: URL? {
        return URL(string: APILibrary.host.rawValue + self.rawValue)
    }
    
    func getURL(with nameBook: String) -> URL? {
        let string = APILibrary.host.rawValue
        let completedString = String(format: string, nameBook)
        print(completedString)
        return URL(string: completedString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
    func getURLTrending() -> URL? {
        let string = APILibrary.hostTWO.rawValue
        let completedString = String(format: string)
        return URL(string: completedString)
    }
}
