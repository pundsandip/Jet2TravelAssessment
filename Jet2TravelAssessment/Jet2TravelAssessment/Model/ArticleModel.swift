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
    let comments, likes: Int64
    let media: [MediaModel]
    let user: [UserModel]
}

// MARK: - MediaModel
struct MediaModel: Codable {
    let image: String
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case image, title, url
    }
}

// MARK: - UserModel
struct UserModel: Codable {
    let name, avatar, lastname, designation: String
    enum CodingKeys: String, CodingKey {
        case name, avatar, lastname, designation
    }
}
