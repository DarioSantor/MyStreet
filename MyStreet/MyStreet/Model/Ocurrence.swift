//
//  Ocurrence.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 14/03/2023.
//

import Foundation

var localizationAuthorization = true


struct Occurrence: Codable {
    let ref: String
    let latitude: String
    let longitude: String
    let title: String
    let location: String
    let type: String
    let description: String
    let imageUrl: String?
    let userUID: String
    let observation: String
    var state: Bool
}

struct OccurrenceList: Codable {
    var items: [Occurrence]
}

class OccurrenceService {
    
    public static var occurrences: [Occurrence] = []
    
    init() {
        getOccurrencesFromDatabase { occurrences, isEmpty in
            OccurrenceService.occurrences = occurrences
            print("got occurrences from database:")
            print(OccurrenceService.occurrences)
        }
    }
    
    // MARK: - func to get all Occurrences at FireBase
    public func getOccurrencesFromDatabase(completionHandler: @escaping ([Occurrence], Bool) -> Void) {
        REF_OCCURRENCES.observeSingleEvent(of: .value) { (snapshot) in
            var occurrences = [Occurrence]()
            guard let snapshotValue = snapshot.value as? [String: Any] else {
                print("Snapshot value is nil")
                completionHandler([], true)
                return
            }
            
            for occurrence in snapshotValue {
                guard let occurrenceData = occurrence.value as? [String: Any] else {
                    print("Invalid occurrence data")
                    print("value invalid \(occurrence)")
                    continue
                }
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: occurrenceData, options: [])
                    let occurrence = try JSONDecoder().decode(Occurrence.self, from: jsonData)
                    occurrences.append(occurrence)
                } catch let error {
                    print("Error decoding occurrence: \(error.localizedDescription)")
                }
            }
            
            
            completionHandler(occurrences, occurrences.isEmpty)
            
        }
    }
}
