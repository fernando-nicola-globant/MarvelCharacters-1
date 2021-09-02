enum ErrorCases: Error {
    case mapping(Swift.Error)
    case network(Swift.Error)
    case underlying(Swift.Error)
    case networkTimeout(Swift.Error)
    case generic(Swift.Error)
}
