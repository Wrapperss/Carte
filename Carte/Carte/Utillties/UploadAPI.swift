//
//  UploadAPI.swift
//  creams
//
//  Created by Jahov on 24/10/2017.
//  Copyright © 2017 creams.io. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya
import Result
import UPYUN
import Unbox

public struct UpyunImage {
    
    let imageWidth: Double
    let imageHeight: Double
    let url: String
}

struct UploadSignature: Unboxable {
    
    let policy: String
    let signature: String
    let expiresIn: Int
    
    init(unboxer: Unboxer) throws {
        policy = try unboxer.unbox(key: "policy")
        signature = try unboxer.unbox(key: "signature")
        expiresIn = try unboxer.unbox(key: "expiresIn")
    }
}


enum UploadAPI {
    case fetchUploadSignature
    
}

extension UploadAPI: RequestTargetType {
    
    var baseURL: URL {
        return URL(string: Constants.APIKey.serverURL)!
    }
    
    var path: String {
        switch self {
        case .fetchUploadSignature:
            return "commons/upload/signature"
        }
    }
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var shouldAuthorize: Bool {
        switch self {
        default:
            return true
        }
    }
    
}


extension UploadAPI {
    public static func uploadImages(images: [UIImage], complete: @escaping ([UpyunImage]) -> Void, fail: @escaping (String) -> Void){
        HUD.wait(info: "图片上传中...")
        let uploadProvider = Request<UploadAPI>()
        var uploadImages: [UpyunImage] = []
        uploadProvider.request(.fetchUploadSignature) { result -> Void in
            HUD.clear()
            switch result {
            case let .success(response):
                do {
                    guard let json = try response.mapJSON() as? UnboxableDictionary else {
                        fail("获取上传签名失败")
                        return
                    }
                    let signature: UploadSignature = try Unbox.unbox(dictionary: json)
                    for image in images {
                        UploadAPI.uploadImage(signatureModel: signature, image: image, complete: { (upyunImage) in
                            uploadImages.append(upyunImage)
                            if uploadImages.count == images.count {
                                complete(uploadImages)
                            }
                        }, fail: { (error) in
                            fail("上传失败")
                        })
                    }
                } catch {
                    fail("上传失败")
                }
            case .failure(_):
                fail("获取上传签名失败")
            }
        }
        
    }
    
    
    private static func uploadImage(signatureModel: UploadSignature, image: UIImage, complete: @escaping (UpyunImage) -> Void, fail: @escaping (Error?) -> Void) {
        UPYUNConfig.sharedInstance().default_BUCKET = "creams"
        let up = UpYun()
        up.uploadMethod = .formUpload
        up.policyBlocker = {
            return signatureModel.policy
        }
        up.signatureBlocker = { signature -> String in
            return signatureModel.signature
        }
        up.successBlocker = {response, responseData in
            let responseDictionary = responseData as! [String:Any]
            let fullUrl = (responseDictionary["url"] as! String)
            let image = UpyunImage(imageWidth: responseDictionary["image-width"] as! Double, imageHeight: responseDictionary["image-height"] as! Double, url: fullUrl)
            complete(image)
        }
        up.failBlocker = {error in
            fail(error)
        }
        let dateString = "\(Date().fullString())/%.0f"
        up.uploadFile(UIImageJPEGRepresentation(image, 0.3), saveKey: "/\(dateString).jpg")
    }
}

