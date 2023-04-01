//
//  OccurrenceFirebase.swift
//  MyStreet
//
//  Created by Dario Santos on 01/04/2023.
//

import FirebaseFirestore

extension Occurrence {
    static func build(from documents: [QueryDocumentSnapshot]) -> [Occurrence] {
        var occurences = [Occurrence]()
        for document in documents {
            occurences.append(Occurrence(title: document["title"] as? String ?? "",
                                         location: document["description"] as? String ?? "",
                                         type: document["location"] as? String ?? "",
                                         description: document["type"] as? String ?? ""))
        }
        return occurrences
    }
}
