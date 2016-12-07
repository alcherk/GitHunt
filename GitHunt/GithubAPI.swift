//
//  GithubAPI.swift
//  GitHunt
//
//  Created by Alex on 05/12/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
import Alamofire

enum GithubAPI: URLRequestConvertible {
    static let baseURLString = "https://api.github.com"
    
    // MARK: API methods definitions
    
    case ListRepos(user: String, sort: ListReposSort?);
    
    // MARK: Parameters values for API methods
    
    enum ListReposSort {
        case DESC
        case ASC
        var value: String {
            switch self {
            case .ASC:
                return "asc"
            case .DESC:
                return "desc"
            }
        }
    }
    
    // MARK: Verb definition according to API method
    
    var method: HTTPMethod {
        switch self {
        case .ListRepos:
            return .get
        }
    }
    
    // MARK: Path definition according to API method
    
    var path: (lastSegmentPath: String, parameters: [String: AnyObject]?) {
        switch self {
        case .ListRepos(let user, let sort) where sort != nil:
            return ("/users/\(user)/repos", ["sort": sort!.value as AnyObject])
        case .ListRepos(let user, _):
            return ("/users/\(user)/repos", nil)
        }
    }
    
    // MARK: asURLRequest
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = NSURL(string: GithubAPI.baseURLString)
        
        var urlRequest = URLRequest(url: (url?.appendingPathComponent(path.lastSegmentPath))!)
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .ListRepos:
            let params = [String: AnyObject]()
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        
        return urlRequest
    }

}
