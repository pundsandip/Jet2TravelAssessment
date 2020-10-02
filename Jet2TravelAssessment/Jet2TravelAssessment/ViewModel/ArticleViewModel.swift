//
//  ArticleViewModel.swift
//  Jet2TravelAssessment
//
//  Created by Sandip Pund on 01/10/20.
//  Copyright © 2020 Sandip Pund. All rights reserved.
//

import Foundation
class ArticleViewModel {
    
    var article: ArticleModel!
    
    var fullName: String? {
        guard let user = article.user.first else {
            return nil
        }
        return "\(user.name) \(user.lastname)"
    }
    
    var designation: String? {
        guard let user = article.user.first else {
            return nil
        }
        return user.designation
    }
    
    var avatarURL: String? {
        guard let user = article.user.first else {
            return nil
        }
        return user.avatar
    }
    
    var likes: String {
        return "\(article.likes.shorted()) Likes"
    }
    
    var coments: String {
        return "\(article.comments.shorted()) Comments"
    }
    
    var articleImageURL: String? {
        guard let media = article.media.first else { return nil }
        if media.image.isEmpty {
            return nil
        }
        return media.image
    }
    
    var articleContent: String {
        return article.content
    }
    
    var articleTitle: String? {
        return article.media.first?.title
    }
    
    var articleURL: String? {
        return article.media.first?.url
    }
    
    var duration: String? {
        guard let dateString = article.createdAt.components(separatedBy: ".").first else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let currDateString = dateFormatter.string(from: Date())
        guard let timeDate = dateFormatter.date(from: dateString), let currentDate = dateFormatter.date(from: currDateString) else {
            return nil
        }
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        let days = (timeInterval / 86400).rounded()
        let hours = ((timeInterval.truncatingRemainder(dividingBy: 86400)) / 3600).rounded()
        let minutes = ((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60).rounded()
        let seconds = ((timeInterval.truncatingRemainder(dividingBy: 3600)).truncatingRemainder(dividingBy: 60)).rounded()
        if days > 0 {
            return "\(days) d".replacingOccurrences(of: ".0", with: "")
        } else if hours > 0 {
            return "\(hours) hr".replacingOccurrences(of: ".0", with: "")
        } else if minutes > 0 {
            return "\(minutes) min".replacingOccurrences(of: ".0", with: "")
        } else if seconds > 0 {
            return "\(seconds) sec".replacingOccurrences(of: ".0", with: "")
        }
        return nil
    }
    
    init(_ model: ArticleModel) {
        article = model
    }
    
    
}
