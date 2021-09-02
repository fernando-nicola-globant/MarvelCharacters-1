import Moya
import UIKit

protocol CharacterDetailsPresenterProtocol: AnyObject {
    var view: CharacterDetailsViewContract? { get set }
    var charID: Int { get set }
    func viewLoaded()
    func retry()
}

final class CharacterDetailsPresenter: CharacterDetailsPresenterProtocol {
    var useCase: GetCharacterDetailsUseCaseProtocol = GetCharacterDetailsUseCase()
    var status: CharacterDetailsCurrentViewStatus = .clear {
        didSet {
            guard oldValue != status else {
                return
            }
            view?.updateCurrentViewStatus(status)
        }
    }
    var charID: Int = 0 {
        didSet {
            getCharacterDetails()
        }
    }
    
    weak var view: CharacterDetailsViewContract?
    var characterData: CharactersDataModel?
    
    func viewLoaded() {
        getCharacterDetails()
    }
    
    func retry() {
        getCharacterDetails()
    }
}

private extension CharacterDetailsPresenter {
    func getCharacterDetails() {
        status = .loading
        useCase.run(GetCharacterDetailsParams(charID: charID) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let characterData):
                self.characterData = characterData
                self.status = .success(viewModel: self.getCharacterDetailsViewModel())
            case .failure:
                self.characterData = nil
                self.status = .failure
            }
        })
    }
    
    func getCharacterDetailsViewModel() -> CharacterDetailsViewModel? {
        guard let model = characterData?.result?.first else {
            return nil
        }
        return CharacterDetailsViewModel(id: model.id,
                                         name: model.name,
                                         description: model.description,
                                         image: model.image,
                                         comicsCount: String(model.comicsCount),
                                         seriesCount: String(model.seriesCount),
                                         storiesCount: String(model.storiesCount),
                                         eventsCount: String(model.eventsCount))
    }
}
