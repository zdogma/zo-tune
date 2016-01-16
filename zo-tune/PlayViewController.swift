import UIKit
import RealmSwift
import MediaPlayer

class PlayViewController: UIViewController {
    // TODO: 再生プレイヤーの実装
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // FIXME: DEBUG用に、PLAYに遷移すると音楽が消えるようにしておく
    override func viewDidAppear(animated: Bool) {
        MPMusicPlayerController.systemMusicPlayer().stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

