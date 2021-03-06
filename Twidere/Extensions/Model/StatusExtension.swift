//
//  FlatStatusExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

func < (lhs: Status, rhs: Status) -> Bool {
    return lhs.sortId < rhs.sortId
}

func > (lhs: Status, rhs: Status) -> Bool {
    return lhs.sortId > rhs.sortId
}

func == (lhs: Status, rhs: Status) -> Bool {
    return lhs.accountKey == rhs.accountKey && lhs.sortId == rhs.sortId
}

extension Status {
    
    func userProfileImageForSize(_ size: ProfileImageSize) -> String? {
        guard let url = userProfileImage else {
            return nil
        }
        return getProfileImageUrlForSize(url, size: size)
    }
    
    func quotedUserProfileImageForSize(_ size: ProfileImageSize) -> String? {
        guard let url = quotedUserProfileImage else {
            return nil
        }
        return getProfileImageUrlForSize(url, size: size)
    }
    
    var quotedStatus: Status? {
        guard let quotedId = self.quotedId else {
            return nil
        }
        let quoted = Status()
        quoted.id = quotedId
        quoted.createdAt = self.quotedCreatedAt
        quoted.sortId = self.generateSortId(rawId: -1)
        quoted.accountKey = self.accountKey
        quoted.userKey = self.quotedUserKey
        quoted.userName = self.quotedUserName
        quoted.userScreenName = self.quotedUserScreenName
        quoted.userProfileImage = self.quotedUserProfileImage
        quoted.textPlain = self.quotedTextPlain
        quoted.textDisplay = self.quotedTextDisplay
        quoted.metadata = self.quotedMetadata
        return quoted
    }
}
