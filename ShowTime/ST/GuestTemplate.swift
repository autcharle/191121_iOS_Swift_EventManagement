//
//  GuestTemplate.swift
//  ST
//
//  Created by Tuyen Tran on 11/12/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import Foundation
import RealmSwift

class GuestTemplate : Object
{
    @objc dynamic var FirstName: String?
    @objc dynamic var LastName: String?
    @objc dynamic var Guests: String?
    @objc dynamic var Table: String?
    @objc dynamic var Section: String?
    @objc dynamic var isStored: String?
    @objc dynamic var isToDelete: String?
}
