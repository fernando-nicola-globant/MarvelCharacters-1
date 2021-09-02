@testable import MarvelCharacters

typealias ListResponse = Result<CharactersDataModel, ErrorCases>

final class MarvelProviderMock: MarvelProviderProtocol {
    private var mockListResponse: ListResponse?

    init(mockListResponse: ListResponse) {
        self.mockListResponse = mockListResponse
    }
    
    func getCharacters(offset: Int, completion: @escaping GetCharactersClosure) {
        guard let mockListResponse = mockListResponse else {
            fatalError("mock required")
        }
        completion(mockListResponse)
    }
    
    func getCharacterDetails(charID: Int, completion: @escaping GetCharacterDetailsClosure) {
        guard let mockDetailsResponse = mockListResponse else {
            fatalError("mock required")
        }
        completion(mockDetailsResponse)
    }
}

