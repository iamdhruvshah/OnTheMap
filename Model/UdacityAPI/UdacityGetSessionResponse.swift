//
//  UdacityGetSessionResponse.swift
//  OnTheMap
//
//  Created by Dhruv Shah on 01/04/22.
//

import Foundation

struct UdacityGetUserResponse: Codable {
    
    let firstName: String?
    let lastName: String?
    let nickname: String?
    let imageURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname
        case imageURL = "_image_url"
    }

}
