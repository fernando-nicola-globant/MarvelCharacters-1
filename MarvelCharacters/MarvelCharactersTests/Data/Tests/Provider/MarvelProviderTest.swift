import Moya
import XCTest

@testable import MarvelCharacters

class MarvelProviderTest: XCTestCase {
    private let timedOutResponse = Moya.EndpointSampleResponse.networkError(NSError(domain: NSURLErrorDomain,
                                                                              code: URLError.timedOut.rawValue,
                                                                              userInfo: nil))
    private func marvelProvider(_ response: Moya.EndpointSampleResponse? = nil,
                                stub: @escaping ServiceProvider<MarvelService>.StubClosure =
                                    ServiceProvider.immediatelyStub) -> MarvelProviderProtocol {
        var endpointClosure = ServiceProvider<MarvelService>.defaultEndpointMapping
        
        if let response = response {
            endpointClosure = { (target: MarvelService) -> Endpoint in
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { response },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
        }
        let serviceProvider = ServiceProvider<MarvelService>(endpointClosure: endpointClosure,
                                                             stubClosure: stub)
        return MarvelProvider(serviceProvider: serviceProvider)
    }
    
    func testGetCharactersSuccess() {
        let success = expectation(description: "success")
        marvelProvider().getCharacters(offset: 0) { result in
            if case let .success(charModel) = result {
                XCTAssertNotNil(charModel)
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetCharacterDetailsSuccess() {
        let success = expectation(description: "success")
        marvelProvider().getCharacterDetails(charID: 1011334) { result in
            if case let .success(charModel) = result {
                XCTAssertNotNil(charModel)
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetCharactersTimeoutFailure() {
        let timeoutResponse = expectation(description: "timeoutResponse")
        marvelProvider(timedOutResponse).getCharacters(offset: 0) { result in
            guard case .failure = result else {
                return XCTFail("Invalid response")
            }
            timeoutResponse.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetCharacterDetailsTimeoutFailure() {
        let timeoutResponse = expectation(description: "timeoutResponse")
        marvelProvider(timedOutResponse).getCharacterDetails(charID: 1011334) { result in
            guard case .failure = result else {
                return XCTFail("Invalid response")
            }
            timeoutResponse.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
