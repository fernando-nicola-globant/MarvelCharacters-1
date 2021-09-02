import XCTest

@testable import MarvelCharacters

class CharacterDetailsPresenterTests: XCTestCase {
    let presenter = CharacterDetailsPresenter()
    var mockUseCase = GetCharacterDetailsUseCaseMock()
    private let timedOutError: ErrorCases = .network((NSError(domain: NSURLErrorDomain,
                                                              code: URLError.timedOut.rawValue,
                                                              userInfo: nil)))
    override func setUp() {
        super.setUp()
        commonSetup()
    }
    
    private func commonSetup() {
        presenter.charID = 1011334
        presenter.characterData = CharactersDataModel.dummyModel()
    }
    
    func testViewLoaded() {
        mockUseCase.result = .success(CharactersDataModel.dummyModel())
        presenter.useCase = mockUseCase
        presenter.viewLoaded()
        guard case .success(let viewModel) = presenter.status else {
            return XCTFail("failed")
        }

        XCTAssertEqual(viewModel?.name, "3-D Man")
        XCTAssertEqual(viewModel?.description, "")
    }

    func testViewLoadedFailure() {
        mockUseCase.result = .failure(.generic(timedOutError))
        presenter.useCase = mockUseCase
        presenter.viewLoaded()
        guard case .failure = presenter.status else {
            return XCTFail("failed")
        }
    }
    
    func testRetry() {
        mockUseCase.result = .success(CharactersDataModel.dummyModel())
        presenter.useCase = mockUseCase
        presenter.retry()
        guard case .success(let viewModel) = presenter.status else {
            return XCTFail("failed")
        }

        XCTAssertEqual(viewModel?.name, "3-D Man")
        XCTAssertEqual(viewModel?.description, "")
    }
}

