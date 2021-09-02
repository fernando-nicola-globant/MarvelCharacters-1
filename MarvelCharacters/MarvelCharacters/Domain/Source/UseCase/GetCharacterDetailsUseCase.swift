protocol GetCharacterDetailsUseCaseProtocol {
    typealias Completion = (_ result: Result<CharactersDataModel, ErrorCases>) -> Void
    
    func run(_ params: GetCharacterDetailsParams)
}

struct GetCharacterDetailsParams {
    typealias Completion = (Result<CharactersDataModel, ErrorCases>) -> Void
    let charID: Int
    let completion: Completion
    
    init(charID: Int, completion: @escaping Completion) {
        self.charID = charID
        self.completion = completion
    }
}

final class GetCharacterDetailsUseCase: GetCharacterDetailsUseCaseProtocol {
    private let provider: MarvelProviderProtocol

    init(_ provider: MarvelProviderProtocol = MarvelProvider()) {
        self.provider = provider
    }

    func run(_ params: GetCharacterDetailsParams) {
        provider.getCharacterDetails(charID: params.charID){ result in
            switch result {
            case let .success(characterDetails):
                params.completion(.success(characterDetails))
            case let .failure(error):
                params.completion(.failure(error))
            }
        }
    }
}


