struct CharactersDataModel: Equatable {
    let total: Int
    let offset: Int
    let count: Int
    let limit: Int
    let result: [CharacterDetailsModel]?
    
    init(total: Int,
         offset: Int,
         count: Int,
         limit: Int,
         result: [CharacterDetailsModel]?) {
        self.total = total
        self.offset = offset
        self.count = count
        self.limit = limit
        self.result = result
    }
}
