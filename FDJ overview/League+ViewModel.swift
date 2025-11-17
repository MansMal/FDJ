//
//  League+ViewModel.swift
//  FDJ overview
//
//  Created by Malek Mansour on 17/11/2025.
//

import Foundation
import Combine

final class LeagueSearchViewModel: ObservableObject {
    
    @Published var allLeagues: [League] = []
    @Published var searchText: String = ""
    @Published var filteredLeagues: [League] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedLeague: League?
    
    private let apiClient: SportsAPIClientProtocol
    
    init(apiClient: SportsAPIClientProtocol = SportsAPIClient()) {
        self.apiClient = apiClient
    }
    
    func loadLeagues() {
        Task {
            await fetchLeagues()
        }
    }
    
    private func fetchLeagues() async {
        isLoading = true
        errorMessage = nil
        do {
            let leagues = try await apiClient.fetchLeagues()
            allLeagues = leagues
            applyFilter()
        } catch {
            errorMessage = "Impossible de charger les leagues."
        }
        isLoading = false
    }
    
    func updateSearchText(_ text: String) {
        searchText = text
        applyFilter()
    }
    
    private func applyFilter() {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            // Par défaut, on peut afficher toutes les leagues ou aucune.
            filteredLeagues = allLeagues
        } else {
            filteredLeagues = allLeagues.filter { league in
                league.strLeague.localizedCaseInsensitiveContains(trimmed)
            }
        }
    }
}
