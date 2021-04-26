

import Foundation


class LoginModule {
    
    static func GetToken(postData: Data? , completion:@escaping HttpStrCompletion){
        let session = URLSession(configuration: .default)
        let url = "http://webdemo.kidtech.com.tw/AppTest/API/GetToken"
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = session.dataTask(with: request,completionHandler: { data,response,error in
            do {
                if let error = error {
                    completion(false,error.localizedDescription)
                    return
                }
                let json = try JSONSerialization.jsonObject(with: data!, options: [])  as? [String:Any]
                completion(true,json?["Token"] as? String)
                
            } catch {
                print("log exception")
            }
        })
        task.resume()
    }
    
    static func MemberLogin(postData: Data?,token: String , completion:@escaping HttpStrCompletion){
        let session = URLSession(configuration: .default)
        let url = "http://webdemo.kidtech.com.tw/AppTest/API/MemberLogin"
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = session.dataTask(with: request,completionHandler: { data,response,error in
            do {
                if let error = error {
                    completion(false,error.localizedDescription)
                    return
                }
                let json = try JSONSerialization.jsonObject(with: data!, options: [])  as? [String:Any]
                print(json!)
                let success = json?["Success"] as! Int
                 if success == 0 {
                     completion(false, json?["Message"] as? String)
                 } else {
                     completion(true, json?["MemberToken"] as? String)
                 }
    
                
            } catch {
                print("log exception")
            }
        })
        task.resume()
    }
    
    static func MemberData(memberToken: String , completion:@escaping HttpCompletion){
        let session = URLSession(configuration: .default)
        let url = "http://webdemo.kidtech.com.tw/AppTest/API/MemberData"
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(memberToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request,completionHandler: { data,response,error in
            do {
                if let error = error {
                    completion(false,["error":error.localizedDescription])
                    return
                }
                let json = try JSONSerialization.jsonObject(with: data!, options: [])  as? [String:Any]
                if let mj = json{
                    let member = mj["Member"] as? [String:Any]
                    completion(true,member)
                }
                
            } catch {
                print("log exception")
            }
        })
        task.resume()
    }
}
