@testable import MarvelCharacters

final class CharacterDetailsPresenterMock: CharacterDetailsPresenterProtocol {
    var view: CharacterDetailsViewContract?
    var mockUseCase: GetCharacterDetailsUseCaseMock?
    var characterData: CharactersDataModel?

    var mockView: CharacterDetailsViewMock {
        return (view as? CharacterDetailsViewMock)!
    }
    var charID: Int = 0
    
    func retry() {}
    
    func viewLoaded() {}
}
