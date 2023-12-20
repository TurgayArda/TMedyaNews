//
//  NewsScreensConstant.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import Foundation

final class NewsScreensConstant {
    enum NewsVideo: String {
        case path_url = "https://turkmedya-live.ercdn.net/tv24/tv24.m3u8"
        
        static func videoURL() -> String {
            return "\(path_url.rawValue)"
        }
    }
    
    enum UIConstant: String {
        case title = "TMedyaNews"
    }
}
