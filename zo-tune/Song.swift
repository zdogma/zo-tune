import Foundation

class Song {
    // MARK: Properties
    var title:  String
    var album:  String
    var artist: String

    // MARK: Initialization
    init(title: String, album: String, artist: String) {
        self.title  = title
        self.album  = album
        self.artist = artist
    }
}