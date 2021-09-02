protocol MarvelProviderProtocol {
    typealias GetCharactersClosure = (Result<CharactersDataModel, ErrorCases>) -> Void
    typealias GetCharacterDetailsClosure = (Result<CharactersDataModel, ErrorCases>) -> Void
    
    func getCharacters(offset: Int, completion: @escaping GetCharactersClosure)
    func getCharacterDetails(charID: Int, completion: @escaping GetCharacterDetailsClosure)
}
