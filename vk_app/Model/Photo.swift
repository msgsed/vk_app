//
//  Photo.swift
//  vk_app
//
//  Created by Sergey Dmitriev on 04.06.2021.
//

import Foundation
import UIKit
import RealmSwift

class PhotoResponse: Decodable{
    var list: [PhotoApi]
}

class PhotoApi: Object, Decodable {
    @objc dynamic var albumId = 0
    @objc dynamic var id = 0
    @objc dynamic var ownerId = 0
    @objc dynamic var photo = ""
    @objc dynamic var text = ""
    
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case id
        case ownerId
        case photo = "photo_604"
        case text
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.albumId = try values.decode(Int.self, forKey: .albumId)
        self.id = try values.decode(Int.self, forKey: .id)
        self.ownerId = try values.decode(Int.self, forKey: .ownerId)
        self.photo = try values.decode(String.self, forKey: .photo)
        self.text = try values.decode(String.self, forKey: .text)
    }
}


