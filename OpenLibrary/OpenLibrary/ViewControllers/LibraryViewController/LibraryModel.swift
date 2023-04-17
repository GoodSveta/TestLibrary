//
//  LibraryModel.swift
//  OpenLibrary
//
//  Created by mac on 15.04.23.
//

import Foundation


struct Library: Decodable {
    let query: String?
    let works: [Work]
    let days, hours: Int?
}

// MARK: - Work
struct Work: Decodable {
    let key, title: String?
    let editionCount: Int?
    let firstPublishYear: Int?
    let hasFulltext, publicScanB: Bool?
    let coverEditionKey: String?
    let coverI: Int?
    let language: [String]?
    let authorKey, authorName: [String]?
    let ia: [String]?
    let iaCollectionS, lendingEditionS, lendingIdentifierS: String?
    let ratingsAverage, ratingsSortable: Double?
    let availability: Availability?
    let subtitle: String?
    let subject: [String]?
    let publisher: [String]?

    enum CodingKeys: String, CodingKey {
        case key, title
        case editionCount = "edition_count"
        case firstPublishYear = "first_publish_year"
        case hasFulltext = "has_fulltext"
        case publicScanB = "public_scan_b"
        case coverEditionKey = "cover_edition_key"
        case coverI = "cover_i"
        case language
        case authorKey = "author_key"
        case authorName = "author_name"
        case ia
        case iaCollectionS = "ia_collection_s"
        case ratingsSortable
        case ratingsAverage = "ratings_average"
        case lendingEditionS = "lending_edition_s"
        case lendingIdentifierS = "lending_identifier_s"
        case subtitle, availability
        case subject
        case publisher
        
    }
}


struct Availability: Decodable {
    let status: String?
    let availableToBrowse, availableToBorrow, availableToWaitlist, isPrintdisabled: Bool?
    let isReadable, isLendable, isPreviewable: Bool?
    let identifier: String?
    let isbn: String?
    let oclc: String?
    let openlibraryWork, openlibraryEdition: String?
    let lastLoanDate: String?
    let numWaitlist: String?
    let lastWaitlistDate: String?
    let isRestricted, isBrowseable: Bool?
    let src: String?

    enum CodingKeys: String, CodingKey {
        case status
        case availableToBrowse = "available_to_browse"
        case availableToBorrow = "available_to_borrow"
        case availableToWaitlist = "available_to_waitlist"
        case isPrintdisabled = "is_printdisabled"
        case isReadable = "is_readable"
        case isLendable = "is_lendable"
        case isPreviewable = "is_previewable"
        case identifier, isbn, oclc
        case openlibraryWork = "openlibrary_work"
        case openlibraryEdition = "openlibrary_edition"
        case lastLoanDate = "last_loan_date"
        case numWaitlist = "num_waitlist"
        case lastWaitlistDate = "last_waitlist_date"
        case isRestricted = "is_restricted"
        case isBrowseable = "is_browseable"
        case src = "__src__"
    }
}

struct Books: Decodable {
    let object: [BookObject]
}

struct Info: Decodable {
    let title: String?
    let subtitle: String?
    let authorName: [String]?
    let firstPublishYear: Int?
    let coverI: Int?
    let publisher: [String]?
    let authorAlternativeName: [String]?
    let ratingsAverage, ratingsSortable: Double?
    let ratingsCount: Int?
    let language: [String]?
    let ia: [String]?
    let subject: [String]?

    enum CodingKeys: String, CodingKey {
        case title = "title_suggest"
        case subtitle
        case authorName = "author_name"
        case firstPublishYear = "first_publish_year"
        case coverI = "cover_i"
        case publisher
        case authorAlternativeName = "author_alternative_name"
        case ratingsSortable
        case ratingsAverage = "ratings_average"
        case language
        case ia
        case subject
        case ratingsCount
    }
}

struct BookObject: Decodable {
    let start: Int?
    let numFound: Int?
    let docs: [Info]

    enum CodingKeys: String, CodingKey {
        case start
        case numFound = "num_found"
        case docs
    }






}
