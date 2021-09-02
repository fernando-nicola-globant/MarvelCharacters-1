import Foundation

protocol GetCharactersUseCaseProtocol {
    typealias Completion = (_ result: Result<CharactersDataModel, ErrorCases>) -> Void
    
    func run(params: GetCharactersParams)
}

struct GetCharactersParams {
    typealias Completion = (Result<CharactersDataModel, ErrorCases>) -> Void
    let offset: Int
    let completion: Completion
    
    init(offset: Int, completion: @escaping Completion) {
        self.offset = offset
        self.completion = completion
    }
}

final class GetCharactersUseCase: GetCharactersUseCaseProtocol{
    private let provider: MarvelProviderProtocol

    init(_ provider: MarvelProviderProtocol = MarvelProvider()) {
        self.provider = provider
    }
    
    func run(params: GetCharactersParams) {
        provider.getCharacters(offset: params.offset) { result in
            switch result {
            case let .success(characters):
                params.completion(.success(characters))
            case let .failure(error):
                params.completion(.failure(error))
            }
        }
    }
}

