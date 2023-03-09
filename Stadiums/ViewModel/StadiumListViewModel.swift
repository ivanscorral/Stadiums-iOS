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
    
    var stadiumsDidChange: ((Result<[Stadium], Error>) -> Void)?
    var errorDidChange: ((Error?) -> Void)?
    var isEmpty: Bool {
        return filteredStadiums.isEmpty
    }
    
    /**
     Fetches the list of stadiums from the API or from Core Data, depending on network reachability and availability of local data.
     
     If there is data available in Core Data, it will be used to populate the list of stadiums. Otherwise, if network connectivity is available, the list will be fetched from the API and stored in Core Data. If neither option is available, the list will be empty.
     */
    func fetchStadiums() {
        if let storedStadiums = coreDataManager.fetchStadiumEntities() {
            stadiums = storedStadiums.map { Stadium(from: $0) }
            filteredStadiums = stadiums
            stadiumsDidChange?(.success(filteredStadiums))
        } else if NetworkReachability.isConnected() {
            StadiumAPI.fetchStadiums { [weak self] result in
                switch result {
                case .success(let stadiums):
                    self?.stadiums = stadiums
                    self?.filteredStadiums = stadiums
                    self?.coreDataManager.saveStadiumEntities(stadiums.map { $0.toEntity(in: self!.coreDataManager.container.viewContext) })
                    self?.stadiumsDidChange?(.success(stadiums))
                case .failure(let error):
                    print("Failed to fetch stadiums: \(error.localizedDescription)")
                    self?.errorDidChange?(error)
                }
            }
        } else {
            let error = NSError(domain: "Stadiums", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data available"])
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
            filteredStadiums = stadiums.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        stadiumsDidChange?(.success(filteredStadiums))
    }
    
    /**
     Returns the stadium at the specified index, if it exists in the filtered list of stadiums.
     
     - Parameter index: The index of the desired stadium.
     
     - Returns: The stadium at the specified index, or `nil` if the index is out of bounds.
     */
    func stadium(at index: Int) -> Stadium? {
        if index >= 0 && index < filteredStadiums.count {
            return filteredStadiums[index]
        } else {
            return nil
        }
    }
}

/**
 A helper class for checking network reachability.
 
 This class provides a simple way to check whether the device is currently connected to a network with internet access. The `isConnected()` method uses the `SystemConfiguration` framework to determine whether the device is connected to a network with internet access. If the device is connected to a network with internet access, the method returns `true`, otherwise it returns `false`.
 
 - Note: This class does not provide real-time network monitoring. It only checks whether the device is currently connected to a network with internet access at the time of the method call.
 */

class NetworkReachability {
    
    /**
     Determines whether the device is currently connected to a network with internet access.
     
     - Returns: `true` if the device is connected to a network with internet access, `false` otherwise.
     */
    static func isConnected() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            print("Error creating default route reachability")
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            print("Error getting network reachability flags")
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}
