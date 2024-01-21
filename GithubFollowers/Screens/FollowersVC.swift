//
//  FollowersVC.swift
//  GithubFollowers
//
//  Created by Leonel Meque on 20/1/24.
//

import UIKit

class FollowersVC: UIViewController {

    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Followers"
      
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) {
            followers, errorMessage in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Test Message", message: errorMessage?.rawValue ?? "", buttonTitle: "Ok")
                return
            }
            
            print("Followers.count = \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

#Preview ("Default") {
    FollowersVC()
}
