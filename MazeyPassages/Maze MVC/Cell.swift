//
//  Cell.swift
//  MazeyPassages
//
//  Created by Vincent O'Sullivan on 12/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

class Cell {

    // MARK: - Public properties.

    let row: Int
    let col: Int

    var north: Cell?
    var south: Cell?
    var east: Cell?
    var west: Cell?

    // MARK: - Private properties.

    /// A list of all the cells directly connected to this cell.
    private(set) var links = [Cell]()
    lazy var distances = Distances(root: self)
    lazy var frontier = [self]

    // MARK: - Public functions.

    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }

    /// Adds a link from this `Cell` to another `Cell` (unless they are already linked,
    /// in which case nothing happens).
    /// If the link is bidirectional, the other `Cell` is linkined back to this `Cell`.
    /// - Note: When the function calls the other cell for a link back, then `bidirectional`
    ///         is set to false to prevent an infinite loop of links.
    ///
    /// - Parameters:
    ///   - otherCell: The `Cell` to be linked.
    ///   - bidirectional: `true` (default) if a link back from the other `Cell` is
    ///                    required, otherwise `false`.
    ///
    public func link(to otherCell: Cell, bidirectional: Bool = true) {
        if !links.contains { $0 == otherCell } {
            links.append(otherCell)
            if bidirectional {
                otherCell.link(to: self, bidirectional: false)
            }
        }
    }

    public func isLinked(to otherCell: Cell?) -> Bool {
        guard let cell = otherCell else { return false }
        return links.contains(cell)
    }


    /// Returns a table of distances of each cell in the maze from this cell.
    ///
    /// - Returns: A table of cell to cell distances for this cell.
    ///
    public func fetchDistances() -> (distances: Distances, maxDistance: Int) {
        var maxDistance = 0
        while !frontier.isEmpty {
            var newFrontier = [Cell]()
            for cell in frontier {
                for linkedCell in cell.links {
                    if distances.doesNotContain(linkedCell) {
                        maxDistance += 1
                        distances.distanceToRoot[linkedCell] = distances.distanceToRoot[cell]! + 1
                        newFrontier.append(linkedCell)
                    }
                }
            }
            frontier = newFrontier
        }
        return (distances: distances, maxDistance: maxDistance)
    }
}

extension Cell: Equatable {
    static func ==(lhs: Cell, rhs: Cell) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
}

extension Cell: Hashable {
    var hashValue: Int {
        return 991 * row + 997 * col
    }
}
