//
//  LoginViewController.swift
//  login
//
//  Created by Oğulcan on 11/05/2018.
//  Copyright © 2018 ogulcan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userName_txtField: UITextField!
    @IBOutlet weak var password_txtField: UITextField!
    
    let mRequestManager = RequestManager.sharedInstance
    let mApiUrl = "https://watch-master-staging.herokuapp.com/api/login"
    let mEncoder = JSONEncoder()
    
    let mSpinner = UIActivityIndicatorView (style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenCenter = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        mSpinner.center = screenCenter
        mSpinner.color = UIColor.blue
        self.view.addSubview(mSpinner)
        
        self.userName_txtField.delegate = self
        self.password_txtField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveLoginTapped(_ sender: UIButton) {
        
        let account = Account(username: userName_txtField.text!, password: password_txtField.text!)
//        let account = Account(username: "test2@qq.com", password: "test1234qq")

        mEncoder.outputFormatting = .prettyPrinted
        if let data = try? mEncoder.encode(account) {
            // Debug code:
//            let jsonString = String(data: data, encoding: .utf8)!
//            print(jsonString)
            
            mSpinner.startAnimating()
            mRequestManager.loginRequest(httpMethod: HTTPMethod.POST, apiURLStr: mApiUrl, postData: data,
                successBlock: { (success) in
                    try! App.keychain?.set(success.sessionToken, key: "sessionToken")
                    try! App.keychain?.set(success.objectId, key: "objectId")
                    DispatchQueue.main.async {
                        self.mSpinner.stopAnimating()
                        let mainVC = MainViewController.instantiate(from: .Main)
                        mainVC.username = success.username
                        mainVC.updateAt = success.updatedAt
                        mainVC.timezone = success.timezone
                        UIApplication.setRootView(mainVC)
                    }
            }, faildBlock: { (faild) in
                    DispatchQueue.main.async {
                        self.mSpinner.stopAnimating()
                    }
                }
            )
        }
    }
}
