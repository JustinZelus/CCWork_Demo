

import Foundation

typealias HttpStrCompletion      = (_ success: Bool, _ result: String?) -> Void
typealias HttpCompletion      = (_ success: Bool, _ result: [String:Any]?) -> Void
typealias ConcurrentTaskCompletion = () -> Void

class NetworkModule {
    static func get(url:String,completion:@escaping HttpCompletion) {
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request,completionHandler: { data,response,error in
            do {
                if let error = error {
                    completion(false,["error":error.localizedDescription])
                    return
                }
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                completion(true,json)
            } catch {
                print("log exception")
            }
        })
        task.resume()
    }
}
