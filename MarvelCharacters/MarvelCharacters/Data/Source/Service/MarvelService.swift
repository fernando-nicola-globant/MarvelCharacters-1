import CryptoKit
import Foundation
import Moya

enum MarvelService {
    static private let publicKey = "48689cecf6a8324154f537ee75fd0317"
    static private let hash = "18994a2f75041c01ed786c44695992c6"
    static private let ts = "1"
    static private let bundle = "abc.MarvelCharacters.MarvelCharactersTests"
    
    case characters(offset: Int)
    case characterDetails(charID: Int)
}

extension MarvelService: TargetType {
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com/v1/public")!
    }
    
    var path: String {
        switch self {
        case .characters: return "/characters"
        case .characterDetails(let charID): return "characters/\(charID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .characters, .characterDetails: return .get
        }
    }
    
    var mockName: String? {
        switch self {
        case .characters:
            return "Characters"
        case .characterDetails:
            return "CharacterDetails"
        }
    }
    
    var mockExtension: String? {
        return "json"
    }
    
    var sampleData: Data {
        guard let mockBundle = Bundle(identifier: MarvelService.bundle),
              let url = mockBundle.url(forResource: mockName, withExtension: mockExtension),
              let data = try? Data(contentsOf: url) else {
            return Data()
        }
        return data
    }
    
    var task: Task {
        var authParams = ["apikey": MarvelService.publicKey,
                          "ts": MarvelService.ts,
                          "hash": MarvelService.hash] as [String : Any]
        
        switch self {
        case .characters(let offset):
            authParams.updateValue(offset, forKey: "offset")
            return .requestParameters(
                parameters: authParams,
                encoding: URLEncoding.default)
        case .characterDetails:
            return .requestParameters(
                parameters: authParams,
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}


