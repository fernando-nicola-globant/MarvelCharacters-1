import Foundation
@testable import MarvelCharacters

extension CharactersDataModel {
    static func dummyModel() -> CharactersDataModel {
        CharactersDataModel(total: 100,
                            offset: 0,
                            count: 20,
                            limit: 20,
                            result: [CharacterDetailsModel(id: 1011334,
                                                           name: "3-D Man",
                                                           description: "",
                                                           image: URL(string:
                                                                        "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"),
                                                           comicsCount: 10,
                                                           seriesCount: 10,
                                                           storiesCount: 10,
                                                           eventsCount: 10)])
    }
}
