// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0

import Foundation
import WebKit
import Shared
import MozillaAppServices

class SavedTab: NSObject, NSCoding {
    var isSelected: Bool
    var title: String?
    var url: URL?
    var isPrivate: Bool
    var sessionData: SessionData?
    var screenshotUUID: UUID?
    var faviconURL: String?
    var UUID: String?
    var tabGroupData: TabGroupData?
    var createdAt: Timestamp?
    var hasHomeScreenshot: Bool

    var jsonDictionary: [String: AnyObject] {
        let title: String = self.title ?? "null"
        let faviconURL: String = self.faviconURL ?? "null"
        let uuid: String = self.screenshotUUID?.uuidString ?? "null"
        
        var json: [String: AnyObject] = [
            "title": title as AnyObject,
            "isPrivate": String(self.isPrivate) as AnyObject,
            "isSelected": String(self.isSelected) as AnyObject,
            "faviconURL": faviconURL as AnyObject,
            "screenshotUUID": uuid as AnyObject,
            "url": url as AnyObject,
            "UUID": self.UUID as AnyObject,
            "tabGroupData": self.tabGroupData as AnyObject,
            "createdAt": self.createdAt as AnyObject,
            "hasHomeScreenshot": String(self.hasHomeScreenshot) as AnyObject
        ]
        
        if let sessionDataInfo = self.sessionData?.jsonDictionary {
            json["sessionData"] = sessionDataInfo as AnyObject?
        }
        
        return json
    }
    
    init?(screenshotUUID: UUID?, isSelected: Bool, title: String?, isPrivate: Bool, faviconURL: String?, url: URL?, sessionData: SessionData?, uuid: String, tabGroupData: TabGroupData?, createdAt: Timestamp?, hasHomeScreenshot: Bool) {

        self.screenshotUUID = screenshotUUID
        self.isSelected = isSelected
        self.title = title
        self.isPrivate = isPrivate
        self.faviconURL = faviconURL
        self.url = url
        self.sessionData = sessionData
        self.UUID = uuid
        self.tabGroupData = tabGroupData
        self.createdAt = createdAt
        self.hasHomeScreenshot = hasHomeScreenshot

        super.init()
    }
    
    required init?(coder: NSCoder) {
        self.sessionData = coder.decodeObject(forKey: "sessionData") as? SessionData
        self.screenshotUUID = coder.decodeObject(forKey: "screenshotUUID") as? UUID
        self.isSelected = coder.decodeBool(forKey: "isSelected")
        self.title = coder.decodeObject(forKey: "title") as? String
        self.isPrivate = coder.decodeBool(forKey: "isPrivate")
        self.faviconURL = coder.decodeObject(forKey: "faviconURL") as? String
        self.url = coder.decodeObject(forKey: "url") as? URL
        self.UUID = coder.decodeObject(forKey: "UUID") as? String
        self.tabGroupData = coder.decodeObject(forKey: "tabGroupData") as? TabGroupData
        self.createdAt = coder.decodeObject(forKey: "createdAt") as? Timestamp
        self.hasHomeScreenshot = coder.decodeBool(forKey: "hasHomeScreenshot")
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(sessionData, forKey: "sessionData")
        coder.encode(screenshotUUID, forKey: "screenshotUUID")
        coder.encode(isSelected, forKey: "isSelected")
        coder.encode(title, forKey: "title")
        coder.encode(isPrivate, forKey: "isPrivate")
        coder.encode(faviconURL, forKey: "faviconURL")
        coder.encode(url, forKey: "url")
        coder.encode(UUID, forKey: "UUID")
        coder.encode(tabGroupData, forKey: "tabGroupData")
        coder.encode(createdAt, forKey: "createdAt")
        coder.encode(hasHomeScreenshot, forKey: "hasHomeScreenshot")
    }
}
