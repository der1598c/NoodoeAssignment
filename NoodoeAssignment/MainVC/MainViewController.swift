//
//  MainViewController.swift
//  NoodoeAssignment
//
//  Created by Leyee.H on 2019/9/4.
//  Copyright © 2019 Leyee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var helloTitle_lab: UILabel!
    @IBOutlet weak var timezone_txtField: UITextField!
    @IBOutlet weak var updateAt_lab: UILabel!
    
    let mRequestManager = RequestManager.sharedInstance
    let mApiUrl = "https://watch-master-staging.herokuapp.com/api/users/"
    let mParam = App.keychain!["objectId"]
    let mSessionToken = App.keychain!["sessionToken"]
    let encoder = JSONEncoder()
    
    let mSpinner = UIActivityIndicatorView (style: .whiteLarge)
    
    var username: String?
    var updateAt: String?
    var timezone: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initView()
    }
    
    func initView() {
        let screenCenter = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        mSpinner.center = screenCenter
        mSpinner.color = UIColor.blue
        self.view.addSubview(mSpinner)
        
        timezone_txtField.delegate = self
        self.helloTitle_lab.text = "Hello, \(username ?? "")"
        self.updateAt_lab.text = "Update At : \(updateAt ?? "")"
        self.timezone_txtField.text = "\(timezone ?? 0)"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func updateTapped(_ sender: UIButton) {
        let timezone = Int(timezone_txtField.text!) ?? 0
        let postDictionary = ["timezone":timezone]
        do {
            self.mSpinner.startAnimating()
            let jsonBody = try JSONSerialization.data(withJSONObject: postDictionary, options: .prettyPrinted)
            mRequestManager.update(httpMethod: HTTPMethod.PUT, apiURLStr: mApiUrl + mParam!, sessionToken: mSessionToken!, postData: jsonBody,
                successBlock: { (success) in
                    DispatchQueue.main.async {
                        self.mSpinner.stopAnimating()
                        self.updateAt_lab.text = "Update At : \(success.updatedAt)"
                    }
            }, faildBlock: { (faild) in
                DispatchQueue.main.async {
                    self.mSpinner.stopAnimating()
                }
            })
        } catch {
        }
    }
    
/*
 *Log out
 */
    @IBAction func clearLoginTapped(_ sender: UIButton) {
        try! App.keychain?.remove("sessionToken")
        UIApplication.setRootView(LoginViewController.instantiate(from: .Login), options: UIApplication.logoutAnimation)
    }
}

