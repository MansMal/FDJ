//
//  Team+Model.swift
//  FDJ overview
//
//  Created by Malek Mansour on 17/11/2025.
//

import Foundation

struct TeamsResponse: Decodable {
    let teams: [Team]?
}

struct Team: Identifiable, Decodable {
    var id: String { idTeam }
    
    let idTeam: String
    let strTeam: String
    let strLeague: String?
    let strTeamBadge: String?
}
