//
//  J.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Foundation

extension Data {
    public func decode<T: Decodable>(to type: T.Type) throws -> T {
        return try JSONDecoder().decode(type, from: self)
    }
}
