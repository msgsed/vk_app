//
//  User.swift
//  3l_DmitrievSergey
//
//  Created by Sergey Dmitriev on 11.04.2021.
//

import Foundation
import UIKit
import RealmSwift

struct User {
    var name: String
    var type: String
    var avatar: UIImage?
    var fotoArray = [UIImage]()
}

class UserApiResponse: Decodable {
    let list: [UserApi]
}

class UserApi: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var isClosed = false
    @objc dynamic var canAccessClosed = false
    @objc dynamic var domain = ""
    @objc dynamic var cityID = 0
    @objc dynamic var cityTitle = ""
    @objc dynamic var online = 0
    @objc dynamic var trackCode = ""

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case domain
        case city
        case online
        case trackCode = "track_code"
    }
    
    enum CityKeys: String, CodingKey {
        case cityID = "id"
        case cityTitle = "title"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.lastName = try values.decode(String.self, forKey: .lastName)
        self.isClosed = try values.decode(Bool.self, forKey: .isClosed)
        self.canAccessClosed = try values.decode(Bool.self, forKey: .canAccessClosed)
        self.domain = try values.decode(String.self, forKey: .domain)
        let cityValues = try values.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
        self.cityID = try cityValues.decode(Int.self, forKey: .cityID)
        self.cityTitle = try cityValues.decode(String.self, forKey: .cityTitle)
        self.online = try values.decode(Int.self, forKey: .online)
        self.trackCode = try values.decode(String.self, forKey: .trackCode)
    }
}
