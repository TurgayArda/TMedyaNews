//
//  NetworkConstant.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import Foundation

final class NetworkConstant {
    
    enum NewsListGenreNetwork: String {
        case main_url = "https://turkmedya.com.tr/"
        case path_url = "anasayfa.json"
        
        static func newsListGenreURL() -> String {
            return "\(main_url.rawValue)\(path_url.rawValue)"
        }
    }
    
    // https://turkmedya.com.tr/detay.json?id=975413
    
    // "https://turkmedya.com.tr/detay.json?id=975486"

    // https://turkmedya.com.tr/detay.json?id=975491
    
    enum NewsDetailGenreNetwork: String {
        case main_url = "https://turkmedya.com.tr/"
        case path_url = "detay.json"
        case id_url = "?id="
        
        static func newsDetailGenreURL(id: String) -> String {
            return "\(main_url.rawValue)\(path_url.rawValue)\(id_url.rawValue)\(id)"
        }
    }
}
