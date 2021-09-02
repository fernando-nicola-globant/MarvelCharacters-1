import XCTest

@testable import MarvelCharacters

class GetCharactersUseCaseTests: XCTestCase {
    private let timedOutError: ErrorCases = .network((NSError(domain: NSURLErrorDomain,
                                                              code: URLError.timedOut.rawValue,
                                                              userInfo: nil)))
    
    func testGetCharactersUseCaseSuccess() {
        let useCase = GetCharactersUseCase(MarvelProviderMock(mockListResponse: .success(CharactersDataModel.dummyModel())))
        useCase.run(params: GetCharactersParams(offset: 0){ result in
            switch result {
            case .success(let model):
                XCTAssertEqual(model.result?.count, 1)
            case .failure(let error):
                XCTFail("failed due to network error: \(error)")
            }
        })
    }
    
    func testGetCharactersUseCaseFailure() {
        let useCase = GetCharactersUseCase(MarvelProviderMock(mockListResponse: .failure(.generic(timedOutError))))
        useCase.run(params: GetCharactersParams(offset: 0){ result in
            guard case .failure = result else {
                return XCTFail("No response")
            }
        })
    }
}

