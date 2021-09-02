import UIKit

class BaseViewController: UIViewController {
    private let loader = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoaderView()
    }
    
    private func configureLoaderView() {
        loader.color = .darkGray
        loader.hidesWhenStopped = true
    }

    private func addConstraints() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func showLoader() {
        view.addSubview(loader)
        addConstraints()
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.stopAnimating()
    }
    
    func showErrorAlert(view: UIViewController) {
        let alert = UIAlertController(title: "Error", message: "Something went wrong!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "RETRY", style: UIAlertAction.Style.default, handler: {_ in 
            if let viewController = view as? CharacterDetailsViewController {
                viewController.didTapOnRetry()
            }
            if let viewController = view as? CharactersViewController {
                viewController.didTapOnRetry()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
