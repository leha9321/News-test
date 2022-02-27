//
//  DetailViewController.swift
//  News
//
//  Created by Алексей Трофимов on 06.02.2022.
//

import UIKit


class DetailViewController: UIViewController {
    
    @IBOutlet var sourceNameLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var publishedAtLabel: UILabel!
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var urlButton: UIButton!
    
    var articles: Article!
    var numberOfViews = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        
        sourceNameLabel.text = "Source: \(articles.source.name)"
        authorLabel.text = "Author:  \(articles.author ?? "")"
        titleLabel.text = articles.title
        contentLabel.text = articles.content
        publishedAtLabel.text = "Date:  \(articles.publishedAt)"
        
        fetchImage()
        saveNumber()
    }
    
    func saveNumber (){
        if let number = UserDefaults.standard.value(forKey: "\(articles.author)"){
            numberOfViews = number as! Int
        }
        UserDefaults.standard.set( (numberOfViews + 1), forKey: "\(articles.author)")
    }
    
    func fetchImage(){
        DispatchQueue.global().async {
            guard let stringURL = self.articles.urlToImage else {return}
            guard let imageURL = URL(string: stringURL) else {return}
            guard let imageData = try? Data(contentsOf: imageURL) else {return}
            DispatchQueue.main.async {
                self.newsImage.image = UIImage(data: imageData)
                self.indicator.stopAnimating()
            }
        }
    }
    
    @IBAction func urlTapButton(_ sender: Any) {
        if let url = URL(string: articles.url ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
