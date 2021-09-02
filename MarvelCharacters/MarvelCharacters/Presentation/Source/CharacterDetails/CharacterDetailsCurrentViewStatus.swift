enum CharacterDetailsCurrentViewStatus: Equatable {
    case clear
    case success(viewModel: CharacterDetailsViewModel? = nil)
    case failure
    case loading
}
