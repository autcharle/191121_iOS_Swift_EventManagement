//
//  DataService.swift
//  ST
//
//  Created by Tuyen Tran on 11/12/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import Foundation
import RealmSwift

class DataService
{
    let storedBool = ["0","1"]
    func makeEvent(name: String, fontName: String, fontSize: String, fontColor: String) -> EventTemplate
    {
        let event = EventTemplate()
        event.Name = name
        event.FontName = fontName
        event.FontSize = fontSize
        event.FontColor = fontColor
        event.isStored = storedBool[1]
        return event
    }
    
    func makeGuest(firstName: String, lastName: String, guests: String, table: String, section: String) -> GuestTemplate
    {
        let guest = GuestTemplate()
        guest.FirstName = firstName
        guest.LastName = lastName
        guest.Guests = guests
        guest.Table = table
        guest.Section = section
        guest.isStored = storedBool[0]
        guest.isToDelete = storedBool[0]
        return guest
    }
    
    func deleteData()
    {
        let realm = try! Realm()
        if realm.objects(EventTemplate.self).count > 0
        {
            let data = realm.objects(EventTemplate.self)
            try! realm.write
            {
                for d in data
                {
                    if (d.isStored == storedBool[0])
                    {
                        realm.delete(d)
                    }
                }
            }
        }
        if realm.objects(GuestTemplate.self).count > 0
        {
            let data = realm.objects(GuestTemplate.self)
            try! realm.write
            {
                for d in data
                {
                    if (d.isStored == storedBool[0])
                    {
                        realm.delete(d)
                    }
                }
            }
        }
    }
    
    func deleteAllData()
    {
        let realm = try! Realm()
        if realm.objects(EventTemplate.self).count > 0
        {
            let data = realm.objects(EventTemplate.self)
            try! realm.write
            {
                realm.delete(data)
            }
        }
        if realm.objects(GuestTemplate.self).count > 0
        {
            let data = realm.objects(GuestTemplate.self)
            try! realm.write
            {
                realm.delete(data)
            }
        }
    }
    
    func addData(name: String, fontName: String, fontSize: String, fontColor: String)
    {
        let realm = try! Realm()
        try! realm.write
        {
            if realm.objects(EventTemplate.self).isEmpty
            {
                let newEvent = self.makeEvent(name: name, fontName: fontName, fontSize: fontSize, fontColor: fontColor)
                realm.add(newEvent)
            }
            else
            {
                self.updateData(name: name, fontName: fontName, fontSize: fontSize, fontColor: fontColor)
            }
        }
    }
    
    func updateData(name: String, fontName: String, fontSize: String, fontColor: String)
    {
        let realm = try! Realm()
        let data = realm.objects(EventTemplate.self)[0]
        data.Name = name
        data.FontName = fontName
        data.FontSize = fontSize
        data.FontColor = fontColor
    }
    
    func addRecord(firstName: String, lastName: String, guests: String, table: String, section: String)
    {
        let realm = try! Realm()
        let newGuest = self.makeGuest(firstName: firstName, lastName: lastName, guests: guests, table: table, section: section)
        try! realm.write
        {
            realm.add(newGuest)
        }
    }
    
    func confirmRecordStored()
    {
        let realm = try! Realm()
        let data = realm.objects(GuestTemplate.self)
        try! realm.write
        {
            for d in data
            {
                d.isStored = storedBool[1]
            }
        }
    }
    
    func confirmRecordToDelete(indexPathRow: Int)
    {
        let realm = try! Realm()
        let data = realm.objects(GuestTemplate.self)[indexPathRow]
        try! realm.write
        {
            data.isToDelete = storedBool[1]
        }
    }
    
    func confirmRecordNotToDelete(indexPathRow: Int)
    {
        let realm = try! Realm()
        let data = realm.objects(GuestTemplate.self)[indexPathRow]
        try! realm.write
        {
            data.isToDelete = storedBool[0]
        }
    }
    
    func isToDelete(index : Int) -> Bool
    {
        let realm = try! Realm()
        let data = realm.objects(GuestTemplate.self)[index]
        if data.isToDelete == storedBool[0]
        {
            return false
        }
        else
        {
            return true
            
        }
    }
    
    func eventIsEmpty() -> Bool
    {
        let realm = try! Realm()
        let data = realm.objects(EventTemplate.self)
        if data.isEmpty
        {
            return true
        }
        else
        {
            return false
        }
    }
}
