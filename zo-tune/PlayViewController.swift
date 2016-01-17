import UIKit
import RealmSwift
import MediaPlayer

class PlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var playViewLabel: UILabel!
    @IBOutlet weak var bookCountLabel: UILabel!
    @IBOutlet weak var songTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songTableView.delegate = self
        songTableView.dataSource = self

        // FIXME: 選択されていなかった時、暫定で最新のBookを入れている
        if (PlayingBook == nil) {
            let realm = try! Realm()
            PlayingBook = realm.objects(Book).sorted("createdAt", ascending: false).last
        }
    }
    
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PlayingBook!.songs.count
    }
    
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCellWithIdentifier("songTableCell", forIndexPath: indexPath)
        
        let songs = PlayingBook!.songs
        
        let imageView = table.viewWithTag(1) as! UIImageView
        let artwork = songs[indexPath.row].media().artwork
        imageView.image = artwork?.imageWithSize(artwork!.bounds.size)
        
        let song_title_label = table.viewWithTag(2) as! UILabel
        song_title_label.text = songs[indexPath.row].media().title
        
        let artist_label = table.viewWithTag(3) as! UILabel
        artist_label.text = songs[indexPath.row].media().artist
        
        let duration_label = table.viewWithTag(4) as! UILabel
        let duration = songs[indexPath.row].media().playbackDuration
        // FIXME: 時刻表示をいい感じにやりたい
        let mm = Int(duration / 60)
        let ss = Int(duration - Double(mm * 60))
        duration_label.text = String(format: "%02d分%02d秒", mm, ss)
        
        let played_count_label = table.viewWithTag(5) as! UILabel
        played_count_label.text = "\(songs[indexPath.row].media().playCount)回再生"
        
        return cell
    }
    
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        // TODO: 選択された曲から再生したい
    }


    override func viewDidAppear(animated: Bool) {
        if (PlayingBook != nil) {
            playViewLabel.text = "NowPlaying: \(PlayingBook!.title)"
        }
        songTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

