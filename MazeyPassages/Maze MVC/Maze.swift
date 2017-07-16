//
//  Maze.swift
//  MazeyPassages
//
//  Created by Vincent O'Sullivan on 13/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

class Maze {

    // MARK: - Internal properties.
    
    let rows: Int
    let cols: Int
    
    var cells = [[Cell]]()
    
    // MARK: - Public functions.
    
    init(rows: Int, cols: Int, generator: MazeGenerator) {
        self.rows = rows
        self.cols = cols

        prepareGrid()
        configureCells()
        cells = generator.generateMaze(from: cells)
    }

    // MARK: - Private functions.
    
    private func prepareGrid() {
        for row in 0..<rows {
            var columnContents = [Cell]()
            for col in 0..<cols {
                columnContents.append(Cell(row: row, col: col))
            }
            cells.append(columnContents)
        }
    }
    
    /// Populates each cell in the maze with its:
    /// - Co-ordinates, and
    /// - Linkable neighbours.
    private func configureCells() {
        let maxRow = rows - 1
        let maxCol = cols - 1
        for rowOfCells in cells {
            for cell in rowOfCells {
                let row = cell.row
                let col = cell.col
                cell.north = (row > 0)      ? cells[row - 1][col] : nil
                cell.south = (row < maxRow) ? cells[row + 1][col] : nil
                cell.east  = (col < maxCol) ? cells[row][col + 1] : nil
                cell.west  = (col > 0)      ? cells[row][col - 1] : nil
            }
        }
    }

    public func cell(row: Int, col: Int) -> Cell {
        return cells[row][col]
    }

    public func setCellAt(row: Int, col: Int, to newValue: Cell) {
        cells[row][col] = newValue
    }

    public func drawMaze(cellSize: Int = 50) {
        
    }
}

extension Maze: CustomStringConvertible {
    var description: String {
        var output = "+" + String(repeating: "---+", count: cols) + "\n"
        for rowOfCells in cells {
            var top    = "|"
            var bottom = "+"
            for cell in rowOfCells {
                let body = "   "
                let eastBoundary = cell.isLinked(to: cell.east) ? " " : "|"
                top += body + eastBoundary
                let southBoundary = cell.isLinked(to: cell.south) ? "   " : "---"
                bottom += southBoundary + "+"
            }
            output += top + "\n"
            output += bottom + "\n"
        }
        return output
    }
}
