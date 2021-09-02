import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var showCharactersButton: UIButton!

    @IBAction func showCharactersButtonClicked(_ sender: Any) {
        let viewController = CharactersBuilder().build()
        self.present(viewController, animated: true, completion: nil)
    }
}
