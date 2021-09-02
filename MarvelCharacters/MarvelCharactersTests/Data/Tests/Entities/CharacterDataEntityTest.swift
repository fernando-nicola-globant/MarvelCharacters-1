import XCTest
@testable import MarvelCharacters

class CharacterDataEntityTest: XCTestCase {
    func testCharactersDataEntityEntityToDomain() {
        let charEntity = CharactersDataEntity(offset: 0,
                                              total: 100,
                                              count: 20,
                                              limit: 20,
                                              results:
                                                [CharacterDetailsEntity(
                                                    id: 1011334,
                                                    name: "3-D Man",
                                                    description: "",
                                                    thumbnail: CharacterImageEntity(
                                                        path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                                                        pathExtension: "jpg"),
                                                    comics: getCount(),
                                                    series: getCount(),
                                                    stories: getCount(),
                                                    events: getCount())])
        XCTAssertNoThrow(try? charEntity.toDomain())
    }

    func testCharactersDataEntityEntityToDomainNoValues() {
        let charEntity = CharactersDataEntity(offset: nil,
                                              total: nil,
                                              count: nil,
                                              limit: nil,
                                              results: nil)
        XCTAssertNoThrow(try? charEntity.toDomain())
    }
    
    func getCount() -> CharacterItemsCountEntity {
        CharacterItemsCountEntity(available: 10)
    }
}

