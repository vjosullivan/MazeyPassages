//
//  Maze.swift
//  MazeyPassages
//
//  Created by Vincent O'Sullivan on 12/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

class BinaryTreeMaze: MazeGenerator {

    func generateMaze(from cells: [[Cell]]) -> [[Cell]] {
        for rowOfCells in cells {
            for cell in rowOfCells {
                var linkableCells = [Cell]()
                if let north = cell.north { linkableCells.append(north) }
                if let east  = cell.east  { linkableCells.append(east)  }
                if linkableCells.count > 0 { cell.link(to: randomCell(from: linkableCells)) }
            }
        }
        return cells
    }

    private func randomCell(from cells: [Cell]) -> Cell {
        let index = Int(arc4random_uniform(UInt32(cells.count)))
        return cells[index]
    }
}
