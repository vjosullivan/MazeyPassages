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
    var distanceToRoot = [Cell: Int]()

    init(root: Cell) {
        self.root = root
        distanceToRoot[root] = 0
    }

    func distance(to cell: Cell) -> Int? {
        return distanceToRoot[cell]
    }

    func doesNotContain(_ cell: Cell) -> Bool {
        return distanceToRoot[cell] == nil
    }

    func path(to cell: Cell) -> Distances {
        var currentCell = cell
        let breadcrumbs = Distances(root: root)
        breadcrumbs.distanceToRoot[currentCell] = distanceToRoot[currentCell]

        while currentCell != root {
            for neighbour in currentCell.links {
                if distanceToRoot[neighbour]! < distanceToRoot[currentCell]! {
                    breadcrumbs.distanceToRoot[neighbour] = distanceToRoot[neighbour]
                    currentCell = neighbour
                }
            }
        }

        return breadcrumbs
    }

    func furthestCell() -> (cell: Cell, distance: Int) {
        var maxDistance = distanceToRoot.first!.value
        var maxCell     = distanceToRoot.first!.key

        for cell in distanceToRoot.keys {
            if let newDistance = distanceToRoot[cell], newDistance > maxDistance {
                maxDistance = newDistance
                maxCell     = cell
            }
        }
        return (cell: maxCell, distance: maxDistance)
    }
}
