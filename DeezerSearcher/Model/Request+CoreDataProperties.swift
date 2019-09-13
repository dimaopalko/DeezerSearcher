//
//  Request+CoreDataProperties.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 9/12/19.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//
//

import Foundation
import CoreData


extension Request {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Request> {
        return NSFetchRequest<Request>(entityName: "Request")
    }

    @NSManaged public var text: String

}
