import XCTest

@testable import MarvelCharacters

class CharacterDetailsBuilderTests: XCTestCase {
    var view: CharacterDetailsViewContract?
    var presenter: CharacterDetailsPresenterProtocol?
    
    var mockView: CharacterDetailsViewMock {
        return (view as? CharacterDetailsViewMock)!
    }
    
    var mockPresenter: CharacterDetailsPresenterMock {
        return (presenter as? CharacterDetailsPresenterMock)!
    }
    
    func testBuild() {
        let view = CharacterDetailsBuilder().build(charID: 1009170)
        XCTAssertNotNil(view.presenter)
    }
}
