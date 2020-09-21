//
//  News.swift
//  newsZennex
//
//  Created by Zakirov Tahir on 05.09.2020.
//  Copyright © 2020 Zakirov Takhir. All rights reserved.
//

import Foundation

struct NewsList: Decodable {
    var articles: [Article]
}
struct Article: Decodable {
    var title: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: Date?
    var url: String?
}
