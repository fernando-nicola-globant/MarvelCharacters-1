import Foundation

struct CharacterDetailsViewModel: Equatable {
    let id: Int
    let name: String
    let description: String
    let image: URL?
    let comicsCount: String
    let seriesCount: String
    let storiesCount: String
    let eventsCount: String
}
