//
//  GenericDecoder.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import Foundation

//MARK: Generic Decoder
func decodeJson<T: Decodable>(using type: T.Type, and data: Data) -> T{
    do {
        let resultFromParsing = try JSONDecoder().decode(T.self, from: data)
        return resultFromParsing
    } catch  {
        fatalError(error.localizedDescription)
    }
}
