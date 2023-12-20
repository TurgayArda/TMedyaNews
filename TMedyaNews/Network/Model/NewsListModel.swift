//
//  NewsListModel.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import Foundation

// MARK: - ItemListResult
struct ItemListResult: Codable {
    let errorCode: Int?
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let sectionType, repeatType: String?
    let itemCountInRow: Int?
    let lazyLoadingEnabled, titleVisible: Bool?
    let title: String?
    let titleBgColor, sectionBgColor: String?
    let itemList: [ItemList]?
    let totalRecords: Int?
}

// MARK: - ItemList
struct ItemList: Codable {
    let hasPhotoGallery, hasVideo, titleVisible: Bool?
    let fLike: ColumnistName?
    let publishDate, shortText: String?
    let fullPath: String?
    let category: Category?
    let videoURL: ColumnistName?
    let externalURL: String?
    let columnistName: ColumnistName?
    let itemID, title: String?
    let imageURL: String?
    let itemType: ItemType?
    
    enum CodingKeys: String, CodingKey {
        case hasPhotoGallery, hasVideo, titleVisible, fLike, publishDate, shortText, fullPath, category
        case videoURL = "videoUrl"
        case externalURL = "externalUrl"
        case columnistName
        case itemID = "itemId"
        case title
        case imageURL = "imageUrl"
        case itemType
    }
}

// MARK: - Category
struct Category: Codable {
    let categoryID, title, slug: String?
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case title, slug
    }
}

enum ColumnistName: String, Codable {
    case columnistName = "\""
    case empty = ""
}

enum ItemType: String, Codable {
    case externalContent = "EXTERNAL_CONTENT"
    case news = "NEWS"
    case photoGallery = "PHOTO_GALLERY"
}
