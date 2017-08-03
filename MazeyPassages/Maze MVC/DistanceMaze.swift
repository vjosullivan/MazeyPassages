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

    private func setExit(to cell: Cell) {
        distances = cell.fetchDistances().distances
    }

    private func shortestPathFrom(cell: Cell) {
        let pathDistances = distances?.path(to: cell)
        for (cell, distance) in pathDistances!.distanceToRoot {
            distances?.distanceToRoot[cell] = -distance
        }
    }

    public func shortestPath(from start: Cell, to exit: Cell) {
        setExit(to: exit)
        shortestPathFrom(cell: cell(row: start.row, col: start.col))
    }

    public func longestPath() -> (start: Cell, end: Cell) {
        let startCell = cells[0][0].fetchDistances().distances.furthestCell().cell
        let endCell   = cells[startCell.row][startCell.col].fetchDistances().distances.furthestCell().cell
        return (start: startCell, end: endCell)
    }
}
