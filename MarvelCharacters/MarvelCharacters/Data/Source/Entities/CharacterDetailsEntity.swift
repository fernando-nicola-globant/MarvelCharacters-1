struct CharacterDetailsEntity: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: CharacterImageEntity?
    let comics: CharacterItemsCountEntity?
    let series: CharacterItemsCountEntity?
    let stories: CharacterItemsCountEntity?
    let events: CharacterItemsCountEntity?

    func toDomain() throws -> CharacterDetailsModel {
        guard let id = id else {
            throw EncodingError.invalidValue(id as Any, EncodingError.Context(codingPath: [],
                                                                              debugDescription: "Required necessary parameter ID"))
        }
        guard let name = name else {
            throw EncodingError.invalidValue(id as Any, EncodingError.Context(codingPath: [],
                                                                              debugDescription: "Required necessary parameter name"))
        }
        return CharacterDetailsModel(id: id,
                                     name: name,
                                     description: description ?? "",
                                     image: try thumbnail?.toDomain(),
                                     comicsCount: comics?.toDomain() ?? 0,
                                     seriesCount: series?.toDomain() ?? 0,
                                     storiesCount: stories?.toDomain() ?? 0,
                                     eventsCount: events?.toDomain() ?? 0)
    }
}
