//
//  InstagramFooterModel.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/14/23.
//

import Foundation
import SwiftUI

struct PostedModel: Codable {
    let image: Data
    let user_name: String
    let liked_people: [liked_people_Model]
    let posted_summery: String
}

struct liked_people_Model: Codable {
    let liked_people_image: Data
    let liked_people_names: String
}
