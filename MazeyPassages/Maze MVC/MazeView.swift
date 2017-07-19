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
        let lineWidth: CGFloat = 2.0
        guard let maze = maze else { return }
        let mazeWidth = min(bounds.width, bounds.height) //- lineWidth
        let cellSize = (mazeWidth - lineWidth) / CGFloat(max(maze.rows, maze.cols))
        let minX = lineWidth / 2.0
        let minY = lineWidth / 2.0
        backgroundColor = UIColor.lightGray
        let wallColor = UIColor.darkGray
        wallColor.set()

        drawBorder(lineWidth)

        for r in 0..<maze.rows {
            for c in 0..<maze.cols {
                let leftX   = minX + CGFloat(c) * cellSize
                let rightX  = leftX + cellSize
                let topY    = minY + CGFloat(r) * cellSize
                let bottomY = topY + cellSize

                let cell = maze.cell(row: r, col: c)
                let wall = UIBezierPath()
                wall.lineWidth = lineWidth
                wall.lineCapStyle  = .square
                if cell.isLinked(to: cell.north) {
                    wall.move(to: CGPoint(x: rightX, y: topY))
                } else {
                    wall.move(to: CGPoint(x: leftX, y: topY))
                    wall.addLine(to: CGPoint(x: rightX, y: topY))
                }
                if cell.isLinked(to: cell.east) {
                    wall.move(to: CGPoint(x: rightX, y: bottomY))
                } else {
                    wall.addLine(to: CGPoint(x: rightX, y: bottomY))
                }
                //wall.close()
                wall.stroke()
            }
        }
    }
    
    fileprivate func drawBorder(_ lineWidth: CGFloat) {
        let border = UIBezierPath()
        border.lineJoinStyle = .miter
        border.lineCapStyle = .square
        border.lineWidth = lineWidth
        let offset = lineWidth / 2.0
        border.move(to: CGPoint(x: offset, y: offset))
        border.addLine(to: CGPoint(x: bounds.width - offset, y: offset + 0))
        border.addLine(to: CGPoint(x: bounds.width - offset, y: bounds.height - offset))
        border.addLine(to: CGPoint(x: offset, y: bounds.height - offset))
        border.addLine(to: CGPoint(x: offset, y: offset))
        border.close()
        border.stroke()
    }
}
