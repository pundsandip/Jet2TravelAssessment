//
//  DBManager.swift
//  Jet2TravelAssessment
//
//  Created by Sandip Pund on 02/10/20.
//  Copyright © 2020 Sandip Pund. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DBManager {
    
    // shared instance 
    static let shared = DBManager()
    private init() { }
    
    // save data to persitance store
     func saveArticlesToDB(articles: [ArticleModel]) {
        clearDeepObjectEntity("Article")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        for article in articles {
            let media = Media(context: context)
            media.image = article.media.first?.image ?? ""
            media.title = article.media.first?.title ?? ""
            media.url = article.media.first?.url ?? ""
            
            let user = User(context: context)
            user.avatar = article.user.first?.avatar ?? ""
            user.name = article.user.first?.name ?? ""
            user.lastName = article.user.first?.lastname ?? ""
            user.designation = article.user.first?.designation ?? ""
            
            let entity = Article(context: context)
            entity.id = article.id
            entity.createdAt = article.createdAt
            entity.content = article.content
            entity.likes = article.likes
            entity.comments = article.comments
            entity.media = media
            entity.user = user
        }
        // save
        appDelegate.saveContext()
    }
    
    // fetch data from persitance store
    func fetchArticlesFromDB(fetchOffSet: Int) -> [ArticleModel] {
        var articles: [ArticleModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        request.fetchLimit = 10
        request.fetchOffset = fetchOffSet
        do {
            let result = try context.fetch(request)
            for article in result as! [Article] {
                
                let id = article.id ?? ""
                let createdAt = article.createdAt ?? ""
                let content = article.content ?? ""
                
                let image = article.media?.image ?? ""
                let title = article.media?.title ?? ""
                let url = article.media?.url ?? ""
                let media = MediaModel(image: image, title: title, url: url)
                
                let avatar = article.user?.avatar ?? ""
                let name = article.user?.name ?? ""
                let lastName = article.user?.lastName ?? ""
                let designation = article.user?.designation ?? ""
                let user = UserModel(name: name, avatar: avatar, lastname: lastName, designation: designation)
                
                let articleModel = ArticleModel(id: id, createdAt: createdAt, content: content, comments: article.comments, likes: article.likes, media: [media], user:[ user])
                articles.append(articleModel)
            }
        } catch {
            print("Failed")
        }
        return articles
    }
    
    // clear all entities
    public func clearAllCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let entities = appDelegate.persistentContainer.managedObjectModel.entities
        entities.compactMap({ $0.name }).forEach(clearDeepObjectEntity)
    }
    
    // delete all records from the given entity 
    private func clearDeepObjectEntity(_ entity: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}
