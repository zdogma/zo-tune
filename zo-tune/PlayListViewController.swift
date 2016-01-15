import UIKit
import RealmSwift

class PlayListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let testBook = Book()
        testBook.title     = "test"
        testBook.createdAt = NSDate()
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(testBook)
        }
        
        print(realm.objects(Book))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

