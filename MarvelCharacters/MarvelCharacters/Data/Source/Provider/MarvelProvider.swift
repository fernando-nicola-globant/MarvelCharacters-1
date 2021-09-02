import Moya

typealias ServiceProvider = Moya.MoyaProvider

final class MarvelProvider: MarvelProviderProtocol {
    private let serviceProvider: ServiceProvider<MarvelService>
    
    convenience init() {
        self.init(serviceProvider: ServiceProvider<MarvelService>())
    }
    
    init(serviceProvider: ServiceProvider<MarvelService>) {
        self.serviceProvider = serviceProvider
    }
    
    func getCharacters(offset: Int, completion: @escaping GetCharactersClosure) {
        serviceProvider.request(.characters(offset: offset)) { result in
            switch result {
            case .success(let response):
                do {
                    let charListEntity = try response.map(CharactersDataEntity.self, atKeyPath: "data")
                    try completion(.success(charListEntity.toDomain()))
                } catch {
                    completion(.failure(.mapping(error)))
                }
            case .failure(let error):
                completion(.failure(.generic(error)))
            }
        }
    }
    
    func getCharacterDetails(charID: Int, completion: @escaping GetCharacterDetailsClosure) {
        serviceProvider.request(.characterDetails(charID: charID)) { result in
            switch result {
            case .success(let response):
                do {
                    let charDataEntity = try response.map(CharactersDataEntity.self, atKeyPath: "data")
                    try completion(.success(charDataEntity.toDomain()))
                } catch {
                    completion(.failure(.mapping(error)))
                }
            case .failure(let error):
                completion(.failure(.generic(error)))
            }
        }
    }
}
