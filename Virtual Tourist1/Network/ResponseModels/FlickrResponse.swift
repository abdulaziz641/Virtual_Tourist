//
//  FlickrResponse.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import Foundation

//MARK: Flick Response
struct FlickResponse: Decodable {
    struct Photos: Decodable {
        struct Photo: Decodable {
            var id: String
            var owner: String
            var secret: String
            var server: String
            var farm: Int
            var title: String
            var ispublic: Int
            var url_s: URL?
            var isfriend: Int
            var isfamily: Int
            var height_s: String
            var width_s: String
        }
        var page: Int
        var pages: Int
        var perpage: Int
        var total: String
        var photo: [Photo]
    }
    var photos: Photos
    var stat: String
}
