//
//  Repo.swift
//  GitHunt
//
//  Created by Alex on 05/12/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
import ObjectMapper

class Repo: Mappable {
    var id: Int?;
    var name: String?;
    var owner: String?;
    var avatarUrl: String?;
    var desc: String?;
    var createdAt: String?;
    var gitUrl: String?;
    var cloneUrl: String?;

    required init?(map: Map) {
    }
}

extension Repo {
    
    func mapping(map: Map) {
        id          <- map["id"];
        name        <- map["name"];
        owner       <- map["owner.login"];
        avatarUrl   <- map["owner.avatar_url"];
        desc        <- map["description"];
        createdAt   <- map["created_at"];
        gitUrl      <- map["git_url"];
        cloneUrl    <- map["clone_url"];
    }
}
