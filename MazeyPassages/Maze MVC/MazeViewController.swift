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
        let maze = Maze(rows: 40, cols: 40, generator: SideWinderMaze())
        print(maze.description)
        mazeView.maze = maze
    }
}

