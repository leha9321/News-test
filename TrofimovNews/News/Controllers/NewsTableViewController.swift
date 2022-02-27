//
//  NewsTableViewController.swift
//  News
//
//  Created by Алексей Трофимов on 05.02.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var articles: [Article?] = []
    let urlString = "https://newsapi.org/v2/everything?q=Apple&from=2022-02-06&sortBy=popularity&apiKey=19d1de2b28ea4c4085c92622e913b214"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UIScreen.main.bounds.height / 4
        NetworkManager.shared.fetchData(from: urlString) { news in
            DispatchQueue.main.async {
                self.articles = news
                self.tableView.reloadData()
            }
        }
        refreshNews()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "go", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        if let articles = articles[indexPath.row] {
            cell.configure(with: articles)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let articles = articles[indexPath.row]
        let detailVC = segue.destination as! DetailViewController
        detailVC.articles = articles
    }
    
    // MARK: - Refresh Data
    
    func refreshNews(){
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "refresh")
        refreshControl?.addTarget(self, action: #selector(updateNews), for: .valueChanged)
        tableView.addSubview(refreshControl ?? UIRefreshControl())
    }
    
    @objc func updateNews(){
        NetworkManager.shared.fetchData(from: urlString) { news in
            DispatchQueue.main.async {
                self.articles = news
                self.tableView.reloadData()
            }
        }
        self.refreshControl?.endRefreshing()
    }
}
