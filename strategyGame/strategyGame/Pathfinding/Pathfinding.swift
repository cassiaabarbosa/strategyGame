//
//  Pathfinding.swift
//  strategyGame
//
//  Created by Edgar Sgroi on 18/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation

class Pathfinding {
    
    static let shared: Pathfinding = Pathfinding()
    var currentLocation: Tile?
    var destination: Tile?
    var grid: Grid? = GameManager.shared.grid
    var path: [Tile] = [Tile]()
    
    func generatePath(currentTile: Tile, destinationTile: Tile) -> [Tile] {
        self.path.removeAll()
        guard let grid: Grid = self.grid else { fatalError("404 - Grid not founded on Pathfinding archive") }
        guard let tilesMatrix: [[Tile]] = grid.getAllNeightborsTilesInGroup(tile: destinationTile) as? [[Tile]] else { fatalError("404 - All Neightbors Tiles not founded on Pathfinding archive") }
        setWeights(tilesMatrix: tilesMatrix, destination: destinationTile)
        var ct: Tile = currentTile
        while ct.weight != destinationTile.weight {
            let neighbors: [Tile] = grid.getMovableTiles(currenTile: ct)
            ct = findNextBreadcrumb(currentTile: ct, neighbors: neighbors, tilesMatrix: tilesMatrix)
            self.path.append(ct)
        }
        
        for index in 0...self.path.count - 1 {
            self.path[index].shape?.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            print(path[index].id)
        }
        return self.path
    }
    
    func setWeights(tilesMatrix: [[Tile]], destination: Tile) {
        var weight: Int = 0
        for group in 0...(tilesMatrix.count - 1) {
            weight += 1
            for tile in 0...(tilesMatrix[group].count - 1) {
                if !tilesMatrix[group][tile].isOcupied {
                    tilesMatrix[group][tile].weight = weight
                } else {
                    tilesMatrix[group][tile].weight = 100
                    }
                
                if tilesMatrix[group][tile].id == destination.id {
                   tilesMatrix[group][tile].weight = 0
                }
            }
        }
    }
    
    func setWeightsForObjectives(tilesMatrix: [[Tile]]) {
        var weight: Int = 0
        for group in 0...(tilesMatrix.count - 1) {
            weight += 1
            for tile in 0...(tilesMatrix[group].count - 1) {
                if !tilesMatrix[group][tile].isOcupied {
                    tilesMatrix[group][tile].weight = weight
                } else {
                    tilesMatrix[group][tile].weight = 100
                    }
                
                if tilesMatrix[group][tile].character != nil {
                    if let _: MachineControlled = tilesMatrix[group][tile].character as? MachineControlled {
                        tilesMatrix[group][tile].weight = 100
                    } else {
                        tilesMatrix[group][tile].weight = 0
                    }
                } else if tilesMatrix[group][tile].prop == .objective {
                    tilesMatrix[group][tile].weight = 0
                }
            }
        }
    }
    
    func findNextBreadcrumb(currentTile: Tile, neighbors: [Tile], tilesMatrix: [[Tile]]) -> Tile {
        var weights: [Tile] = [Tile]()
        
        for movable in 0...neighbors.count - 1 {
            for area in 0...tilesMatrix.count - 1 {
                for tile in 0...tilesMatrix[area].count - 1 where neighbors[movable] == tilesMatrix[area][tile] {
                    weights.append(tilesMatrix[area][tile])
                }
            }
        }
        
        weights.sort(by: { $0.weight < $1.weight })
        self.path.append(weights[0])
        for aaa in 0...self.path.count - 1 {
            self.path[aaa].color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return weights[0]
    }
    
    func getNearestGoal(currentTile: Tile, tilesMatrix: [[Tile]]) -> [Tile] {
        var nearestGoal: [Tile] = [Tile]()
        var allPaths: [[Tile]] = [[Tile]]()
        setWeightsForObjectives(tilesMatrix: tilesMatrix)
        
        for area in 0...tilesMatrix.count - 1 {
            for tile in 0...tilesMatrix[area].count - 1 where tilesMatrix[area][tile].weight == 0 {
                allPaths.append(generatePath(currentTile: currentTile, destinationTile: tilesMatrix[area][tile]))
            }
        }
        
        allPaths.sort(by: ({ $0.count < $1.count }))
        nearestGoal = allPaths[0]
        
        for objectives in 0...allPaths.count - 1 where allPaths[objectives].count == nearestGoal.count {
            if (nearestGoal[0].character != nil && allPaths[objectives][0].character == nil) {
                nearestGoal = allPaths[objectives]
            }
        }
        
        return nearestGoal
    }
}
