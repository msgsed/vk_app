//
//  Group.swift
//  3l_DmitrievSergey
//
//  Created by Sergey Dmitriev on 11.04.2021.
//

import Foundation
import UIKit
import RealmSwift

struct Group {
    var id: Int
    var name: String    
    var avatar: UIImage?
}

class GroupResponse: Decodable {
    var list: [GroupApi]
}

class GroupApi: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var adminLevel = 0
    @objc dynamic var isAdmin = 0
    @objc dynamic var name = ""
    @objc dynamic var type = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case adminLevel = "admin_level"
        case isAdmin = "is_admin"
        case name
        case type
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.adminLevel = try values.decode(Int.self, forKey: .adminLevel)
        self.isAdmin = try values.decode(Int.self, forKey: .isAdmin)
        self.name = try values.decode(String.self, forKey: .name)
        self.type = try values.decode(String.self, forKey: .type)
    }
}
