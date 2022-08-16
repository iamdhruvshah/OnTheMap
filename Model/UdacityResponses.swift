//
//  UdacityResponses.swift
//  OnTheMap
//
//  Created by Dhruv Shah on 31/03/22.
//

import Foundation

//MARK: Structures for the Responses Received from Udactiy API
struct PostSessionResponse: Codable {
    let account: AccountInformation
    let session: SessionInformation
}

struct ErrorInPostResponse: Codable, Error {
    let status: Int
    let error: String
    
    var localizedDescription: String { return self.error}
}

struct DeleteSessionResponse: Codable {
    let session: SessionInformation
}

struct GetUserInformationResponse: Codable {
    let firstName: String
    let lastName: String
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname
    }
}


//MARK: Nested Structures
struct AccountInformation: Codable {
    let registered: Bool
    let key: String
}

struct SessionInformation: Codable {
    let id: String
    let expiration: String
}


