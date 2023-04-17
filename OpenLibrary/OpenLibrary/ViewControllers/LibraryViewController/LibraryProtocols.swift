//
//  LibraryProtocols.swift
//  OpenLibrary
//
//  Created by mac on 15.04.23.
//

import UIKit

protocol LibraryProtocolIn {
    func getData(search: String)
    func getDataTrending()
    func height(forRowAt indexPath: IndexPath) -> CGFloat
}


protocol LibraryProtocolOut {
    var booksArrayInfo: [Info] { get set }
    var booksArray: [Work] { get set }
    var reloadTableView: () -> Void { get set }
    var showError: (Error) -> Void { get set }
    func booksTrending() -> [Work]
    func books() -> [Info]
    var typeBookArray: BookArray { get set }
}
