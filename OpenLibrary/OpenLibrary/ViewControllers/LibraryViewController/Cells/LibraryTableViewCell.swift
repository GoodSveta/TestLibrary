//
//  LibraryTableViewCell.swift
//  OpenLibrary
//
//  Created by mac on 15.04.23.
//

import UIKit

final class LibraryTableViewCell: UITableViewCell {
    
    private var nameBook: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Thonburi", size: 13)
        label.textColor = #colorLiteral(red: 0.1753442883, green: 0.1753442883, blue: 0.1753442883, alpha: 1)
        return label
    }()
    
    private var authorName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Thonburi", size: 13)
        label.textColor = #colorLiteral(red: 0.1753442883, green: 0.1753442883, blue: 0.1753442883, alpha: 1)
        return label
    }()
    
    private var firstPublishYear: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Thonburi", size: 13)
        label.textColor = #colorLiteral(red: 0.1753442883, green: 0.1753442883, blue: 0.1753442883, alpha: 1)
        return label
    }()
    
    private let imageBook: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageBook.image = nil
        nameBook.text = nil
        authorName.text = nil
        firstPublishYear.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [nameBook, authorName, firstPublishYear, imageBook].forEach({ contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false })
        
        setupLayout()
        setupStyle()
    }
    
    private func setupLayout() {
        contentView.addConstraints([
            imageBook.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageBook.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageBook.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageBook.widthAnchor.constraint(equalToConstant: 60),
            
            nameBook.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameBook.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 20),
            
            authorName.topAnchor.constraint(equalTo: nameBook.bottomAnchor, constant: 7),
            authorName.centerXAnchor.constraint(equalTo: nameBook.centerXAnchor, constant: 0),
            
            firstPublishYear.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            firstPublishYear.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupStyle() {
        contentView.backgroundColor = #colorLiteral(red: 0.8531414866, green: 0.8879327178, blue: 0.8480971456, alpha: 0.9696157089)
        contentView.layer.borderWidth = 3
    }
    
    func setupCell(with library: Work) {
        nameBook.text = library.title
        authorName.text = library.authorName?.first
        firstPublishYear.text = "\(library.firstPublishYear ?? 0)"
        
        getImage(with: library.coverI)
        
    }
    
    func setupCellInfo(with library: Info) {
        nameBook.text = library.title
        authorName.text = library.authorName?.first
        firstPublishYear.text = "\(library.firstPublishYear ?? 0)"
        
        getImage(with: library.coverI)
    }
    
    func getImage(with coverI: Int?) {
        let url = "https://covers.openlibrary.org/b/id/" + "\(coverI ?? 0)" + "-M.jpg"
        if let imageURL = URL(string: url) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.imageBook.image = image
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

