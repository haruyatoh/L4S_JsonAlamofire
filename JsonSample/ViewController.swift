//
//  ViewController.swift
//  JsonSample
//
//  Created by 矢頭春香 on 2017/02/22.
//  Copyright © 2017年 矢頭春香. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var articles: [[String: String?]] = []
    let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "記事一覧"
        
        table.frame = view.frame
        view.addSubview(table)
        table.dataSource = self
        
        getArticles()
    }
    
    func getArticles() {
        let listUrl = "http://www.land.mlit.go.jp/webland/api/CitySearch?area=13";
        Alamofire.request(listUrl)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach { (_, json) in
                    for id in 0...62{
                    let article: [String: String?] = [
                        "title": json[id]["name"].string,
                       // "userId": json["name"].string
                    ]
                    self.articles.append(article)
                    }
                
                self.table.reloadData()
                
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        cell.textLabel?.text = article["title"]!
        //cell.detailTextLabel?.text = article["userId"]!
        return cell
    }
}
