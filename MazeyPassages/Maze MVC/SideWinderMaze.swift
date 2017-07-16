//
//  SideWinderMaze.swift
//  MazeyPassages
//
//  Created by Vincent O'Sullivan on 12/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

class SideWinderMaze: MazeGenerator {

    func generateMaze(from cells: [[Cell]]) -> [[Cell]] {
        /// A run of (horizontally linked) cells ends at the eastern boundary or at random.
        /// (The northernmost row of cells can have no northern exit, so never ends.)
        func shouldEnd(_ run: [Cell]) -> Bool {
            let atEasternBoundary  = (run.last?.east == nil)
            let atNorthernBoundary = (run.last?.north == nil)
            return atEasternBoundary ||
                (!atNorthernBoundary && (Int(arc4random_uniform(UInt32(4))) == 0))
        }

        for rowOfCells in cells {
            var run = [Cell]()
            for cell in rowOfCells {
                run.append(cell)
                if shouldEnd(run) {
                    // Select one cell at random from the run to have an exit to the north.
                    let exitCell = randomCell(from: run)
                    if let cellToNorth = exitCell.north {
                        exitCell.link(to: cellToNorth)
                    }
                    run.removeAll()
                } else {
                    cell.link(to: cell.east!)
                }
            }
        }
        return cells
    }

    /// Returns one cell at random from an array of cells.
    func randomCell(from cells: [Cell]) -> Cell {
        let index = Int(arc4random_uniform(UInt32(cells.count)))
        return cells[index]
    }
}
