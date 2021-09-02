struct CharactersDataEntity: Decodable {
    let offset: Int?
    let total: Int?
    let count: Int?
    let limit: Int?
    let results: [CharacterDetailsEntity]?
    
    func toDomain() throws -> CharactersDataModel {
        return CharactersDataModel(total: total ?? 0,
                                   offset: offset ?? 0,
                                   count: count ?? 0,
                                   limit: limit ?? 0,
                                   result: try results?.map {try $0.toDomain()} ?? [])
    }
}
