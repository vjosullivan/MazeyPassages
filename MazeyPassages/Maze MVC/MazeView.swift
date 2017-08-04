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
        guard rect.width > 0 && rect.height > 0 else {
            print("CLONK!!!")
            return
        }
        let lineWidth: CGFloat = 4.0
        guard let maze = maze as? DistanceMaze else { return }
        let mazeWidth = min(bounds.width, bounds.height) //- lineWidth
        let cellSize = (mazeWidth - lineWidth) / CGFloat(max(maze.rows, maze.cols))
        let inset = 0.35 * cellSize
        let minX = lineWidth / 2.0
        let minY = lineWidth / 2.0
        backgroundColor = UIColor.clear
        let wallColor = UIColor.darkGray
        wallColor.setStroke()
        UIColor(red: 0.6, green: 0.2, blue: 0.2, alpha: 1.0).setFill()

        for r in 0..<maze.rows {
            for c in 0..<maze.cols {
                let left   = minX + CGFloat(c) * cellSize
                let right  = left + cellSize
                let top    = minY + CGFloat(r) * cellSize
                let bottom = top + cellSize
                let cell = maze.cell(row: r, col: c)
                let maxDistance = maze.distances!.furthestCell().distance
                if let distance = maze.distances?.distance(to: cell) {
                    if distance == 0 {
                        print("A")
                        UIColor.yellow.setFill()
                    } else if distance == maxDistance {
                        print("B")
                        UIColor.red.setFill()
                    } else {
                        let shade = max(CGFloat(abs(distance)) / CGFloat(maxDistance), 0.0)
                        UIColor(red: 0.0, green: 1.0 - shade, blue: 0.0, alpha: 1.0).setFill()
                    }
                    drawSquare(left: left, right: right, top: top, bottom: bottom)
                    if distance < 0 {
                        //let shade = max(CGFloat(-distance) / maxDistance, 0.0)
                        UIColor.red.setFill()
                        drawSquare(left: left, right: right, top: top, bottom: bottom, inset: inset)

                    }
                }
            }
        }
        for r in 0..<maze.rows {
            for c in 0..<maze.cols {
                let left   = minX + CGFloat(c) * cellSize
                let right  = left + cellSize
                let top    = minY + CGFloat(r) * cellSize
                let bottom = top + cellSize
                let cell = maze.cell(row: r, col: c)
                drawWalls(cell, right, top, left, bottom, lineWidth)
            }
        }
        drawBorder(width: lineWidth, in: rect)
    }
    
    fileprivate func drawWalls(_ cell: Cell, _ right: CGFloat, _ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ lineWidth: CGFloat) {
        let wall = UIBezierPath()
        wall.lineWidth = lineWidth
        wall.lineJoinStyle = .round
        wall.lineCapStyle  = .round
        if cell.isLinked(to: cell.north) {
            wall.move(to: CGPoint(x: right, y: top))
        } else {
            wall.move(to: CGPoint(x: left, y: top))
            wall.addLine(to: CGPoint(x: right, y: top))
        }
        if cell.isLinked(to: cell.east) {
            wall.move(to: CGPoint(x: right, y: bottom))
        } else {
            wall.addLine(to: CGPoint(x: right, y: bottom))
        }
        wall.stroke()
    }
    
    fileprivate func drawSquare(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat, inset: CGFloat = 0.0) {
        let room = UIBezierPath()
        room.move(to: CGPoint(x: left + inset, y: top + inset))
        room.addLine(to: CGPoint(x: right - inset, y: top + inset))
        room.addLine(to: CGPoint(x: right - inset, y: bottom - inset))
        room.addLine(to: CGPoint(x: left + inset, y: bottom - inset))
        room.fill()
    }

    fileprivate func drawBorder(width: CGFloat, in rect: CGRect) {
        let border = UIBezierPath(rect: rect)
        border.lineJoinStyle = .round
        border.lineCapStyle = .round
        border.lineWidth = width
        let offset = width / 2.0
        border.move(to: CGPoint(x: offset, y: offset))
        border.addLine(to: CGPoint(x: bounds.width - offset, y: offset + 0))
        border.addLine(to: CGPoint(x: bounds.width - offset, y: bounds.height - offset))
        border.addLine(to: CGPoint(x: offset, y: bounds.height - offset))
        border.addLine(to: CGPoint(x: offset, y: offset))
        border.close()
        border.stroke()
    }
}
