//
//  ModelUser.swift
//  OnTheMap
//
//  Created by Dhruv Shah on 29/03/22.
//

import Foundation

//MARK: User Details
struct UserSession {
    static var userId: String = ""
    static var firstName: String = ""
    static var lastName: String = ""
    static var nickname: String = ""
}

//MARK: Locations
struct MapPins {
    static var mapPins = [LocationResults]()
}
