import UIKit
import MediaPlayer
import RealmSwift

class NewViewController: UIViewController, MPMediaPickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
    }

    @IBAction func pick(sender: AnyObject) {
        let picker = MPMediaPickerController()
        picker.delegate = self
        picker.allowsPickingMultipleItems = true
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // メディアアイテムピッカーでアイテムを選択完了したときに呼び出される
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        if mediaItemCollection.items.isEmpty {
            mediaPicker.dismissViewControllerAnimated(true, completion: nil)
            // Booksに遷移したい
        }
    
        let realm = try! Realm()

        let newBook = Book()

        // FIXME: 日付を扱うクラスを外出ししたい
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd_HH:mm:ss"

        newBook.title = "Book \(dateFormatter.stringFromDate(now))"

        try! realm.write {
            realm.add(newBook)

            for song in mediaItemCollection.items {
                let newSong = Song()
                newSong.media_id = song.valueForProperty(MPMediaItemPropertyPersistentID) as! NSNumber
                newBook.songs.append(newSong)
            }
        }

        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
        // TODO: Play画面に遷移したい
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
        // TODO: Play画面に遷移したい
    }
}

