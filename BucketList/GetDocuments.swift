//
//  GetDocuments.swift
//  BucketList
//
//  Created by Brandon Knox on 5/20/21.
//

import Foundation

extension FileManager {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
