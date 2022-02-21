//
//  EventTemplate.swift
//  ST
//
//  Created by Tuyen Tran on 11/12/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import Foundation
import RealmSwift

class EventTemplate : Object
{
    @objc dynamic var Name: String?
    @objc dynamic var FontName: String?
    @objc dynamic var FontSize: String?
    @objc dynamic var FontColor: String?
    @objc dynamic var isStored: String?
}
