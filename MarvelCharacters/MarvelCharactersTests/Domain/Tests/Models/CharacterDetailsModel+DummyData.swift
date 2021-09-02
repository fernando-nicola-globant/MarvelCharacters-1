import Foundation
@testable import MarvelCharacters

extension CharacterDetailsModel {
    static func dummyModel() -> CharacterDetailsModel {
        CharacterDetailsModel(id: 1011334,
                              name: "3-D Man",
                              description: "",
                              image: URL(string:
                                            "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"),
                              comicsCount: 10,
                              seriesCount: 10,
                              storiesCount: 10,
                              eventsCount: 10)
    }
}
