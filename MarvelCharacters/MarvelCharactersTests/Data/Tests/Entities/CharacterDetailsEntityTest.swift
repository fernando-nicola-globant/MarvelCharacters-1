import XCTest
@testable import MarvelCharacters

class CharacterDetailsEntityTest: XCTestCase {
    func testCharacterDetailsEntityToDomain() {
        let charEntity = CharacterDetailsEntity(id: 1011334,
                                                name: "3-D Man",
                                                description: "",
                                                thumbnail: CharacterImageEntity(
                                                    path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                                                    pathExtension: "jpg"),
                                                comics: getCount(),
                                                series: getCount(),
                                                stories: getCount(),
                                                events: getCount())
        XCTAssertNoThrow(try? charEntity.toDomain())
    }

    func getCount() -> CharacterItemsCountEntity {
        CharacterItemsCountEntity(available: 10)
    }

    func testCharacterDetailsEntityToDomainNoName() {
        let charEntity = CharacterDetailsEntity(id: 1011334,
                                                name: nil,
                                                description: "",
                                                thumbnail: CharacterImageEntity(
                                                    path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                                                    pathExtension: "jpg"),
                                                comics: getCount(),
                                                series: getCount(),
                                                stories: getCount(),
                                                events: getCount())
        XCTAssertThrowsError(try charEntity.toDomain())
    }

    func testCharacterDetailsEntityToDomainNoID() {
        let charEntity = CharacterDetailsEntity(id: nil,
                                                name: "3D",
                                                description: "",
                                                thumbnail: CharacterImageEntity(
                                                    path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                                                    pathExtension: "jpg"),
                                                comics: getCount(),
                                                series: getCount(),
                                                stories: getCount(),
                                                events: getCount())
        XCTAssertThrowsError(try charEntity.toDomain())
    }

    func testCharacterDetailsEntityToDomainNoCount() {
        let charEntity = CharactersDataEntity(offset: 0, total: 100,
                                              count: 20,
                                              limit: 20,
                                              results:
                                                [CharacterDetailsEntity(
                                                    id: 1011334,
                                                    name: "3-D Man",
                                                    description: "",
                                                    thumbnail: CharacterImageEntity(
                                                        path: nil,
                                                        pathExtension: nil),
                                                    comics: getCount(),
                                                    series: getCount(),
                                                    stories: getCount(),
                                                    events: getCount())])
        XCTAssertNoThrow(try? charEntity.toDomain())
    }

    func testCharacterDetailsEntityToDomainNoImage() {
        let charEntity = CharactersDataEntity(offset: 0, total: 100,
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
                                                    comics: nil,
                                                    series: nil,
                                                    stories: nil,
                                                    events: nil)])
        XCTAssertNoThrow(try? charEntity.toDomain())
    }
}


