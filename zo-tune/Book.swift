import Foundation
import MediaPlayer
import RealmSwift

class Book: Object {
    dynamic var id: String = NSUUID().UUIDString
    dynamic var title      = ""
    dynamic var createdAt  = NSDate()
    let         songs      = List<Song>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
