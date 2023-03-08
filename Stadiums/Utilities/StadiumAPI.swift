//
//  StadiumAPI.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 8/3/23.
//

import Alamofire

class StadiumAPI {
    static func fetchStadiums(completion: @escaping ([Stadium]) -> Void) {
        AF.request("https://sergiocasero.es/pois.json").responseDecodable(of: StadiumList.self) { response in
            switch response.result {
            case .success(let stadiumList):
                completion(stadiumList.list)
            case .failure(let error):
                print("Failed to fetch stadiums: \(error.localizedDescription)")
                completion([])
            }
        }
    }
}
