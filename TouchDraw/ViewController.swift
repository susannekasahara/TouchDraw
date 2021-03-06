//
//  ViewController.swift
//  TouchDraw
//
//  Created by Susanne Burnham on 9/30/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var controlPanelTop: NSLayoutConstraint!
    
    
    @IBOutlet weak var controlPanelView: UIView!
    
    
    @IBAction func toggleControlPanel(sender: AnyObject) {
        
        self.controlPanelTop.constant = self.controlPanelView.frame.origin.y == 0 ? -200 : 0
        
        view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(0.4) { () -> Void in
            
            self.view.layoutIfNeeded()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    var chosenTool: Int = 0
    
    
    @IBAction func chooseTool(button: UIButton) {
        
        chosenTool = button.tag
    
    }
    
    var chosenColor: UIColor = UIColor.blackColor()
    
    
    @IBAction func chooseColor(button: UIButton) {
        chosenColor = button.backgroundColor ?? UIColor.blackColor()
    
    }
    
    @IBAction func undo(sender: AnyObject) {
        
       if (view as? DrawView)?.lines.count > 0 {
            
            (view as?DrawView)?.lines.removeLast()
        }
        
        view.setNeedsDisplay()
        
    }
    
    @IBAction func clear(sender: UIButton) {
        
        (view as? DrawView)?.lines = []
        
        view.setNeedsDisplay()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            switch chosenTool {
                
            case 1 :
                
                //SCRIBBLE
                
                let newScribble = Scribble()
                
                newScribble.points.append(touch.locationInView(view))
                
                newScribble.strokeColor = chosenColor
                
                newScribble.strokeWidth = 10
                
                (view as? DrawView)?.lines.append(newScribble)
                
                
            case 2 :
                
                startShape(.Circle, withTouch: touch)
                
            case 3 :
                
                startShape(.Rectangle, withTouch: touch)
                
                
            case 4 :
                
                startShape(.Triangle, withTouch: touch)
                
                
                
            case 5 :
                
                startShape(.Diamond, withTouch: touch)
                
            default : // case 0
                
                ///Line
                
                let newLine = Line()
                
                newLine.start = touch.locationInView(view)
                newLine.strokeColor = chosenColor
                newLine.strokeWidth = 10
                
                (view as? DrawView)?.lines.append(newLine)
                
                
            }
            
            
            
            view.setNeedsDisplay()
            
            
        }
        
    }
    func startShape(type: ShapeType, withTouch touch: UITouch) {
        
        
        let shape = Shape(type: type)
        
        shape.start = touch.locationInView(view)
        shape.fillColor = chosenColor
        
        (view as? DrawView)?.lines.append(shape)
        
    }
    
    // SHAPE
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
           
            if let currentScribble = (view as? DrawView)?.lines.last as? Scribble {
                
                currentScribble.points.append(touch.locationInView(view))
                
                view.setNeedsDisplay()
                
            } else if let currentLine = (view as? DrawView)?.lines.last {
                        
                        currentLine.end = touch.locationInView(view)
                        
                        view.setNeedsDisplay()
                        
                        }
                
                
            }

            
            
                
            
                ///EVERYTHING ELSE
                
                
            //Line
            
            //            if let currentLine = (view as? DrawView)?.lines.last {
            //
            //                currentLine.end = touch.locationInView(view)
            //
            //                view.setNeedsDisplay()
            
            //            }
            
            //Scribble
            
                    
            ///shape
            
            
        }
    }
    






