import UIKit
import MediaPlayer

class NewViewController: UIViewController, MPMediaPickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func pick(sender: AnyObject) {
        // FIXME: 設定は外出ししてpickerを取り出す部分だけ記述したい
        let picker = MPMediaPickerController()
        // ピッカーのデリゲートを設定
        picker.delegate = self
        // 複数選択を不可にする。（trueにすると、複数選択できる）
        picker.allowsPickingMultipleItems = true
        // ピッカーを表示する
        presentViewController(picker, animated: true, completion: nil)
    }

    // メディアアイテムピッカーでアイテムを選択完了したときに呼び出される
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        for (index, song) in mediaItemCollection.items.enumerate() {
            // TODO: debug用のラベルなので、確認が終わったら破棄する
            let myLabel: UILabel = UILabel(frame: CGRectMake(0,20,400,50))
            myLabel.frame.origin.y = CGFloat(index * 20)
            myLabel.text = "\(index + 1)曲目: \(song.title!)"
            self.view.addSubview(myLabel)
        }
        
        // ピッカーを閉じ、破棄する
        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //選択がキャンセルされた場合に呼ばれる
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        // ピッカーを閉じ、破棄する
        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
    }
}

