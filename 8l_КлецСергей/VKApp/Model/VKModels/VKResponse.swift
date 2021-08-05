//
//  VKResponse.swift
//  VKApp
//
//  Created by KKK on 26.05.2021.
//

struct VKResponse<T:Codable>: Codable {
    let response: T
}

