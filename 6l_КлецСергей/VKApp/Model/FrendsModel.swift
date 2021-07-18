//
//  FrendsModel.swift
//  VKApp
//
//  Created by KKK on 05.04.2021.
//

import UIKit

    struct frendsModel {
        let id: Int
        let nik: String
        var section: Character {nik.first!}
        let firstname: String
        let lastname: String
        var fullname: String  { "\(firstname)  \(lastname)" }
        let image: UIImage
    }


    struct frendsSections {
        var section: Character
        var rows: [frendsModel]
    
    }


    struct frendCollectionImages {
//        var frend: frendsModel
        var images: [UIImage]
    }
