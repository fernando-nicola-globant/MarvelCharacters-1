import XCTest

@testable import MarvelCharacters

class GetCharacterDetailsUseCaseTests: XCTestCase {
    private let timedOutError: ErrorCases = .network((NSError(domain: NSURLErrorDomain,
                                                              code: URLError.timedOut.rawValue,
                                                              userInfo: nil)))
    
    func testGetCharacterDetailsUseCaseSuccess() {
       let useCase = GetCharacterDetailsUseCase(MarvelProviderMock(mockListResponse: .success(CharactersDataModel.dummyModel())))
        useCase.run(GetCharacterDetailsParams(charID: 1011334) { result in
            switch result {
            case .success(let model):
                XCTAssertEqual(model.result?.count, 1)
            case .failure(let error):
                XCTFail("failed due to network error: \(error)")
            }
        })
    }
    
    func testGetCharacterDetailsUseCaseFailure() {
        let useCase = GetCharacterDetailsUseCase(MarvelProviderMock(mockListResponse: .failure(.generic(timedOutError))))
        useCase.run(GetCharacterDetailsParams(charID: 1011334){ result in
            guard case .failure = result else {
                return XCTFail("No response")
            }
        })
    }
}
