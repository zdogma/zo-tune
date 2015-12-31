import Foundation

class PlayList {
    // MARK: Properties
    var title: String
    var totalTime: Int
    var createdAt: NSDate
    var songs: [Song]

    // MARK: Initialization
    init(title: String, totalTime: Int, createdAt: NSDate, songs: [Song]) {
        self.title     = title
        self.totalTime = totalTime
        self.createdAt = createdAt
        self.songs     = songs
    }
}