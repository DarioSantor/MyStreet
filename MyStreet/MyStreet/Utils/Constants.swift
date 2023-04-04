//
//  Constants.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 20/03/2023.
//

import Firebase
import FirebaseStorage

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_OCCURRENCES = DB_REF.child("occurrences")
let ADMIN_UID = "mcyQBeOYL2ONDPedBeO9K95SQ5E2"
let STORAGE_REF = Storage.storage().reference()
let STORAGE_OCCURRENCES_IMAGES = STORAGE_REF.child("occurrence_images")
