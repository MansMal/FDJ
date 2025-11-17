//
//  League+Model.swift
//  FDJ overview
//
//  Created by Malek Mansour on 17/11/2025.
//


import Foundation

struct AllLeaguesResponse: Decodable {
    let leagues: [League]
}

struct League: Identifiable, Decodable {
    var id: String { idLeague }
    
    let idLeague: String
    let strLeague: String
    let strSport: String?
    let strLeagueAlternate: String?
}
