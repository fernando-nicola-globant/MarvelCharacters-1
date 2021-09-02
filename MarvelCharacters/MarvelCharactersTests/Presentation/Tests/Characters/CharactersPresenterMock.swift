@testable import MarvelCharacters

final class CharactersPresenterMock: CharactersPresenterProtocol {
    var view: CharactersViewContract?
    var mockUseCase: GetCharactersUseCaseMock?

    var mockView: CharactersViewMock {
        return (view as? CharactersViewMock)!
    }

    var loadingNextPage: Bool = false

    var offsetCount: Int = 0

    func getCharacterCount() -> Int { 20 }

    func getCharacter(_ index: Int) -> CharactersViewModel? { nil }

    func getCharID(_ index: Int) -> Int? { 10 }

    func loadNewCharacters() {}

    func viewLoaded() {}

    func retry() {}
}
