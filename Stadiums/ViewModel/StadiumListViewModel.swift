//
//  StadiumListViewModel.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 8/3/23.
//
import Foundation
import CoreData
import SystemConfiguration
import Alamofire

class StadiumListViewModel {
    private let coreDataManager = CoreDataManager(modelName: "Stadiums")
    private var stadiums: [Stadium] = []
    private var filteredStadiums: [Stadium] = []
    private let resetAllowed:Bool = true
    
    var stadiumsDidChange: ((Result<[Stadium], Error>) -> Void)?
    var errorDidChange: ((Error?) -> Void)?
    var isEmpty: Bool {
        return filteredStadiums.isEmpty
    }
    
    func deleteStore() {
        // This method is only for testing and debugging purposes and should not be used in production.
        // It deletes the entire Core Data store and resets it to its default state.
        // Use with caution.
        
        if resetAllowed {
            do {
                try coreDataManager.resetData()
            } catch {
                print("Failed to reset Core Data stack: \(error.localizedDescription)")
            }
        }
    }


    
    /**
     Fetches the list of stadiums from the API or from Core Data, depending on network reachability and availability of local data.
     
     If there is data available in Core Data, it will be used to populate the list of stadiums. Otherwise, if network connectivity is available, the list will be fetched from the API and stored in Core Data. If neither option is available, the list will be empty. If there's an error fetching the stadiums, it notifies the observer with an error.
     */
    func fetchStadiums() {
        // Check if there are stored stadiums in Core Data
        if let storedStadiums = coreDataManager.fetchStadiumEntities(), !storedStadiums.isEmpty {
            // Use stored stadiums to populate the list
            stadiums = storedStadiums.map { Stadium(from: $0) }
            filteredStadiums = stadiums
            stadiumsDidChange?(.success(filteredStadiums))
        }
        // Check if network connectivity is available
        else if NetworkReachability.isConnected() {
            // Fetch stadiums from API
            StadiumAPI.fetchStadiums { [weak self] result in
                switch result {
                case .success(let stadiums):
                    // Update list with fetched stadiums
                    self?.stadiums = stadiums
                    self?.filteredStadiums = stadiums
                    // Save fetched stadiums to Core Data
                    self?.coreDataManager.saveStadiumEntities(stadiums.map { $0.toEntity(in: self!.coreDataManager.container.viewContext) })
                    // Notify observer of successful update
                    self?.stadiumsDidChange?(.success(stadiums))
                case .failure(_):
                    // Notify observer of error
                    let error = NSError(domain: "Stadiums", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch stadiums. Please try again later."])
                    self?.errorDidChange?(error)
                }
            }
        }
        // No data available
        else {
            // Notify observer of error
            let error = NSError(domain: "Stadiums", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data available. Please connect to the internet to fetch stadiums."])
            self.errorDidChange?(error)
        }
    }
    
    /**
     Filters the list of stadiums by title, using a case-insensitive search.
     
     - Parameter searchText: The text to search for in the titles of the stadiums.
     */
    func filterStadiums(_ searchText: String) {
        if searchText.isEmpty {
            filteredStadiums = stadiums
        } else {
            // Filter stadiums by title
            let filteredSet = Set(stadiums.filter { $0.title.localizedCaseInsensitiveContains(searchText) })
            filteredStadiums = Array(filteredSet)
        }
        // Notify observer of filtered stadiums
        stadiumsDidChange?(.success(filteredStadiums))
    }


    /**
     Returns the stadium at the specified index, if it exists in the filtered list of stadiums.
     
     Parameter index: The index of the desired stadium.
     
     Returns: The stadium at the specified index, or nil if the index is out of bounds.
     */
    func stadium(at index: Int) -> Stadium? {
        if index >= 0 && index < filteredStadiums.count {
            return filteredStadiums[index]
        } else {
            return nil
        }
    }
}
