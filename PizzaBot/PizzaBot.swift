//
//  PizzaBot.swift
//  PizzaBot
//
//  Created by Ignacio Mariani on 09/05/2021.
//

import Foundation

let kWrongFormat = "Wrong format"
let kOutOfBounds = "Point out of bounds"

class PizzaBot {
    func getDeliveryRoute(rawInput: String) -> String {
        var result = ""
        let input = rawInput.lowercased().replacingOccurrences(of: " ", with: "")
        
        let gridSizeAndDelivery = input.components(separatedBy: CharacterSet.init(charactersIn: "("))
        
        let gridSize = getGridSize(gridSize: gridSizeAndDelivery.first ?? "")
        let deliveryPoints = getDeliveryPoints(deliveryPoints: Array(gridSizeAndDelivery.dropFirst()))
        
        if (gridSize != nil) && deliveryPoints?.count ?? 0 > 0 {
            if pointsAreWithinGrid(points: deliveryPoints, grid: gridSize) {
                result = getRoute(deliveryPoints: deliveryPoints ?? [])
            } else {
                result = kOutOfBounds
            }
        } else {
            result = kWrongFormat
        }
        return result
    }
    
    func getGridSize(gridSize: String) -> Grid? {
        var gridResult: Grid?
        let gridXY = gridSize.components(separatedBy: CharacterSet.init(charactersIn: "x"))
        if gridXY.count == 2 {
            if let width = gridXY.first, width.isNumber, Int(width) ?? 0 > 0,
               let height = gridXY.last, height.isNumber, Int(height) ?? 0 > 0 {
                gridResult = Grid(width: Int(width) ?? 0, height: Int(height) ?? 0)
            } else {
                gridResult = nil
            }
        } else {
            gridResult = nil
        }
        
        return gridResult
    }
    
    func getDeliveryPoints(deliveryPoints: [String]) -> [Point]? {
        var deliveryPointsResult: [Point] = []
        for coord in deliveryPoints {
            if coord.contains(")") {
                let cleanCoord = coord.replacingOccurrences(of: ")", with: "")
                let coordinate = cleanCoord.components(separatedBy: CharacterSet.init(charactersIn: ","))
                if coordinate.count == 2, let x = coordinate.first, x.isNumber, let y = coordinate.last, y.isNumber {
                    let deliveryPoint = Point(x: Int(x) ?? 0, y: Int(y) ?? 0)
                    deliveryPointsResult.append(deliveryPoint)
                } else {
                    deliveryPointsResult = []
                    break
                }
            } else {
                deliveryPointsResult = []
                break
            }
        }
        return deliveryPointsResult
    }
    
    func pointsAreWithinGrid(points: [Point]?, grid: Grid?) -> Bool {
        var withinGrid = true
        
        if let points = points, let grid = grid {
            for point in points {
                if point.x > grid.width || point.y > grid.height {
                    withinGrid = false
                    break
                }
            }
        }
        return withinGrid
    }
    
    func getRoute(deliveryPoints: [Point]) -> String {
        var route = ""
        var currentPosition = Point(x: 0, y: 0)
        
        for dPoint in deliveryPoints {
            let xMoves = dPoint.x - currentPosition.x
            currentPosition.x = currentPosition.x + xMoves
            
            if xMoves > 0 {
                for _ in 1...xMoves {
                    route = route + "E"
                }
            } else if xMoves < 0{
                for _ in 1...abs(xMoves) {
                    route = route + "W"
                }
            }
            
            let yMoves = dPoint.y - currentPosition.y
            currentPosition.y = currentPosition.y + yMoves
            
            if yMoves > 0 {
                for _ in 1...yMoves {
                    route = route + "N"
                }
            } else if yMoves < 0{
                for _ in 1...abs(yMoves) {
                    route = route + "S"
                }
            }
            
            route = route + "D"
        }
        
        return route
    }
    
}


struct Grid {
    var width: Int
    var height: Int
}

struct Point {
    var x: Int
    var y: Int
}

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

