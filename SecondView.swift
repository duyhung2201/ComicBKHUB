//
//  SecondView.swift
//  ComicBKHUB
//
//  Created by Nguyen Anh on 7/8/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher


class SecondView: UIViewController {
    
    var data : Comic?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "DetailTableViewCell1", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell1")
        self.tableView.register(UINib(nibName: "DetailTableViewCell2", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell2")

    }
    

}

extension SecondView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell1", for: indexPath) as! DetailTableViewCell1
        cell1.nameLabel.text = data?.title
        cell1.firmName.text = data?.issue_name
        let url = URL(string: data!.img)
        cell1.img.kf.setImage(with: url)
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell2", for: indexPath) as! DetailTableViewCell2
        if indexPath.row == 0 {
            return cell1
        } else {
            return cell2
        }
        
    }
    
    
}

