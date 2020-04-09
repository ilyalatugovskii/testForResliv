//
//  CoreDataManager.swift
//  weather
//
//  Created by Ilya Latugovskii on 07.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    private func fill(managedObject: NSManagedObject, value: Any, forKey key: String) {
          managedObject.setValue(value, forKey: key)
      }
}
