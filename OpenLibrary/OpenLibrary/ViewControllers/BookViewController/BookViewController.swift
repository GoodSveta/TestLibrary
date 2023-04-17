//
//  BookViewController.swift
//  OpenLibrary
//
//  Created by mac on 17.04.23.
//

import UIKit

class BookViewController: BaseViewController {
    var books: Work?
    var booksInfo: Info?
    var typeBook: BookArray?
    
    let viewSecond: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1510096192, green: 0.1431435645, blue: 0.2380613387, alpha: 0.9341944006)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 18)
        return label
    }()
    
    private var imageBook: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let ratingsAverage: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 18)
        return label
    }()
    
    private let labelAuthor: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelDate: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelRating: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Rating"
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let rating: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelLanguage: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Language: "
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let language: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelSubject: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Subject: "
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let subject: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelPublisher: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Publisher: "
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let publisher: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInfo()
    }
    
    private func showInfo() {
        if typeBook == .info {
            labelTitle.text = booksInfo?.title
            labelDate.text = "\(booksInfo?.firstPublishYear ?? 0)"
            labelAuthor.text = booksInfo?.authorName?.first
            subject.text = booksInfo?.subject?.first
            rating.text = "\(booksInfo?.ratingsAverage ?? 0.0)"
            publisher.text = booksInfo?.publisher?.first
            language.text = booksInfo?.language?.first
            getImage(with: booksInfo?.coverI)
        } else {
            labelTitle.text = books?.title
            labelDate.text = "\(books?.firstPublishYear ?? 0)"
            labelAuthor.text = books?.authorName?.first
            subject.text = books?.subject?.first
            rating.text = "\(books?.ratingsAverage ?? 0.0)"
            publisher.text = books?.publisher?.first
            language.text = books?.language?.first
            getImage(with: books?.coverI)
        }
    }
    
    private func getImage(with coverI: Int?) {
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
    
    override func addViews() {
        [labelTitle, ratingsAverage, imageBook, labelAuthor, viewSecond].forEach({
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        [labelRating, rating, labelLanguage, language, labelDate, labelSubject, subject, labelPublisher, publisher].forEach({
            viewSecond.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    override func setupLayout() {
        view.addConstraints([
            labelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageBook.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
            imageBook.centerXAnchor.constraint(equalTo: labelTitle.centerXAnchor, constant: 0),
            
            viewSecond.topAnchor.constraint(equalTo: labelAuthor.bottomAnchor, constant: 5),
            viewSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            viewSecond.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            viewSecond.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            labelAuthor.topAnchor.constraint(equalTo: imageBook.bottomAnchor, constant: 30),
            labelAuthor.leadingAnchor.constraint(equalTo: viewSecond.leadingAnchor, constant: 5),
            
            labelDate.topAnchor.constraint(equalTo: viewSecond.topAnchor, constant: 5),
            labelDate.leadingAnchor.constraint(equalTo: viewSecond.leadingAnchor, constant: 10),
            
            
            labelRating.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 10),
            labelRating.leadingAnchor.constraint(equalTo: labelDate.leadingAnchor, constant: 10),
            
            rating.leadingAnchor.constraint(equalTo: labelRating.trailingAnchor, constant: 5),
            rating.topAnchor.constraint(equalTo: labelRating.topAnchor, constant: 0),
            
            labelLanguage.leadingAnchor.constraint(equalTo: labelRating.leadingAnchor, constant: 0),
            labelLanguage.topAnchor.constraint(equalTo: labelRating.bottomAnchor, constant: 7),
            
            language.leadingAnchor.constraint(equalTo: labelLanguage.trailingAnchor, constant: 5),
            language.topAnchor.constraint(equalTo: labelLanguage.topAnchor, constant: 0),
            
            labelSubject.leadingAnchor.constraint(equalTo: labelLanguage.leadingAnchor, constant: 0),
            labelSubject.topAnchor.constraint(equalTo: labelLanguage.bottomAnchor, constant: 7),
            
            subject.leadingAnchor.constraint(equalTo: labelSubject.trailingAnchor, constant: 5),
            subject.topAnchor.constraint(equalTo: labelSubject.topAnchor, constant: 0),
            
            labelPublisher.leadingAnchor.constraint(equalTo: labelSubject.leadingAnchor, constant: 0),
            labelPublisher.topAnchor.constraint(equalTo: labelSubject.bottomAnchor, constant: 7),
            
            publisher.leadingAnchor.constraint(equalTo: labelPublisher.trailingAnchor, constant: 5),
            publisher.topAnchor.constraint(equalTo: labelPublisher.topAnchor, constant: 0)
            
        ])
    }
}



