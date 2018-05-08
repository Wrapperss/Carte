//
//  CommentAPI.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

enum CommentAPI {
    case newComment(Comment)
    case goodsComment(Int)
}

extension CommentAPI: TargetType {
    var path: String {
        switch self {
        case .newComment:
            return "api/comment"
        case .goodsComment(let goodsId):
            return "api/goods/comment/\(goodsId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .newComment:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .newComment(let comment):
            return comment.toDictionary()
        default:
            return nil
        }
    }
}


extension CommentAPI {
    static func postNewCommnet(_ comment: Comment) -> Promise<BlankResponse> {
        return Request<CommentAPI>().request(.newComment(comment))
    }
    
    static func fetchGoddsComment(_ goodsId: Int) -> Promise<[Comment]> {
        return Request<CommentAPI>().requestList(.goodsComment(goodsId))
    }
}
