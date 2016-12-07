//
//  ViewController.swift
//  GitHunt
//
//  Created by Alex on 05/12/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController {
    
    var user: String = "alcherk"
    var repos: [Repo] = Array<Repo>()
    
    @IBOutlet weak var repoTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Alamofire.request(GithubAPI.ListRepos(user: user, sort: GithubAPI.ListReposSort.DESC))
            .responseJSON { [weak self] response in
                if let JSON = response.result.value {
                    let repos = Mapper<Repo>().mapArray(JSONObject:JSON)
                    self?.repos = repos ?? [Repo]()
                    self?.repoTable.reloadData()
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum Helper: String {
        case cellName = "RepoCell"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Helper.cellName.rawValue)
        let repo = repos[indexPath.item]
        cell?.textLabel?.text = repo.name
        cell?.detailTextLabel?.text = repo.gitUrl
        
        return cell!
    }
}

