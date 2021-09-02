import XCTest

@testable import MarvelCharacters

class CharactersBuilderTests: XCTestCase {
    var view: CharactersViewContract?
    var presenter: CharactersPresenterProtocol?
    
    var mockView: CharactersViewMock {
        return (view as? CharactersViewMock)!
    }
    
    func testBuild() {
        let view = CharactersBuilder().build()
        XCTAssertNotNil(view.presenter)
    }
}
