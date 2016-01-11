import UIKit
import MediaPlayer

class PlayViewController: UIViewController, MPMediaPickerControllerDelegate {
    // FIXME: 取り急ぎ置いておくが後で適切な位置に持っていく
    var player = MPMusicPlayerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        player = MPMusicPlayerController.applicationMusicPlayer()

        let query = MPMediaQuery.playlistsQuery()
        if let playlists = query.collections {
            for (index, playlist) in playlists.enumerate() {
                // TODO: debug用のラベルなので、確認が終わったら破棄する
                if index > 9 { break; }

                let myLabel: UILabel = UILabel(frame: CGRectMake(0,20,400,50))
                myLabel.frame.origin.y = CGFloat(index * 20)
                myLabel.text = "\(index + 1)個目: \(playlist.valueForProperty(MPMediaPlaylistPropertyName)!)"
                self.view.addSubview(myLabel)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

