import Foundation
import UIKit

protocol CharacterDetailsViewContract: AnyObject {
    var presenter: CharacterDetailsPresenterProtocol! { get set }
    func updateCurrentViewStatus(_ status: CharacterDetailsCurrentViewStatus)
}

class CharacterDetailsViewController: BaseViewController, CharacterDetailsViewContract {
    static let identifier = String(describing: CharacterDetailsViewController.self)
    
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var characterImageView: UIImageView!
    @IBOutlet weak private var characterNameLabel: UILabel!
    @IBOutlet weak private var characterDescriptionLabel: UILabel!
    @IBOutlet weak private var comicsCountLabel: UILabel!
    @IBOutlet weak private var seriesCountLabel: UILabel!
    @IBOutlet weak private var storiesCountLabel: UILabel!
    @IBOutlet weak private var eventsCountLabel: UILabel!
    
    var presenter: CharacterDetailsPresenterProtocol!
    
    func updateCurrentViewStatus(_ status: CharacterDetailsCurrentViewStatus) {
        switch status {
        case .clear:
            break
        case .success(let viewModel):
            hideLoader()
            configureView(viewModel)
        case .loading:
            showLoader()
        case .failure:
            hideLoader()
            showErrorAlert(view: self)
        }
    }
    
    func didTapOnRetry() {
        presenter.retry()
    }
}

private extension CharacterDetailsViewController {
    func configureView(_ viewModel: CharacterDetailsViewModel?) {
        guard let viewModel = viewModel else {
            return
        }
        contentView.isHidden = false
        characterImageView.sd_setImage(with: viewModel.image, completed: nil)
        characterNameLabel.text = viewModel.name
        characterDescriptionLabel.text = viewModel.description
        comicsCountLabel.text = viewModel.comicsCount
        seriesCountLabel.text = viewModel.seriesCount
        storiesCountLabel.text = viewModel.storiesCount
        eventsCountLabel.text = viewModel.eventsCount
    }
}
