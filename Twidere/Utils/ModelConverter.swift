//
//  ModelConverter.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ModelConverter {
    
    static let oauthToken = DataResponseSerializer { req, resp, data, err -> Result<OAuthToken> in
        var oauthToken = "", oauthTokenSecret = "", userId = "", screenName = ""
        for paramString in String(data: data!, encoding: String.Encoding.utf8)!.components(separatedBy: "&") {
            
            if (paramString.contains("=")) {
                let param = paramString.components(separatedBy: "=").map { s -> String in
                    return s.removingPercentEncoding!
                }
                if (param.count == 2) {
                    switch (param[0]) {
                    case "oauth_token":
                        oauthToken = param[1]
                    case "oauth_token_secret":
                        oauthTokenSecret = param[1]
                    case "user_id":
                        userId = param[1]
                    case "screen_name":
                        screenName = param[1]
                    default: break
                    }
                }
            }
        }
        let token = OAuthToken(oauthToken, oauthTokenSecret)
        token.userId = userId
        token.screenName = screenName
        return .success(token)
    }
    
    static func toJson(_ result: HttpResult!) -> JSON {
        return JSON(data: result.data!)
    }
}
