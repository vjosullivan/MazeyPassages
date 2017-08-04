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

        let size = 17
        let maze = DistanceMaze(rows: size, cols: size, generator: SideWinderMaze())
        print(maze.description)

        let longestPair = maze.longestPath()
        maze.distances = longestPair.start.fetchDistances().distances
        maze.shortestPath(from: longestPair.start, to: longestPair.end)
        mazeView.maze = maze
        mazeView.backgroundColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.65, alpha: 1.0)

        print("\nDistances")
        print("---------\n")
        print(maze.description)
    }
}
