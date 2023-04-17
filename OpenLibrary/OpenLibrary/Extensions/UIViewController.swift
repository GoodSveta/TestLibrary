//
//  UIViewController + UIWindow.swift
//  OpenLibrary
//
//  Created by mac on 16.04.23.
//

import UIKit

extension UIViewController {
    func showAlert(with messageError: String) {
        let alert = UIAlertController(title: nil, message: messageError, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}


