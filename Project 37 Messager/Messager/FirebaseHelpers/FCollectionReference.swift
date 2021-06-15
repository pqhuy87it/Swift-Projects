//
//  FCollectionReference.swift
//  Messager
//
//  Created by David Kababyan on 19/08/2020.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Recent
    case Messages
    case Typing
    case Channel
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
