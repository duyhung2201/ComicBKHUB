//
//  HomeModel.swift
//  ComicBKHUB
//
//  Created by TuanAnh on 7/8/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomeModel: NSObject {
    var imgUrl: String = ""
    var title: String = ""
    var issueName: String = ""
    var url: String = ""
    var issueUrl: String = ""
    var id: Int = 0
    
    convenience init(json: JSON){
        self.init()
        imgUrl = json["img"].stringValue
        title = json["title"].stringValue
        issueName = json["issue_name"].stringValue
        url = json["url"].stringValue
        issueUrl = json["issue_url"].stringValue
        id = json["id"].intValue
    }
    
}
