//
//  AddressApi.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/6.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

enum AddressAPI {
    case userAddress(Int)
    case addAddress(Address)
    case removeAddress(Int)
    case updateAddress(Int, Address)
}

extension AddressAPI: TargetType {
    var path: String {
        switch self {
        case .userAddress(let userId):
            return "api/user/address/\(userId)"
        case .addAddress:
            return "api/address"
        case .removeAddress(let addressId):
            return "api/address/\(addressId)"
        case .updateAddress(let addressId, _):
            return "api/address/\(addressId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addAddress:
            return .post
        case .removeAddress:
            return .delete
        case .updateAddress:
            return .put
        default:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .addAddress(let address):
            return address.toDictionary()
        case .updateAddress(_, let address):
            return address.toDictionary()
        default:
            return nil
        }
    }
}

extension AddressAPI {
    static func fetchUserAddress(userId: Int) -> Promise<[Address]> {
        return Request<AddressAPI>().requestList(.userAddress(userId))
    }
    
    static func postAddress(address: Address) -> Promise<BlankResponse> {
        return Request<AddressAPI>().request(.addAddress(address))
    }
    
    static func deleteAddress(addressId: Int) -> Promise<BlankResponse> {
        return Request<AddressAPI>().request(.removeAddress(addressId))
    }
    
    static func updataUserAddres(addressId: Int, address: Address) -> Promise<BlankResponse> {
        return Request<AddressAPI>().request(.updateAddress(addressId, address))
    }
}
