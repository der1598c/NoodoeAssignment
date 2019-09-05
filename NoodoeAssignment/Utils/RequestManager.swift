//
//  RequestManager.swift
//  NoodoeAssignment
//
//  Created by Leyee.H on 2019/9/5.
//  Copyright © 2019 Leyee. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case POST = "POST"
    case PUT = "PUT"
}

enum HTTPHeaderField: String {
    case ApplicationId = "X-Parse-Application-Id"
    case RESTAPIKey = "X-Parse-REST-API-Key"
    case SessionToken = "X-Parse-Session-Token"
    case ContentType = "Content-Type"
    case ContentLength = "Content-Length"
}

struct Account: Codable {
    var username: String!
    var password: String!
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

struct UserInfo: Codable {
    var objectId: String
    var username: String
    var updatedAt: String
    var timezone: Int
    var sessionToken: String
}

struct UpdateInfo: Codable {
    var updatedAt: String
}

private let appID = "vqYuKPOkLQLYHhk4QTGsGKFwATT4mBIGREI2m8eD"
private let restAPIKEY = ""

class RequestManager: NSObject {
    
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    static let sharedInstance = RequestManager()
    
    private override init(){
        
    }
    
    deinit {
        print("deinit...")
    }
    
    func loadDatas() {
        print("loadDatas...")
    }
    
    func loginRequest(httpMethod: HTTPMethod, apiURLStr: String, postData: Data, successBlock: @escaping (_ success:UserInfo)->(), faildBlock: @escaping (_ faild:Error)->()){
//        print("startRequest")
        
        let url = URL(string: apiURLStr)
        var request = URLRequest(url: url!)
        
        let headers = [
            HTTPHeaderField.ApplicationId.rawValue : appID,
            HTTPHeaderField.RESTAPIKey.rawValue : restAPIKEY,
            HTTPHeaderField.ContentType.rawValue : "application/json"
        ]
        
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        request.timeoutInterval = 10.0
        
        let session =  URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            if responseError != nil {
                print("request error \(responseError.debugDescription)")
                faildBlock(responseError!);
            }
            else {
                let userInfo = try! self.jsonDecoder.decode(UserInfo.self, from: responseData!)
                successBlock(userInfo);
            }
        }
        task.resume()
    }
    
    func update(httpMethod: HTTPMethod, apiURLStr: String, sessionToken: String, postData: Data, successBlock: @escaping (_ success: UpdateInfo)->(), faildBlock: @escaping (_ faild:Error)->()){
//        print("startRequest")
        
        let url = URL(string: apiURLStr)
        var request = URLRequest(url: url!)
        
        let headers = [
            HTTPHeaderField.ApplicationId.rawValue : appID,
            HTTPHeaderField.RESTAPIKey.rawValue : restAPIKEY,
            HTTPHeaderField.ContentType.rawValue : "application/json"
        ]
        
        request.httpMethod = httpMethod.rawValue
        if sessionToken != "" {
            request.addValue(sessionToken, forHTTPHeaderField: HTTPHeaderField.SessionToken.rawValue)
        }
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        request.timeoutInterval = 10.0
        
        let session =  URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            if responseError != nil {
                print("request error \(responseError.debugDescription)")
                faildBlock(responseError!);
            }
            else {
                let updateInfo = try! self.jsonDecoder.decode(UpdateInfo.self, from: responseData!)
                successBlock(updateInfo);
            }
        }
        task.resume()
    }
}
