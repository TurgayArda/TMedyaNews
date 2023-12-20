//
//  NewsDetailModel.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 19.12.2023.
//

import Foundation

// MARK: - NewsDetailResult
struct NewsDetailResult: Codable {
    let errorCode: Int?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let headerAd: ErAd?
    let newsDetail: NewsDetail?
    let footerAd: ErAd?
    let multimedia: Multimedia?
    let itemList: [Video]?
    let relatedNews: RelatedNews?
    let video: Video?
    let photoGallery: PhotoGallery?
}

// MARK: - ErAd
struct ErAd: Codable {
    let itemType, adUnit: String?
    let itemWidth, itemHeight: Int?
}

// MARK: - Video
struct Video: Codable {
    let itemID, title: String?
    let imageURL: String?
    let itemType: String?
    let titleVisible: Bool?
    let shortText, bodyText: String?
    let videoURL: String?
    
    enum CodingKeys: String, CodingKey {
        case itemID = "itemId"
        case title
        case imageURL = "imageUrl"
        case itemType, titleVisible, shortText, bodyText
        case videoURL = "videoUrl"
    }
}

// MARK: - Multimedia
struct Multimedia: Codable {
    let sectionType, repeatType: String?
    let itemCountInRow: Int?
    let lazyLoadingEnabled, titleVisible: Bool?
}

// MARK: - NewsDetail
struct NewsDetail: Codable {
    let resource, bodyText: String?
    let hasPhotoGallery, hasVideo: Bool?
    let publishDate: String?
    let fullPath: String?
    let shortText: String?
    let category: Category?
    let itemID, title, video: String?
    let imageURL: String?
    let itemType: String?
    
    enum CodingKeys: String, CodingKey {
        case resource, bodyText, hasPhotoGallery, hasVideo, publishDate, fullPath, shortText, category
        case itemID = "itemId"
        case title, video
        case imageURL = "imageUrl"
        case itemType
    }
}

// MARK: - PhotoGallery
struct PhotoGallery: Codable {
    let itemID, title: String?
    let imageURL: String?
    let itemType: String?
    let titleVisible: Bool?
    
    enum CodingKeys: String, CodingKey {
        case itemID = "itemId"
        case title
        case imageURL = "imageUrl"
        case itemType, titleVisible
    }
}

// MARK: - RelatedNews
struct RelatedNews: Codable {
    let hasPhotoGallery, hasVideo: Bool?
    let publishDate, shortText: String?
    let itemID, title: String?
    let imageURL: String?
    let itemType: String?
    let titleVisible: Bool?
    
    enum CodingKeys: String, CodingKey {
        case hasPhotoGallery, hasVideo, publishDate, shortText
        case itemID = "itemId"
        case title
        case imageURL = "imageUrl"
        case itemType, titleVisible
    }
}
