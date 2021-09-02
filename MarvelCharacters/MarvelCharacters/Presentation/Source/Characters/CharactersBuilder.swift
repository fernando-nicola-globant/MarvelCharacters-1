import UIKit

final class CharactersBuilder {
    var view: CharactersViewContract
    var presenter: CharactersPresenterProtocol
    
    init() {
        let viewController = UIStoryboard.init(name: CharactersViewController.identifier,
                                               bundle: Bundle.main).instantiateViewController(withIdentifier: CharactersViewController.identifier)
        self.view = viewController as! CharactersViewController
        self.presenter = CharactersPresenter()
    }
    
    func build() -> CharactersViewController {
        view.presenter = presenter
        presenter.view = view
        return view as! CharactersViewController
    }
}
