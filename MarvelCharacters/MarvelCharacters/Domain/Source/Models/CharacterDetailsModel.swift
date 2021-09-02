import Foundation

struct CharacterDetailsModel: Equatable {
    let id: Int
    let name: String
    let description: String
    let image: URL?
    let comicsCount: Int
    let seriesCount: Int
    let storiesCount: Int
    let eventsCount: Int
    
    init(id: Int,
         name: String,
         description: String,
         image: URL?,
         comicsCount: Int,
         seriesCount: Int,
         storiesCount: Int,
         eventsCount: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.comicsCount = comicsCount
        self.seriesCount = seriesCount
        self.storiesCount = storiesCount
        self.eventsCount = eventsCount
    }
}
