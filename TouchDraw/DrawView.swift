//
//  DrawView.swift
//  TouchDraw
//
//  Created by Susanne Burnham on 9/30/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lines = [Line]()
    
    override func drawRect(rect: CGRect) {
        
        // Only override drawRect: if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.
        //override func drawRect(rect: CGRect) {
        // Drawing code
        //CGContextFillRect(context, CGRect(x: 10, y: 10, width: 100, height: 100))
        
        //UIColor.cyanColor().set()
        
        //CGContextStrokeRect(context, CGRect(x: 200, y: 10, width: 100, height: 100))
        
        /*
        UIColor.magentaColor().set()
        
        CGContextAddEllipseInRect(context, CGRect(x: 20, y: 20, width: 200, height: 200))
        
        CGContextFillPath(context)
        
        CGContextAddEllipseInRect(context, CGRect(x: 100, y: 100, width: 200, height: 200))
        
        CGContextStrokePath(context)
        
        CGContextAddEllipseInRect(context, CGRect(x: 50, y: 50, width: 200, height: 200))
        
        UIColor.cyanColor().set()
        
        CGContextFillPath(context)
        */
        
        //UIColor.magentaColor().set()
        
        //CGContextMoveToPoint(context, 20, 20)
        
        //CGContextMoveToPoint(context, 20, 20)
        
        //CGContextAddLineToPoint(context, 100, 100)
        
        //CGContextStrokePath(context)
        
        
        
        let context = UIGraphicsGetCurrentContext()
        
        UIColor.magentaColor().set()
        
        for line in lines {
            
            if let start = line.start, let end = line.end {
                
                if let fillColor = line.fillColor {
                    
                    fillColor.set()
                    
                    if let shape = line as? Shape {
                        
                        let width = end.x - start.x
                        let height = end.y - start.y
                        
                        let rect = CGRect(x: start.x, y: start.y, width: width, height: height)
                        
                        switch shape.type ?? .Rectangle {
                            
                        case .Circle :
                            
                            CGContextFillEllipseInRect(context, rect)
                            
                        case .Triangle :
                            
                            let top = CGPoint(x: width/2 + start.x, y: start.y)
                            let right = end
                            let left = CGPoint(x: start.x, y: end.y)
                            
                            CGContextMoveToPoint(context, top.x, top.y )
                            CGContextAddLineToPoint(context, right.x, right.y)
                            CGContextAddLineToPoint(context, left.x, left.y)
                            
                            CGContextFillPath(context)
                            
                            
                        case .Rectangle :
                            
                            CGContextFillRect(context, rect)
                            
                            
                        }
                        
                    }
                    
                }
                
                if let strokeColor = line.strokeColor {
                    
                    strokeColor.set()
                    
                    CGContextSetLineWidth(context, line.strokeWidth)
                    
                    CGContextSetLineCap(context, .Square)
                    CGContextSetLineJoin(context, .Bevel)
                    
                    CGContextMoveToPoint(context, start.x, start.y)
                    
                    //                  if line is Scribble { }
                    
                    if let scribble = line as? Scribble {
                        
                        CGContextAddLines(context, scribble.points, scribble.points.count)
                        
                    }
                    
                    CGContextAddLineToPoint(context, end.x, end.y)
                    
                    CGContextStrokePath(context)
                    
                }
                
            }
            
        }
        
    }
    
}

class Line {
    
    var start: CGPoint?
    var end: CGPoint?
    
    var strokeColor: UIColor?
    var fillColor: UIColor?
    
    var strokeWidth: CGFloat = 0
    
}

class Scribble: Line {
    
    var points = [CGPoint]() {
        
        didSet {
            
            start = points.first
            end = points.last
        }
        
        
    }
}

enum ShapeType {
    
    case Rectangle, Circle, Triangle
}

class Shape: Line {
    
    var type: ShapeType!
    
    init(type: ShapeType) {
        
        self.type = type
        
    }
}
