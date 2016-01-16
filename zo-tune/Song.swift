import Foundation
import MediaPlayer
import RealmSwift

class Song: Object {
    dynamic var media_id: NSNumber = 0 // MPMediaItemPropertyPersistentID

    func media() -> MPMediaItem {
        let songQuery = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: media_id, forProperty: MPMediaItemPropertyPersistentID)
        songQuery.addFilterPredicate(predicate)
        return songQuery.items!.first!
    }
}

