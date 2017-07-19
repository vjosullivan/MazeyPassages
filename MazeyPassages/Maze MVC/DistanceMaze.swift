//
//  DistanceMaze.swift
//  MazeyPassages
//
//  Created by Vincent O'Sullivan on 19/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import UIKit

class DistanceMaze: Maze {

    var distances: Distances?

    override func contentsOf(_ cell: Cell) -> String {
        if let distance = distances?.distance(to: cell) {
            return String(distance, radix: 36)
        } else {
            return super.contentsOf(cell)
        }
    }
}
