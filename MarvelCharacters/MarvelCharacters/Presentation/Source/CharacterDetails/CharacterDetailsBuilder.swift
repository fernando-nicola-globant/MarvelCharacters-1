import UIKit

final class CharacterDetailsBuilder {
    var view: CharacterDetailsViewContract
    var presenter: CharacterDetailsPresenterProtocol

    init() {
        let viewController = UIStoryboard.init(name: CharacterDetailsViewController.identifier,
                                               bundle: Bundle.main).instantiateViewController(withIdentifier: CharacterDetailsViewController.identifier)
        self.view = viewController as! CharacterDetailsViewController
        self.presenter = CharacterDetailsPresenter()
    }

    func build(charID: Int) -> CharacterDetailsViewController {
        view.presenter = presenter
        presenter.view = view
        presenter.charID = charID
        return view as! CharacterDetailsViewController
    }
}
