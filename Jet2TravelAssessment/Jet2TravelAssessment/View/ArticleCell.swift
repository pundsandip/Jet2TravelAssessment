//
//  ArticleCell.swift
//  Jet2TravelAssessment
//
//  Created by Sandip Pund on 01/10/20.
//  Copyright © 2020 Sandip Pund. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    static let identifier = "cellId"
    @IBOutlet weak var imgAvtar: UIImageView!
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var imgArticle: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgAvtar.layer.cornerRadius = 40
    }
    
     func setData(viewModel: ArticleViewModel) {
        if let _ = viewModel.articleImageURL {
            imgHeightConstraint.constant = 150
        } else {
            imgHeightConstraint.constant = 0
        }
        if let designation = viewModel.designation {
            lblDesignation.text = designation
        }
        if let name = viewModel.fullName {
            lblName.text = name
        }
        lblContent.text = viewModel.articleContent
        
        if let title = viewModel.articleTitle {
            lblTitle.text = title
        }
        if let url = viewModel.articleURL {
            lblUrl.text = url
        }
        if let duration = viewModel.duration {
            lblDuration.text = duration
        }
        lblLikes.text = viewModel.likes
        lblComments.text = viewModel.coments
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Clean up
        self.imgArticle.image = nil
        self.imgAvtar.image = nil
        self.lblTitle.text = nil
        self.lblUrl.text = nil
        
    }
    
}
