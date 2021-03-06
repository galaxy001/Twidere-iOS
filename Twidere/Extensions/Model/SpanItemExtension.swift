//
//  SpanItemExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/6.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import YYText

extension LinkSpanItem: CustomDebugStringConvertible {
    var debugDescription: String {
        return "LinkSpanItem(link=\(self.link), display=\(self.display))"
    }
}

extension MentionSpanItem: CustomDebugStringConvertible {
    var debugDescription: String {
        return "MentionSpanItem(key=\(self.key), name=\(self.name), screenName=\(self.screenName))"
    }
}

extension HashtagSpanItem: CustomDebugStringConvertible {
    var debugDescription: String {
        return "HashtagSpanItem(hashtag=\(self.hashtag))"
    }
}

extension Array where Element: SpanItem {
    func applyToAttributedText(_ string: NSMutableAttributedString, displayOption: StatusCell.DisplayOption) {
        for span in self {
            string.yy_setTextHighlight(NSMakeRange(span.start, span.end - span.start), color: displayOption.linkColor, backgroundColor: nil, userInfo: [SpanItem.highlightUserInfoKey: span])
        }
    }
}

extension SpanItem {
    
    static let highlightUserInfoKey: String = "twidere.span"
    
    func createViewController(accountKey: UserKey) -> (UIViewController, Bool)? {
        switch self {
        case let span as LinkSpanItem:
            let vc = SafariBrowserController(url: URL(string: span.link)!)
            return (vc, true)
        case let span as HashtagSpanItem:
            break
        case let span as MentionSpanItem:
            let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileController
            vc.loadUser(userInfo: (accountKey, span.key, span.screenName))
            return (vc, false)
        default:
            break
        }
        return nil
    }
}
