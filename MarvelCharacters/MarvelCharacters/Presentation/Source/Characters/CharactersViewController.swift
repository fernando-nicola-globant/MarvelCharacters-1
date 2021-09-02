import Foundation
import UIKit

protocol CharactersViewContract: AnyObject {
    var presenter: CharactersPresenterProtocol! { get set }
    func updateCurrentViewStatus(_ status: CharactersCurrentViewStatus)
}

class CharactersViewController: BaseViewController, CharactersViewContract {
    static let identifier = String(describing: CharactersViewController.self)
    var presenter: CharactersPresenterProtocol!
    private let cellSize = CGSize(width: 175, height: 250)
    private let cellSpacing = CGFloat(5)
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.viewLoaded()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cellSize
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        collectionView.collectionViewLayout = layout
        self.collectionView.register(UINib(nibName: CharacterCollectionViewCell.reuseIdentifier,
                                           bundle: nil),
                                     forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
    }
    
    func updateCurrentViewStatus(_ status: CharactersCurrentViewStatus) {
        switch status {
        case .clear:
            break
        case .success:
            hideLoader()
            self.collectionView.reloadData()
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

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCharacterCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = presenter.getCharacter(indexPath.row),
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == presenter.getCharacterCount() - 1) {
            UIView.transition(with: collectionView,
                              duration: 1.5,
                              options: .transitionFlipFromTop,
                              animations: {
                                let indexFirst = IndexPath(row:
                                                            indexPath.row - self.presenter.offsetCount,
                                                           section: 0)
                                self.collectionView.scrollToItem(at: indexFirst,
                                                                 at: .top,
                                                                 animated: true)},
                              completion: nil)
            
            presenter.loadNewCharacters()
        }
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let charID = presenter.getCharID(indexPath.row) {
            let viewController = CharacterDetailsBuilder().build(charID: charID)
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
