//
//  CoreDataManager.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 8/3/23.
//

import CoreData

public class CoreDataManager {
    public let container: NSPersistentContainer
    
    public init(modelName: String = "Stadiums") {
        // Initialize the persistent container with the provided model name or the default model name
        container = NSPersistentContainer(name: modelName)
        
        // Load the persistent stores asynchronously and check for errors
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                do {
                    try self.resetData()
                } catch {
                    fatalError("Failed to reset Core Data stack: \(error.localizedDescription)")
                }
                fatalError("Failed to load Core Data stack: \(error.localizedDescription)")
                
            }
            
        }
    }
    
    /// Fetches an array of Stadium objects from Core Data.
    public func fetchStadiums() -> [Stadium]? {
        // Fetch an array of StadiumEntity objects from Core Data.
        let entities = fetchStadiumEntities()
        
        // Convert the fetched entities to Stadium objects and return the resulting array.
        return entities?.compactMap { $0.toModel() }.sorted { $0.id < $1.id }
    }
    
    /// Saves an array of Stadium objects to Core Data.
    public func saveStadiums(_ stadiums: [Stadium]) {
        // Convert the provided Stadium objects to an array of StadiumEntity objects.
        let entities = stadiums.map { $0.toEntity(in: container.viewContext) }
        
        // Save the StadiumEntity objects to Core Data.
        saveStadiumEntities(entities)
    }
    
    /// Fetches an array of StadiumEntity objects from Core Data.
    public func fetchStadiumEntities() -> [StadiumEntity]? {
        // Create a fetch request for StadiumEntity objects.
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "StadiumEntity")
        
        do {
            // Fetch the entities from Core Data and return them.
            let result = try container.viewContext.fetch(request)
            return result as? [StadiumEntity]
        } catch {
            print("Failed to fetch stadiums: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Saves an array of StadiumEntity objects to Core Data.
    public func saveStadiumEntities(_ stadiums: [StadiumEntity]) {
        // Create a new background context for the operation.
        let context = container.newBackgroundContext()

        do {
            for entity in stadiums {
                // Check if a StadiumEntity with the same ID already exists in the database.
                let request: NSFetchRequest<StadiumEntity> = StadiumEntity.fetchRequest()
                request.predicate = NSPredicate(format: "id = %d", entity.id)

                if let existingEntity = try context.fetch(request).first {
                    // An entity with the same ID exists, update its properties.
                    existingEntity.title = entity.title
                    existingEntity.geocoordinates = entity.geocoordinates
                    existingEntity.image = entity.image
                } else {
                    // No entity with the same ID exists, create a new one.
                    let newEntity = StadiumEntity(context: context)
                    newEntity.id = entity.id
                    newEntity.title = entity.title
                    newEntity.geocoordinates = entity.geocoordinates
                    newEntity.image = entity.image
                }
            }

            // Save the changes to Core Data.
            try context.save()
        } catch {
            print("Failed to save stadiums: \(error.localizedDescription)")
        }
    }
	

    
    public func resetData() throws {
        let coordinator = container.persistentStoreCoordinator
        let persistentStores = coordinator.persistentStores
        let storeDescriptions = container.persistentStoreDescriptions
        
        for store in persistentStores {
            try coordinator.destroyPersistentStore(at: store.url!, ofType: store.type, options: nil)
        }
        
        container.persistentStoreDescriptions = storeDescriptions
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error.localizedDescription)")
            }
        }
    }
}

extension StadiumEntity {
    
    /// Converts a StadiumEntity object to a Stadium object.
    func toModel() -> Stadium {
        return Stadium(id: id,
                       title: title ?? "",
                       geocoordinates: geocoordinates ?? "",
                       image: image ?? "")
    }
    
    /// Updates the values of a StadiumEntity object with the values of a Stadium object.
    func update(with stadium: Stadium) {
        id = Int32(stadium.id)
        title = stadium.title
        geocoordinates = stadium.geocoordinates
        image = stadium.image
    }
    
}

extension NSManagedObjectContext {
    
    /// Converts a StadiumEntity object to a Stadium object using the context's model.
    ///
    /// - Parameter entity: The StadiumEntity to convert.
    /// - Returns: The converted Stadium object.
    func toModel(_ entity: StadiumEntity) -> Stadium {
        // Use the properties of the entity to initialize a new Stadium object.
        return Stadium(id: Int32(entity.id),
                       title: entity.title ?? "",
                       geocoordinates: entity.geocoordinates ?? "",
                       image: entity.image ?? "")
    }
}
