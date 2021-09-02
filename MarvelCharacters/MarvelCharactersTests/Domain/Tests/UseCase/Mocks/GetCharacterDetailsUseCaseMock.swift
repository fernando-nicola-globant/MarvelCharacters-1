@testable import MarvelCharacters

final class GetCharacterDetailsUseCaseMock: GetCharacterDetailsUseCaseProtocol {
    var result: Result<CharactersDataModel, ErrorCases>?

    func run(_ params: GetCharacterDetailsParams) {
        guard let result = result else {
            fatalError("Mock response required")
        }
        params.completion(result)
    }
}
