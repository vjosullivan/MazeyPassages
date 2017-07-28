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
        let minX = lineWidth / 2.0
        let minY = lineWidth / 2.0
        backgroundColor = UIColor.clear
        let wallColor = UIColor.darkGray
        wallColor.setStroke()
        UIColor(red: 0.6, green: 0.2, blue: 0.2, alpha: 1.0).setFill()

        for r in 0..<maze.rows {
            for c in 0..<maze.cols {
                let leftX   = minX + CGFloat(c) * cellSize
                let rightX  = leftX + cellSize
                let topY    = minY + CGFloat(r) * cellSize
                let bottomY = topY + cellSize
                let cell = maze.cell(row: r, col: c)
                let distance = maze.distances?.distance(to: cell) ?? 0
                if distance == 0 {
                    UIColor.yellow.setFill()
                } else {
                    let shade = max(CGFloat(distance) / CGFloat(4 * maze.rows), 0.0)
                    UIColor(red: 0.0, green: 1.0 - shade, blue: 0.0, alpha: 1.0).setFill()
                }
                let room = UIBezierPath()
                room.move(to: CGPoint(x: leftX, y: topY))
                room.addLine(to: CGPoint(x: rightX, y: topY))
                room.addLine(to: CGPoint(x: rightX, y: bottomY))
                room.addLine(to: CGPoint(x: leftX, y: bottomY))
                room.fill()
            }
        }
        for r in 0..<maze.rows {
            for c in 0..<maze.cols {
                let leftX   = minX + CGFloat(c) * cellSize
                let rightX  = leftX + cellSize
                let topY    = minY + CGFloat(r) * cellSize
                let bottomY = topY + cellSize
                let cell = maze.cell(row: r, col: c)
               let wall = UIBezierPath()
                wall.lineWidth = lineWidth
                wall.lineJoinStyle = .round
                wall.lineCapStyle  = .round
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
                wall.stroke()
            }
        }
        drawBorder(width: lineWidth, in: rect)
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
