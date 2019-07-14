//
//  ViewController.swift
//  ComicBKHUB
//
//  Created by Duy Hung Le on 7/7/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

enum HTTPMethods: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

class ViewController: UIViewController {
    
    typealias Completion = (_ success: Bool, _ data: [Comic]?) ->()
    var arrayData = [Comic]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        self.tableView.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryTableViewCell")
        
        fetchData(url: "https://mbcomic-app.herokuapp.com/comics/home?fbclid=IwAR0RLWgeREM7T683C3KRNgugoBqWGq6WtyH-eEoXeGB4w1T9XmAEB4vdzmE") {
            (success, data) in
            if success {
                self.arrayData = data!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    private func fetchData(url: String, completion: @escaping Completion) {
        if let url = URL(string: url) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethods.get.rawValue
            urlRequest.timeoutInterval = 10
            
            URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
                if let responseData = data {
                    let json = JSON(data)
                    let arrayJSON = json["popular"].arrayValue
                    var arrayResponse = [Comic]()
                    arrayJSON.forEach({ (json) in
                        arrayResponse.append(Comic(json: json))
                    })
                    completion(true, arrayResponse)
                }
                }.resume()
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        let card = arrayData[indexPath.row]
        
        cell1.nameLabel.text = card.title
        cell1.issue_name.text = card.issue_name
        let url = URL(string: card.img)
        cell1.img.kf.setImage(with: url)
        return cell1
//        let cell2 = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
//        if indexPath.row == 0 {
//            return cell1
//        } else {
//            return cell2
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondView") as? SecondView else {
            return
        }
        
        vc.data = arrayData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
