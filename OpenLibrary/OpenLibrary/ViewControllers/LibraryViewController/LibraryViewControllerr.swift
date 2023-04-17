//
//  LibraryViewControllerr.swift
//  OpenLibrary
//
//  Created by mac on 16.04.23.
//

import UIKit

enum Identifier: String {
    case LibraryTableViewCell
}

class LibraryViewController: BaseViewController {
    
    var libraryVM: (LibraryProtocolIn & LibraryProtocolOut)?
    
    let searchBar = UISearchBar()
    var timer: Timer?
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 3
        return tableView
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.color = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        activityView.hidesWhenStopped = true
        activityView.startAnimating()
        return activityView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTableView()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        libraryVM?.getDataTrending()
    }
    
    private func setupTableView() {
        tableView.register(LibraryTableViewCell.self, forCellReuseIdentifier: Identifier.LibraryTableViewCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func addViews() {
        [activityView, tableView].forEach({
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false})
    }
    
    override func setupLayout() {
        view.addConstraints([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            activityView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    @objc private func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func configureUI() {
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Open Library"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        showSearchBarButton(shouldShow: true)
        
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    override func lisenViewModel() {
        guard var libraryVM = libraryVM else {
            return
        }
        
        libraryVM.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
            self?.activityView.stopAnimating()
        }
        
        libraryVM.showError = { [weak self] error in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.activityView.stopAnimating()
            self.showAlert(with: error.localizedDescription)
        }
    }
}

extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = BookViewController()
        if libraryVM?.typeBookArray == .work {
            vc.typeBook = BookArray.work
            vc.books = libraryVM?.booksTrending()[indexPath.row]
        } else {
            vc.typeBook = BookArray.info
            vc.booksInfo = libraryVM?.books()[indexPath.row]
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let libraryVM = libraryVM else { return 0 }
        return libraryVM.height(forRowAt: indexPath)
    }
}

extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let libraryVM = libraryVM else { return 0 }
        
        switch libraryVM.typeBookArray {
        case .work: return libraryVM.booksTrending().count
        case .info: return libraryVM.books().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.LibraryTableViewCell.rawValue) as? LibraryTableViewCell, let libraryVM = libraryVM else { return UITableViewCell() }
        cell.layer.borderColor = view.backgroundColor?.cgColor
        
        if libraryVM.typeBookArray == .work {
            cell.setupCell(with: libraryVM.booksTrending()[indexPath.row])
        } else {
            cell.setupCellInfo(with: libraryVM.books()[indexPath.row])
        }
        
        return cell
    }
}

extension LibraryViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        libraryVM?.booksArray.removeAll()
        tableView.reloadData()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.activityView.startAnimating()
            self.libraryVM?.getData(search: searchText)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        self.libraryVM?.booksArrayInfo.removeAll()
        self.tableView.reloadData()
        self.activityView.startAnimating()
        self.libraryVM?.getDataTrending()
        
    }
}



