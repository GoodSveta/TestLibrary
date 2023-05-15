//
//  BaseViewController.swift
//  OpenLibrary
//
//  Created by mac on 15.04.23.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //иаипиаиаи
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addViews()
        setupLayout()
        lisenViewModel()
    }
    
    func addViews() {}
    func setupLayout() {}
    func lisenViewModel() {}
    
}
