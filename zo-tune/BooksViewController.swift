import UIKit
import MediaPlayer
import RealmSwift

class BooksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var bookCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        bookTableView.delegate = self
        bookTableView.dataSource = self
    }

    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()

        return realm.objects(Book).count
    }
    
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCellWithIdentifier("bookTableCell", forIndexPath: indexPath)
        
        let realm = try! Realm()
        let books = realm.objects(Book).sorted("createdAt", ascending: false)
        
        let first_song = books[indexPath.row].songs.first!.media()

        // FIXME: 最初の曲のアートワークを取っているのを、再生数の多い曲とかに直したい
        let imageView = table.viewWithTag(1) as! UIImageView
        let artwork = first_song.valueForProperty(MPMediaItemPropertyArtwork)
        imageView.image = artwork?.imageWithSize(artwork!.bounds.size)
        
        let label1 = table.viewWithTag(2) as! UILabel
        label1.text = books[indexPath.row].title
        
        let label2 = table.viewWithTag(3) as! UILabel
        label2.text = "\(books[indexPath.row].songs.count)曲"

        let label3 = table.viewWithTag(4) as! UILabel
        let durationSum = books[indexPath.row].songs.map { $0.media().playbackDuration }.reduce(0, combine: +)
        
        // FIXME: 時刻表示をいい感じにやりたい
        let mm = Int(durationSum / 60)
        let ss = Int(durationSum - Double(mm * 60))
        label3.text = String(format: "%02d分%02d秒", mm, ss)
        
        return cell
    }
    
    // TODO: タップされたらそのBookを再生キューに入れる
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        
        let realm = try! Realm()
        let books = realm.objects(Book).sorted("createdAt", ascending: false)
        print(books[indexPath.row].title)
        
        let player = MPMusicPlayerController.systemMusicPlayer()
      
        let media_ids = books[indexPath.row].songs.map { $0.media_id }
        // FIXME: Book内の曲をすべてキューに入れたい
        let media_id = media_ids.first

        let songQuery = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: media_id, forProperty: MPMediaItemPropertyPersistentID)
        songQuery.addFilterPredicate(predicate)
        player.setQueueWithQuery(songQuery)
        player.play()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let realm = try! Realm()
        bookCountLabel.text = "BOOK数: \(realm.objects(Book).count)"
        bookTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

