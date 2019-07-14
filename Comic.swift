//
//  Comic.swift
//  ComicBKHUB
//
//  Created by Nguyen Anh on 7/8/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit
import SwiftyJSON

class Comic: NSObject {
    
    var id: String = ""
    var title: String = ""
    var img: String = ""
    var url: String = ""
    var issue_url: String = ""
    var issue_name: String = ""
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.title = json["title"].stringValue
        self.img = json["img"].stringValue
        self.issue_url = json["issue_url"].stringValue
        self.issue_name = json["issue_name"].stringValue
        self.url = json["url"].stringValue
    }

}
