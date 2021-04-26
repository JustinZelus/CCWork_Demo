

import Foundation

struct Member: Codable ,PropertyLoopable{
    
    var Account: String
    var Address: String
    var Name: String
    var ID: String
    var Phone: String
    var Photo: String
}


struct MemberDisplay {
    var title: String
    var word: String
}
