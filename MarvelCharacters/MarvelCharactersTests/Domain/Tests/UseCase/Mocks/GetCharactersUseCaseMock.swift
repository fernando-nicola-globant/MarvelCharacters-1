@testable import MarvelCharacters

final class GetCharactersUseCaseMock: GetCharactersUseCaseProtocol {
    var result: Result<CharactersDataModel, ErrorCases>?

    func run(params: GetCharactersParams) {
        guard let result = result else {
            fatalError("Mock response required")
        }
        params.completion(result)
    }
}
