//
//  DetailStatusCell.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import YYText
import DateTools
import ALSLayouts

class DetailStatusCell: ALSTableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameView: YYLabel!
    @IBOutlet weak var timeSourceView: YYLabel!
    @IBOutlet weak var textView: YYLabel!
    @IBOutlet weak var mediaPreview: MediaPreviewContainer!
    @IBOutlet weak var quotedView: ALSLinearLayout!
    @IBOutlet weak var quotedNameView: YYLabel!
    @IBOutlet weak var quotedTextView: YYLabel!
    @IBOutlet weak var quotedMediaPreview: MediaPreviewContainer!
    @IBOutlet weak var statusToolbar: UIToolbar!

    var displayOption: StatusCell.DisplayOption! {
        didSet {
            userNameView.font = UIFont.systemFont(ofSize: displayOption.fontSize * 1.1)
            timeSourceView.font = UIFont.systemFont(ofSize: displayOption.fontSize * 0.9)
            textView.font = UIFont.systemFont(ofSize: displayOption.fontSize * 1.1)
        }
    }

    override func awakeFromNib() {
        textView.numberOfLines = 0
        quotedTextView.numberOfLines = 0
        
        
        userProfileImageView.makeCircular()
        
        // border radius
        quotedView.layer.cornerRadius = 4.0
        
        // border
        quotedView.layer.borderColor = UIColor.lightGray.cgColor
        quotedView.layer.borderWidth = 0.5
        
        userNameView.numberOfLines = 1
        timeSourceView.numberOfLines = 1
        fd_enforceFrameLayout = true
        
        statusToolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        statusToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        self.contentView.layoutMargins = UIEdgeInsets.zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset = UIEdgeInsets.zero
    }

    func display(_ status: Status) {
        userNameView.attributedText = StatusCell.createNameText(16, name: status.userName, screenName: status.userScreenName, separator: " ")
        timeSourceView.attributedText = createTimeSourceText(status.createdAt)
        userProfileImageView.displayImage(status.userProfileImageForSize(.reasonablySmall))

        textView.attributedText = StatusCell.createStatusText(status.textDisplay, displayOption: self.displayOption, metadata: status.metadata, displayRange: status.metadata?.displayRange)
        mediaPreview.displayMedia(status.metadata?.media)
        
        if (status.quotedId != nil) {
            quotedNameView.attributedText = StatusCell.createNameText(quotedNameView.font.pointSize, name: status.quotedUserName!, screenName: status.quotedUserScreenName!, separator: " ")
            if (displayOption.linkHighlight) {
                quotedTextView.attributedText = StatusCell.createStatusText(status.quotedTextDisplay!, displayOption: self.displayOption, metadata: status.quotedMetadata, displayRange: status.quotedMetadata?.displayRange)
            } else {
                quotedTextView.text = status.quotedTextDisplay
            }
            quotedMediaPreview.displayMedia(status.quotedMetadata?.media)
            quotedView.layoutParams.hidden = false
        } else {
            quotedView.layoutParams.hidden = true
        }
        
        let layout = contentView.subviews.first as! ALSRelativeLayout
        layout.setNeedsLayout()
    }

    func createTimeSourceText(_ createdAt: Date) -> NSAttributedString {
        let string = NSAttributedString(string: (createdAt as NSDate).formattedDate(with: .long))
        return string
    }
}
