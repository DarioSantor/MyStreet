//
//  Ocurrence.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 14/03/2023.
//

import Foundation

var localizationAuthorization = true


struct Occurrence {
    let title: String
    let location: String
    let type: String
    let description: String
}

class OccurrenceService {

    public static var occurrences: [Occurrence] = []

    init() {
        getOccurrencesFromDatabase { occurrences in
            OccurrenceService.occurrences = occurrences
        }
        
        
        print("getOccurrencesFromDatabase")
        print(OccurrenceService.occurrences)
    }
    
    // MARK: - func to get all Occurences at FireBase
    public func getOccurrencesFromDatabase(completionHandler: @escaping ([Occurrence]) -> Void) {
        REF_OCCURRENCES.observeSingleEvent(of: .value) { (snapshot) in
            var occurrences = [Occurrence]()
            guard let snapshotValue = snapshot.value as? [String: Any] else {
                print("Snapshot value is nil")
                return
            }
            
            // TODO: - ir buscar os multiplos subvalores
            
            for occurrence in snapshotValue {
//                occurrenceData = REF_OCCURRENCES.child(key)
                
                guard let occurrenceData = occurrence.value as? [String: Any],
                      let title = occurrenceData["title"] as? String,
                      let location = occurrenceData["location"] as? String,
                      let type = occurrenceData["type"] as? String,
                      let description = occurrenceData["description"] as? String else {
                    print("Invalid occurrence data")
                    print("value \(occurrence)")
                    continue
                }
                let newOccurrence = Occurrence(title: title, location: location, type: type, description: description)
                occurrences.append(newOccurrence)
            }
            completionHandler(occurrences)
        }
    }
}
