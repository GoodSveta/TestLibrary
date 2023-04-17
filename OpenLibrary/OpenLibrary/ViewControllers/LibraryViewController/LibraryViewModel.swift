//
//  LibraryViewModel.swift
//  OpenLibrary
//
//  Created by mac on 15.04.23.
//

import UIKit

enum BookArray {
    case work
    case info
}

final class LibraryViewModel: LibraryProtocolIn, LibraryProtocolOut {
    
    var showError: (Error) -> Void = { _ in }
    var reloadTableView: () -> Void = {}
    var booksArray: [Work] = []
    var booksArrayInfo: [Info] = []
    var typeBookArray: BookArray = .work
    var timer: Timer?
    var controlGetMetod: Int?
    
    func height(forRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func getDataTrending() {
        NetworkServiceManager.shared.getJsonTrending(completion: {[weak self] result in
            self?.typeBookArray = .work
            switch result {
            case .success(let newsJSON):
                self?.booksArray = newsJSON.works
                DispatchQueue.main.async {
                    self?.reloadTableView()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError(error)
                }
            }
        })
    }
    
    func getData(search: String) {
        NetworkServiceManager.shared.getJson(with: search , completion: { [weak self] result in
            self?.typeBookArray = .info
            switch result {
            case .success(let newsJSON):
                self?.booksArrayInfo = newsJSON.docs
                DispatchQueue.main.async {
                    self?.reloadTableView()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError(error)
                }
            }
        })
    }
    
    func booksTrending() -> [Work] {
        return booksArray
    }
    
    func books() -> [Info] {
        return booksArrayInfo
    }
}
