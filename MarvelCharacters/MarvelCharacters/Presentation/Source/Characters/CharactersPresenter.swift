import Moya
import UIKit

protocol CharactersPresenterProtocol: AnyObject {
    var view: CharactersViewContract? { get set }
    var loadingNextPage: Bool { get set }
    var offsetCount: Int { get set }
    func viewLoaded()
    func getCharacterCount() -> Int
    func getCharacter(_ index: Int) -> CharactersViewModel?
    func getCharID(_ index: Int) -> Int?
    func retry()
    func loadNewCharacters()
}

final class CharactersPresenter: CharactersPresenterProtocol {
    var currentStatus: CharactersCurrentViewStatus = .clear {
        didSet {
            guard oldValue != currentStatus else {
                return
            }
            view?.updateCurrentViewStatus(currentStatus)
        }
    }
    weak var view: CharactersViewContract?
    var loadingNextPage: Bool = false
    var offsetCount: Int = 0
    var characters: [CharacterDetailsModel] = []
    var useCase: GetCharactersUseCaseProtocol = GetCharactersUseCase()
    var offsetValue = 0

    func viewLoaded() {
        getCharacters()
    }
    
    func getCharacterCount() -> Int {
        characters.count
    }
    
    func getCharacter(_ index: Int) -> CharactersViewModel? {
        let model = characters[index]
        return CharactersViewModel(id: model.id,
                                   name: model.name,
                                   description: model.description,
                                   image: model.image)
    }
    
    func getCharID(_ index: Int) -> Int? {
        characters[index].id
    }
    
    func retry() {
        getCharacters()
    }
    
    func loadNewCharacters() {
        getCharacters()
    }
}

private extension CharactersPresenter {
    func getCharacters() {
        currentStatus = .loading
        useCase.run(params: GetCharactersParams(offset: offsetValue) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let charModel):
                self.handleSuccess(charModel)
            case .failure:
                self.currentStatus = .failure
            }
        })
    }

    func handleSuccess(_ model: CharactersDataModel) {
        model.result.map {
            self.characters.append(contentsOf: $0)
        }
        self.offsetCount = model.offset
        self.offsetValue = model.offset + model.count
        self.currentStatus = .success
    }
}
