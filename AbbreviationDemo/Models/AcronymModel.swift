//
//  AcronymModel.swift
//  AbbreviationDemo
//
//  Created by Karthik on 09/06/22.
//

import Foundation

// MARK: - AcronymModelElement
struct AcronymModel: Codable {
    var sf: String
    var lfs: [LF]?
}

// MARK: - LF
struct LF: Codable {
    var lf: String
    var freq, since: Int
    var vars: [LF]?
}



