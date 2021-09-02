import Foundation

struct CharacterImageEntity: Decodable {
    let path: String?
    let pathExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case pathExtension = "extension"
    }

    func toDomain() throws -> URL? {
        let path = (path ?? "") + "." + (pathExtension ?? "")
        return URL(string: path)
    }
}
