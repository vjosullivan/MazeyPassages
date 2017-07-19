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
        let maze = DistanceMaze(rows: 6, cols: 6, generator: SideWinderMaze())
        let startCell = maze.cell(row: 0, col: 0)
        let distances = startCell.fetchDistances()
        maze.distances = distances
        print(maze.description)
        mazeView.maze = maze
    }
}

