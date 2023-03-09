//
//  StadiumAPI.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 8/3/23.
//

import Alamofire

class StadiumAPI {
    static func fetchStadiums(completion: @escaping (Result<[Stadium], Error>) -> Void) {
        AF.request("https://sergiocasero.es/pois.json").responseDecodable(of: StadiumList.self) { response in
            switch response.result {
            case .success(let stadiumList):
                completion(.success(stadiumList.list))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
