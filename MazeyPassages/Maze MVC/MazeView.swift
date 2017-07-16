//
//  MazeView.swift
//  MazeyPassages
//
//  Created by Vincent O'Sullivan on 16/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import UIKit

class MazeView: UIView {

    var maze: Maze? {
        didSet {
            self.draw(CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height))
        }
    }

    override func draw(_ rect: CGRect) {
        let lineWidth: CGFloat = 1.0
        guard let maze = maze else { return }
        let mazeWidth = min(bounds.width, bounds.height)
        let cellSize = mazeWidth / CGFloat(max(maze.rows, maze.cols))
        backgroundColor = UIColor.lightGray
        let wallColor = UIColor.darkGray

        let border = UIBezierPath()
        border.lineJoinStyle = .round
        border.lineCapStyle = .round
        border.lineWidth = 2 * lineWidth
        border.move(to: CGPoint(x: 0, y: 0))
        border.addLine(to: CGPoint(x: bounds.width, y: 0))
        border.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        border.addLine(to: CGPoint(x: 0, y: bounds.height))
        border.addLine(to: CGPoint(x: 0, y: 0))
        border.close()
        wallColor.set()
        border.stroke()

        for r in 0..<maze.rows {
            for c in 0..<maze.cols {
                let leftX   = CGFloat(c) * cellSize
                let rightX  = leftX + cellSize
                let topY    = CGFloat(r) * cellSize
                let bottomY = topY + cellSize

                let cell = maze.cell(row: r, col: c)
                if !cell.isLinked(to: cell.north) {
                    let aPath = UIBezierPath()
                    aPath.lineWidth = lineWidth
                    aPath.lineJoinStyle = .round

                    aPath.move(to: CGPoint(x: leftX, y: topY))
                    aPath.addLine(to: CGPoint(x: rightX, y: topY))
                    aPath.close()
                    UIColor.red.set()
                    aPath.stroke()
                }
                if !cell.isLinked(to: cell.east) {
                    let aPath = UIBezierPath()
                    aPath.lineWidth = lineWidth
                    aPath.lineJoinStyle = .round
                    aPath.move(to: CGPoint(x: rightX, y: topY))
                    aPath.addLine(to: CGPoint(x: rightX, y: bottomY))
                    aPath.close()
                    UIColor.red.set()
                    aPath.stroke()
                }
            }
        }
    }
    
}
