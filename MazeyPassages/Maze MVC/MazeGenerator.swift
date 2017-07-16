//
//  MazeGenerator.swift
//  MazeyPassages
//
//  Created by Vincent O'Sullivan on 13/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

protocol MazeGenerator {

    /// Links each cell of the maze to its connecting cells.
    func generateMaze(from cells: [[Cell]]) -> [[Cell]]
}
