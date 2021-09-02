@testable import MarvelCharacters

final class CharacterDetailsViewMock: CharacterDetailsViewContract {
    var presenter: CharacterDetailsPresenterProtocol!
    var state: CharacterDetailsCurrentViewStatus?
    
    func updateCurrentViewStatus(_ status: CharacterDetailsCurrentViewStatus) {
        self.state = status
    }
}
