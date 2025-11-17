//
//  APIClientService.swift
//  FDJ overview
//
//  Created by Malek Mansour on 17/11/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case network(Error)
    case decoding(Error)
    case unknown
}

protocol SportsAPIClientProtocol {
    func fetchLeagues() async throws -> [League]
    func fetchTeams(forLeague leagueName: String) async throws -> [Team]
}

final class SportsAPIClient: SportsAPIClientProtocol {
    private let baseURL = "https://www.thesportsdb.com/api/v1/json/123"
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchLeagues() async throws -> [League] {
        guard let url = URL(string: "\(baseURL)/all_leagues.php") else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let decoded = try JSONDecoder().decode(AllLeaguesResponse.self, from: data)
            return decoded.leagues
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch {
            throw APIError.network(error)
        }
    }
    
    func fetchTeams(forLeague leagueName: String) async throws -> [Team] {
        guard let encodedLeague = leagueName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/search_all_teams.php?l=\(encodedLeague)") else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let decoded = try JSONDecoder().decode(TeamsResponse.self, from: data)
            return decoded.teams ?? []
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch {
            throw APIError.network(error)
        }
    }
}
