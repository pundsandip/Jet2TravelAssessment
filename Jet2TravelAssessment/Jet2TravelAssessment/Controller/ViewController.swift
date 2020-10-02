//
//  ViewController.swift
//  Jet2TravelAssessment
//
//  Created by Sandip Pund on 29/09/20.
//  Copyright © 2020 Sandip Pund. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var arrArticle: [ArticleViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib.init(nibName: "ArticleCell", bundle: Bundle.main), forCellReuseIdentifier: ArticleCell.identifier)
        ServiceManager.shared.getArticles { [weak self] response, error in
            guard let articles = response else {
                self?.isShowError(value: true)
                return
            }
            self?.isShowError(value: false)
            for article in articles {
                let viewModel = ArticleViewModel(article)
                self?.arrArticle.append(viewModel)
            }
            self?.tableView.reloadData()
        }
    }
    
    private func isShowError(value: Bool) {
        if value {
            self.tableView.isHidden = true
            self.lblError.isHidden = false
        } else {
            self.tableView.isHidden = false
            self.lblError.isHidden = true
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrArticle.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let articleImageUrl = self.arrArticle[indexPath.row].articleImageURL {
        // downlaod image with high priority and cache it
        ImageDownloadManager.shared.downloadImage(articleImageUrl, indexPath: indexPath) { (image, url, indexPathh, error) in
            if let indexPathNew = indexPathh, indexPathNew == indexPath {
                DispatchQueue.main.async {
                    (cell as! ArticleCell).imgArticle.image = image
                }
            }
          }
        }
        
        if let avtarImageUrl = self.arrArticle[indexPath.row].avatarURL {
        ImageDownloadManager.shared.downloadImage(avtarImageUrl, indexPath: indexPath) { (image, url, indexPathh, error) in
            if let indexPathNew = indexPathh, indexPathNew == indexPath {
                DispatchQueue.main.async {
                    (cell as! ArticleCell).imgAvtar.image = image
                }
            }
        }
            }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /* Reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
        if let articleImageUrl = self.arrArticle[indexPath.row].articleImageURL {
            ImageDownloadManager.shared.slowDownImageDownloadTaskfor(articleImageUrl)
        }
        if let avtarImageUrl = self.arrArticle[indexPath.row].avatarURL {
            ImageDownloadManager.shared.slowDownImageDownloadTaskfor(avtarImageUrl)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
        let articleViewModel = self.arrArticle[indexPath.row]
        cell.setData(viewModel: articleViewModel)
        return cell
    }
}

