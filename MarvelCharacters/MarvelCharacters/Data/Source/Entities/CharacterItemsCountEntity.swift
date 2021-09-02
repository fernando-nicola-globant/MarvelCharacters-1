struct CharacterItemsCountEntity: Decodable {
    let available: Int?

    func toDomain() -> Int {
        return available ?? 0
    }
}
