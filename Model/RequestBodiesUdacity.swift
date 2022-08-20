//
//  RequestBodiesUdacity.swift
//  OnTheMap
//
//  Created by Dhruv Shah on 29/03/22.
//

import Foundation

//MARK: Body
struct LogInStruct: Codable {
    var udacity: Udacity
}

struct Udacity: Codable {
    var username: String
    var password: String
}

//MARK: New Locations
struct StudentLocation: Codable {
    var objectId: String?
    var firstName: String?
    var lastName: String?
    var uniqueKey: String?
    var latitude: Double?
    var longitude: Double?
    var medialURL: String?
    var mapString: String?
    var createdAt: String?
    var updatedAt: String?
}

