
import Foundation
import UIKit

class Tools {
    
    static func stringArrayToData(stringArray: [String]) -> Data? {
      return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
    }
    
    static func convertDictionary(target:[String:Any]) -> [String:String] {
        var newDict = [String:String]()
        for (key,value) in target {
           newDict[key] = "\(value)"
        }
        return newDict
    }
    static func showAlertWith(vc: UIViewController , title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(ac, animated: true)
    }
    
    static func jsonToString(json: [String:Any]) -> String? {
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
           return convertedString
        } catch let myJSONError {
            print(myJSONError)
            return nil
        }
        
    }
}

protocol PropertyLoopable
{
    func allProperties() throws -> [String: Any]
}
