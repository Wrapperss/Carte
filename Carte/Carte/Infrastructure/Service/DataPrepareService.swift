//
//  DataPrepareService.swift
//  creams
//
//  Created by Rawlings on 15/01/2018.
//  Copyright © 2018 creams.io. All rights reserved.
//

import Foundation


/// Model Fat Layer

struct DataPrepareService {
    struct Image {}
    struct ListSection {}
    struct ModelMatching {}
}


// MARK: - Image

extension DataPrepareService.Image {
    
    static func completeUrl(_ url: String) -> String {
        var new = url
        let head = "http"
        guard new.hasPrefix(head) else {
            new.append("")
            return new
        }
        return new
    }
    
}

//extension String {
//    var imageUrl: URL {
//        let urlStr = DataPrepareService.Image.completeUrl(self)
//        return URL(string: urlStr) ?? URL(string: Constants.APIKey.upyunRootURL)!
//    }
//    
//    func imageURL() -> URL {
//        return imageUrl
//    }
//}

// MARK: - ListSection

extension DataPrepareService.ListSection {
    
}
