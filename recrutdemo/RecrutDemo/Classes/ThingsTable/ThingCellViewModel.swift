//
//  ThingCellViewModel.swift
//  RecrutDemo
//
//  Created by Shilpa S on 25/10/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

import Foundation

struct ThingCellViewModel {
    let name : String
    var isLiked : Observable<Bool>
    var image : String?
}

