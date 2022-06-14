//
//  AcronymViewModel.swift
//  AbbreviationDemo
//
//  Created by Karthik on 09/06/22.
//

import Foundation


class AcronymViewModel: NSObject {
    private var apiService : APIService!
    private(set) var AcronymModelData : AcronymModel! {
        didSet {
            self.AcronymViewModelToController()
        }
    }
    
    var AcronymViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        
    }
    
    func callFuncToGetAPIData(searchText: String) {
        self.apiService.apiToAcronymData(text: searchText) { (empData) in
            self.AcronymModelData = empData
        }
    }
}
