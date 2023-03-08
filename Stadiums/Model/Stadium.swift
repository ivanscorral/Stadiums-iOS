//  Stadium.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 8/3/23.

import Foundation
import Alamofire
import CoreData

public struct Stadium: Codable {
    let id: Int
    let title: String
    let geocoordinates: String
    let image: String
    
    // Computed properties to parse latitude and longitude from geocoordinates string
    var latitude: Double {
        let components = geocoordinates.components(separatedBy: ",")
        return Double(components.first ?? "") ?? 0.0
    }

    var longitude: Double {
        let components = geocoordinates.components(separatedBy: ",")
        return Double(components.last ?? "") ?? 0.0
    }

    // Method to download stadium image asynchronously
    func downloadImage(completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: image) else {
            completion(nil)
            return
        }
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("Failed to download stadium image: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

    // Define CodingKeys enum to map between JSON keys and struct properties
    enum CodingKeys: String, CodingKey {
        case id, title, geocoordinates, image
    }

    // Initialize struct from entity
    init(from entity: StadiumEntity) {
        id = Int(entity.id)
        title = entity.title ?? ""
        geocoordinates = entity.geocoordinates ?? ""
        image = entity.image ?? ""
    }

    // Convert struct to entity
    func toEntity(in context: NSManagedObjectContext) -> StadiumEntity {
        let entity = StadiumEntity(context: context)
        entity.id = Int32(id)
        entity.title = title
        entity.geocoordinates = geocoordinates
        entity.image = image
        return entity
    }

    // Initialize struct from JSON decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idString = try container.decode(String.self, forKey: .id)
        if let id = Int(idString) {
            self.id = id
        } else {
            throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "Invalid id value")
        }
        title = try container.decode(String.self, forKey: .title)
        geocoordinates = try container.decode(String.self, forKey: .geocoordinates)
        image = try container.decode(String.self, forKey: .image)
    }

    // Initialize struct with a string id
    init(id: String, title: String, geocoordinates: String, image: String) {
        self.id = Int(id) ?? 0
        self.title = title
        self.geocoordinates = geocoordinates
        self.image = image
    }

    // Initialize struct with an Int32 id
    init(id: Int32, title: String, geocoordinates: String, image: String) {
        self.id = Int(id)
        self.title = title
        self.geocoordinates = geocoordinates
        self.image = image
    }
}

