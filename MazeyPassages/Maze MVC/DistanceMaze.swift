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

//    init(rows: Int, cols: Int, generator: MazeGenerator, exitRow: Int, exitCol: Int) {
//        super.init(rows: rows, cols: cols, generator: generator)
//        calculateDistancesFrom(row: exitRow, col: exitCol)
//    }

    override func contentsOf(_ cell: Cell) -> String {
        if let distance = distances?.distance(to: cell) {
            return String(distance, radix: 36)
        } else {
            return super.contentsOf(cell)
        }
    }

    private func setExitAt(row: Int, col: Int) {
        distances = cell(row: row, col: col).fetchDistances()
    }

    private func shortestPathFrom(row: Int, col: Int) {
        distances = distances?.path(to: cell(row: row, col: col))
    }

    public func shortestPath(fromStart start: (row: Int, col: Int), toExit exit: (row: Int, col: Int)) {
        setExitAt(row: exit.row, col: exit.col)
        shortestPathFrom(row: start.row, col: start.col)
    }
}
