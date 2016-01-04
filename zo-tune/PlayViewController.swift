import UIKit
import Foundation
import MediaPlayer

class PlayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // DEBUG: response のチェックとかこの辺でやる
        let albumsQuery: MPMediaQuery = MPMediaQuery.albumsQuery()
        print(albumsQuery)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}