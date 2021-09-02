@testable import MarvelCharacters

final class CharactersViewMock: CharactersViewContract {
    var presenter: CharactersPresenterProtocol!
    var state: CharactersCurrentViewStatus?
    
    func updateCurrentViewStatus(_ status: CharactersCurrentViewStatus) {
        self.state = status
    }
}
