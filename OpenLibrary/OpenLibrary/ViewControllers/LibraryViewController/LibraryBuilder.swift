//
//  LibraryBuilder.swift
//  OpenLibrary
//
//  Created by mac on 15.04.23.
//

import UIKit

final class Builder {
    static func build() -> UIViewController {
        let libraryVM = LibraryViewModel()
        let libraryVC = LibraryViewController()
        libraryVC.libraryVM = libraryVM
        
        return libraryVC
    }
}
