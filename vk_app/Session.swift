//
//  Session.swift
//  vk_app
//
//  Created by Sergey Dmitriev on 28.05.2021.
//

//a. token: String – для хранения токена в VK,
//b. userId: Int – для хранения идентификатора пользователя ВК.


import Foundation

final class Session {
    private init () {}
    
    static let shared = Session()
    
    var token: String = ""
    var userId: Int = 0
}
