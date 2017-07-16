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

        let maze1 = Maze(rows: 40, cols: 40, generator: BinaryTreeMaze())
        print(maze1.description)
        mazeView.maze = maze1
        let maze2 = Maze(rows: 10, cols: 10, generator: SideWinderMaze())
        print(maze2.description)
    }
}

