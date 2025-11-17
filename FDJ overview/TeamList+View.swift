//
//  TeamList+View.swift
//  FDJ overview
//
//  Created by Malek Mansour on 17/11/2025.
//

import Foundation
import SwiftUI

struct TeamsListView: View {
    let league: League
    @StateObject private var viewModel: TeamsViewModel
    
    init(league: League) {
        self.league = league
        _viewModel = StateObject(wrappedValue: TeamsViewModel(league: league))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Chargement des équipes…")
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else if viewModel.teams.isEmpty {
                Text("Aucune équipe trouvée.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                List(viewModel.teams) { team in
                    HStack(spacing: 12) {
                        // Optionnel: affichage du logo si disponible
                        if let badgeURLString = team.strTeamBadge,
                           let url = URL(string: badgeURLString) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 40, height: 40)
                            .cornerRadius(4)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(team.strTeam)
                                .font(.headline)
                            if let leagueName = team.strLeague {
                                Text(leagueName)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(league.strLeague)
        .onAppear {
            if viewModel.teams.isEmpty {
                viewModel.loadTeams()
            }
        }
    }
}
