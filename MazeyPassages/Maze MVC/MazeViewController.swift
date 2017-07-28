//
//  ViewController.swift
//  MazeyPassages
//
//  Created by Vincent O'Sullivan on 11/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import UIKit

class MazeViewController: UIViewController {

    @IBOutlet weak var mazeView: MazeView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //let maze = Maze(rows: 20, cols: 20, generator: BinaryTreeMaze())
        let size = 17
        let maze = DistanceMaze(rows: size, cols: size, generator: SideWinderMaze())
        let startCell = maze.cell(row: size / 2, col: size / 2)
        let distances = startCell.fetchDistances()
        maze.distances = distances
        print(maze.description)
        mazeView.maze = maze
        mazeView.setNeedsDisplay()

        maze.distances = maze.distances?.path(to: maze.cell(row: size * 9 / 10, col: size * 9 / 10))
        print("\nDistances")
        print("---------\n")
        print(maze.description)
    }
}
