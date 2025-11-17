//
//  Team+ViewModel.swift
//  FDJ overview
//
//  Created by Malek Mansour on 17/11/2025.
//

import Foundation
import Combine


final class TeamsViewModel: ObservableObject {
    @Published var teams: [Team] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiClient: SportsAPIClientProtocol
    private let league: League
    
    init(league: League, apiClient: SportsAPIClientProtocol = SportsAPIClient()) {
        self.league = league
        self.apiClient = apiClient
    }
    
    func loadTeams() {
        Task {
            await fetchTeams()
        }
    }
    
    private func fetchTeams() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedTeams = try await apiClient.fetchTeams(forLeague: league.strLeague)
            
            // 1) Tri anti-alphabétique (Z -> A)
            let sorted = fetchedTeams.sorted { $0.strTeam > $1.strTeam }
            
            // 2) Afficher 1 équipe sur 2 (ici on garde celles d’index pair)
            let filtered = sorted.enumerated()
                .compactMap { index, team in
                    index % 2 == 0 ? team : nil
                }
            
            teams = filtered
        } catch {
            errorMessage = "Impossible de charger les équipes."
        }
        
        isLoading = false
    }
}
