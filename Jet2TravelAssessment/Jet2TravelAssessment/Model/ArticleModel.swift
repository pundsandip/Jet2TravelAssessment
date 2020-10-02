//
//  Article.swift
//  Jet2TravelAssessment
//
//  Created by Sandip Pund on 30/09/20.
//  Copyright © 2020 Sandip Pund. All rights reserved.
//

import Foundation

// MARK: - ArticleModel
struct ArticleModel: Codable {
    let id, createdAt, content: String
    let comments, likes: Int
    let media: [MediaModel]
    let user: [UserModel]
}

// MARK: - MediaModel
struct MediaModel: Codable {
    let id, blogID, createdAt: String
    let image: String
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case blogID = "blogId"
        case createdAt, image, title, url
    }
}

// MARK: - UserModel
struct UserModel: Codable {
    let id, blogID, createdAt, name: String
    let avatar: String
    let lastname, city, designation, about: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case blogID = "blogId"
        case createdAt, name, avatar, lastname, city, designation, about
    }
}
