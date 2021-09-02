import XCTest

@testable import MarvelCharacters

class CharactersPresenterTests: XCTestCase {
    let presenter = CharactersPresenter()
    var mockUseCase = GetCharactersUseCaseMock()
    private let timedOutError: ErrorCases = .network((NSError(domain: NSURLErrorDomain,
                                                              code: URLError.timedOut.rawValue,
                                                              userInfo: nil)))
    override func setUp() {
        super.setUp()
        presenter.characters = [CharacterDetailsModel.dummyModel()]
    }
    
    func testViewLoaded() {
        mockUseCase.result = .success(CharactersDataModel.dummyModel())
        presenter.useCase = mockUseCase
        presenter.viewLoaded()
        guard case .success = presenter.currentStatus else {
            return XCTFail("failed")
        }
    }

    func testViewLoadedFailure() {
        mockUseCase.result = .failure(.generic(timedOutError))
        presenter.useCase = mockUseCase
        presenter.viewLoaded()
        guard case .failure = presenter.currentStatus else {
            return XCTFail("failed")
        }
    }
    
    func testRetry() {
        mockUseCase.result = .success(CharactersDataModel.dummyModel())
        presenter.useCase = mockUseCase
        presenter.retry()
        guard case .success = presenter.currentStatus else {
            return XCTFail("failed")
        }
    }

    func testGetCharacter() {
        let result = presenter.getCharacter(0)
        XCTAssertEqual(result?.name, "3-D Man")
        XCTAssertEqual(result?.description, "")
    }

    func testGetCharacterID() {
        let result = presenter.getCharID(0)
        XCTAssertEqual(result, 1011334)
    }

    func testGetCharacterCount() {
        let result = presenter.getCharacterCount()
        XCTAssertEqual(result, 1)
    }

    func testLoadingNext() {
        presenter.loadNewCharacters()
        XCTAssertEqual(presenter.currentStatus, .loading)
    }
}

