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
        print(maze.description)

        maze.shortestPath(fromStart: (row: size * 9 / 10, col: size * 9 / 10), toExit: (row: size / 2, col: size / 2))
        mazeView.maze = maze

        print("\nDistances")
        print("---------\n")
        print(maze.description)
    }
}
