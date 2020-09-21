//
//  NewsTableViewController.swift
//  newsZennex
//
//  Created by Zakirov Tahir on 05.09.2020.
//  Copyright © 2020 Zakirov Takhir. All rights reserved.
//

import UIKit


class NewsTableViewController: UITableViewController {
    
    private var news:NewsList?
    private var newsUrl: String?
    private var newsName: String?
    private var nextPage = 1
    var isLoading = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        fetchResult()
        
    }
    
    func fetchResult() {
        
        isLoading = true
        let url = "https://newsapi.org/v2/everything?q=ios&from=2019-04-00&sortBy=publishedAt&apiKey=26eddb253e7840f988aec61f2ece2907&page=\(nextPage)"
        
        
        guard let urlNews = URL(string: url) else { return }
        let dataTask = URLSession.shared.dataTask(with: urlNews) { (data, _, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                self.news = try decoder.decode(NewsList.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    guard let newsCount = self.news?.articles else { return }
                    self.news?.articles.append(contentsOf: newsCount)
                    self.isLoading = false
                    self.tableView.reloadData()
                    
                }
                
            } catch let error {
                print(error)
            }
            
        }
        dataTask.resume()
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return news?.articles.count ?? 0
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
            
            configureCell(cell: cell, for: indexPath)
            
            cell.postImage.layer.cornerRadius = 10
            cell.postDate.layer.cornerRadius = 10
            cell.postDate.layer.masksToBounds = true
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadCell", for: indexPath) as! LoadTableViewCell
            cell.activityIndicator.startAnimating()
            return cell
        }
        
        
    }
    
    
    
    private func configureCell(cell: NewsTableViewCell, for indexPath: IndexPath) {
        guard let news = news?.articles[indexPath.row] else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        
        
        cell.imageView?.image = nil
        cell.postTitle.text = news.title!
        cell.postDescription.text = news.description!
        cell.postDate.text = dateFormatter.string(from: news.publishedAt!)
        
        DispatchQueue.global().async {
            
            guard let imageUrl = URL(string: news.urlToImage ?? "") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                cell.postImage.image = UIImage(data: imageData)
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = news?.articles[indexPath.row] else { return }
        newsUrl = news.url
        newsName = news.title
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webPage = segue.destination as! NewsDetailViewController
        webPage.postTitle = newsName
        
        if let url = newsUrl {
            webPage.postUrl = url
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height ) && !isLoading {
            fetchResult()
            print("is load")
        }
    }
    
    
    
    
}



