//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Leonel Meque on 19/1/24.
//

import UIKit

class SearchVC: UIViewController {
    
    var isUserNameEntered: Bool {
       !userNameTextField.text!.isEmpty
    }
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let userNameTextField:GFTextField = {
        let textField = GFTextField()
        return textField
    }()
    
    let callToActionButton: GFButton = {
        let button = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Search"
        configureLogoImageView()
        configureTextField()
        configureCTAButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
   @objc func pushFollowerListVC(){
       guard isUserNameEntered else {
           
           presentGFAlertOnMainThread(title: "Empty username", message: "Please enter a user name", buttonTitle: "Ok")
           return}
       
       let followerListVC = FollowersVC()
       followerListVC.userName = userNameTextField.text
       followerListVC.title = userNameTextField.text
       
       navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configureTextField(){
        view.addSubview(userNameTextField)
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        userNameTextField.delegate = self
        
    }
    
    func configureCTAButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 24),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func setBackgroundColor(uiColor: UIColor){
        view.backgroundColor = uiColor
    }

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}

#Preview ("Search BG Brown") {
    let searchVC = SearchVC()
    
    return searchVC
}

#Preview ("Search BG Dark Gray") {
    let searchVC = SearchVC()
    searchVC.setBackgroundColor(uiColor: .darkGray)
    
    return searchVC
}
