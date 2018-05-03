//
//  DataPrepareService.swift
//  creams
//
//  Created by Rawlings on 15/01/2018.
//  Copyright © 2018 creams.io. All rights reserved.
//

import Foundation

struct DataPrepareService {
    struct Image {}
}


// MARK: - Image

extension DataPrepareService.Image {
    
    static func completeUrl(_ url: String) -> String {
        let head = "/public/image/"
        guard url.hasPrefix(head) else {
            return "\(Constants.APIKey.serverURL)\(head)\(url)"
        }
        return "\(Constants.APIKey.serverURL)\(url)"
    }
    
}

extension String {
    var imageUrl: URL {
        let urlStr = DataPrepareService.Image.completeUrl(self)
        return URL(string: urlStr)!
    }
    
    func imageURL() -> URL {
        return imageUrl
    }
}



