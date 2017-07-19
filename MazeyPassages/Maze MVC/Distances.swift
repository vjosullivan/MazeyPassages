//
//  Distances.swift
//  MazeyPassages
//
//  Created by Vincent O'Sullivan on 18/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

// Records the distance to all other cells in the Maze from the root cell.
class Distances {

    private let root: Cell
    var cells = [Cell: Int]()

    init(root: Cell) {
        self.root = root
        cells[root] = 0
    }

    func distance(to cell: Cell) -> Int? {
        return cells[cell]
    }

    func doesNotContain(_ cell: Cell) -> Bool {
        return cells[cell] == nil
    }
}
