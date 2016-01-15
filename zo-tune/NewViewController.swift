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


    @IBAction func pick(sender: AnyObject) {
        let picker = MPMediaPickerController()
        picker.delegate = self
        picker.allowsPickingMultipleItems = true

        presentViewController(picker, animated: true, completion: nil)
    }

    // メディアアイテムピッカーでアイテムを選択完了したときに呼び出される
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        let realm = try! Realm()

        let newBook = Book()
        // FIXME: タイトルを適切に埋め込む
        newBook.title = "test"
        try! realm.write {
            realm.add(newBook)

            for song in mediaItemCollection.items {
                let newSong = Song()
                newSong.media_id = song.valueForProperty(MPMediaItemPropertyPersistentID) as! NSNumber
                newBook.songs.append(newSong)
            }
        }
        
        // DEBUG
        for (index, song) in newBook.songs.enumerate() {
            let myLabel: UILabel = UILabel(frame: CGRectMake(0,20,400,50))
            myLabel.frame.origin.y = CGFloat(index * 20)
            myLabel.text = "\(index + 1)曲目: \(song.media_id)"
            self.view.addSubview(myLabel)
        }
        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
    }
}

