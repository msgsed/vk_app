//
//  Session.swift
//  vk_app
//
//  Created by Sergey Dmitriev on 28.05.2021.
//

//a. token: String – для хранения токена в VK,
//b. userId: Int – для хранения идентификатора пользователя ВК.


import Foundation
import RealmSwift

final class Session {
    private init () {}
    
    static let shared = Session()
    
    var token: String = ""
    var userId: Int = 0
    
    func saveUserApiData(_ userApiData: [UserApi]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(userApiData)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func saveGroupApiData(_ groupApiData: [GroupApi]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(groupApiData)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func savePhotoApiData(_ photoApiData: [PhotoApi]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photoApiData)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
