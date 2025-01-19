//
//  MovieStorage.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import CoreData

protocol MovieStorageProtocol {
    func add(_ movie: Movie)
    func listAll() -> [FavoriteMovie]
    func getById(_ idMovie: Int) -> FavoriteMovie?
    func delete(_ idMovie: Int)
    func saveChanges()
}

struct MovieStorage: MovieStorageProtocol {
    
    let dataManager: DataManager
    
    private var context: NSManagedObjectContext {
        return self.dataManager.presistentContainer.viewContext
    }
    
    func add(_ movie: Movie) {
        let objDM = NSEntityDescription.insertNewObject(forEntityName: "FavoriteMovie", into: self.context) as? FavoriteMovie
        objDM?.title = movie.title
        objDM?.id = Int32(movie.idMovie)
        objDM?.posterPath = movie.posterPath
        objDM?.voteAverage = Int16(movie.voteAverage)
        objDM?.releaseDate = movie.releaseDateString
    }
    
    func listAll() -> [FavoriteMovie] {
        
        let fetchRequest = FavoriteMovie.fetchRequest()
        
        let sortTitle = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortTitle]
        
        let result = try? self.context.fetch(fetchRequest)
        return result ?? []
    }

    func getById(_ idMovie: Int) -> FavoriteMovie? {
        
        let fetchRequest = FavoriteMovie.fetchRequest()
        
        let predicate = NSPredicate(format: "id == %d", idMovie)
        fetchRequest.predicate = predicate
        
        let result = try? self.context.fetch(fetchRequest)
        return result?.first
    }
    
    func delete(_ idMovie: Int) {
        guard let movie = self.getById(idMovie) else { return }
        self.context.delete(movie)
    }
    
    func saveChanges() {
        self.dataManager.saveContext()
    }
}
