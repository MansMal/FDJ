//
//  ContentView.swift
//  FDJ overview
//
//  Created by Malek Mansour on 17/11/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LeagueSearchViewModel()
       
       var body: some View {
           NavigationView {
               VStack(spacing: 0) {
                   searchField
                   
                   if viewModel.isLoading {
                       ProgressView("Chargement des leagues…")
                           .padding()
                   } else if let error = viewModel.errorMessage {
                       Text(error)
                           .foregroundColor(.red)
                           .padding()
                   } else {
                       leaguesList
                   }
                   
                   Spacer()
               }
               .navigationTitle("Paris Sportifs")
               .onAppear {
                   if viewModel.allLeagues.isEmpty {
                       viewModel.loadLeagues()
                   }
               }
           }
       }
       
       private var searchField: some View {
           TextField("Rechercher une league…", text: Binding(
               get: { viewModel.searchText },
               set: { viewModel.updateSearchText($0) }
           ))
           .textFieldStyle(.roundedBorder)
           .padding()
       }
       
       private var leaguesList: some View {
           List(viewModel.filteredLeagues) { league in
               NavigationLink(
                   destination: TeamsListView(league: league)
               ) {
                   VStack(alignment: .leading, spacing: 4) {
                       Text(league.strLeague)
                           .font(.headline)
                       if let sport = league.strSport {
                           Text(sport)
                               .font(.subheadline)
                               .foregroundColor(.secondary)
                       }
                   }
               }
           }
           .listStyle(.plain)
       }
}

#Preview {
    ContentView()
}
