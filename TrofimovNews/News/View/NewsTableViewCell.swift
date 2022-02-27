//
//  NewsTableViewCell.swift
//  News
//
//  Created by Алексей Трофимов on 05.02.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet var imageNews: UIImageView!
    @IBOutlet var titleNewsLabel: UILabel!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var numderOfViews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
    }
    
    func configure(with attributes: Article){
        titleNewsLabel.text = attributes.title
        DispatchQueue.global().async {
            guard let stringURL = attributes.urlToImage else {return}
            guard let imageURL = URL(string: stringURL) else {return}
            guard let imageData = try? Data(contentsOf: imageURL) else {return}
            DispatchQueue.main.async {
                self.imageNews.image = UIImage(data: imageData)
                self.indicator.stopAnimating()
                if let number = UserDefaults.standard.value(forKey: "\(attributes.author)"){
                self.numderOfViews.text = "view: \(number)"
                    
                } else {
                    self.numderOfViews.text = "view: 0"
                }
            }
        }
    }
}



