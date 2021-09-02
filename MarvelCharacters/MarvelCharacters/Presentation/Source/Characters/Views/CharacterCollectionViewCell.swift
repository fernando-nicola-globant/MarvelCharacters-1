import SDWebImage
import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: CharacterCollectionViewCell.self)
    
    @IBOutlet weak private var characterNameLabel: UILabel!
    @IBOutlet weak private var characterImageView: UIImageView!
    
    func setup(_ viewModel: CharactersViewModel) {
        characterNameLabel.text = viewModel.name
        characterImageView.sd_setImage(with: viewModel.image,
                                       placeholderImage: UIImage(named: "splash"),
                                       completed: nil)
    }
}
