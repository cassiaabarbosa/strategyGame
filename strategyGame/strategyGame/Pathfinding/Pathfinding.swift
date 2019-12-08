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
    var checkpoint: [Tile] = [Tile]()
    var tilesMatrix: [[Tile]] = [[Tile]]()
    
    func generatePath(currentTile: Tile, destinationTile: Tile) -> [Tile] {
        self.path.removeAll()
        guard let grid: Grid = self.grid else { fatalError("404 - Grid not founded on Pathfinding archive") }
        guard let tm: [[Tile]] = grid.getAllNeightborsTilesInGroup(tile: destinationTile) as? [[Tile]] else { fatalError("404 - All Neightbors Tiles not founded on Pathfinding archive") }
        self.tilesMatrix = tm
        setWeights(destination: destinationTile)
        var ct: Tile = currentTile
        while ct.weight != destinationTile.weight {
            let neighbors: [Tile] = grid.getMovableTiles(currenTile: ct)
            ct = findNextBreadcrumb(currentTile: ct, neighbors: neighbors)
            if path.contains(ct) {
                return [Tile]()
            }
            self.path.append(ct)
        }
        return self.path
    }
    
    // Comment(Alex) - this is only called by generatePath()
    // make part of generatePaths() or make local function
    func setWeights(destination: Tile) {
        var weight: Int = 0
        for group in 0 ..< (tilesMatrix.count) {
            weight += 1
            for tile in 0...(tilesMatrix[group].count - 1) {
                if tilesMatrix[group][tile].isWalkable {
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
    
    // Comment(Alex) - this is only called by getNearestGoal()
    // make part of getNearestGoal() or make local function
    func setWeightsForObjectives(tilesMatrix: [[Tile]]) -> [Tile] {
        var objectives: [Tile] = [Tile]()
        for group in 0 ..< (tilesMatrix.count) {
            for tile in 0 ..< (tilesMatrix[group].count) {
                if tilesMatrix[group][tile].character != nil {
                    if let _: Enemy = tilesMatrix[group][tile].character as? Enemy {
                        tilesMatrix[group][tile].weight = 100
                    } else {
                        tilesMatrix[group][tile].weight = 0
                        objectives.append(tilesMatrix[group][tile])
                    }
                } else if let _: Objective = tilesMatrix[group][tile].prop as? Objective {
                    tilesMatrix[group][tile].weight = 0
                    objectives.append(tilesMatrix[group][tile])
                }
            }
        }
        
        return objectives
    }
    
    // Comment(Alex) - this is only called by generatePath()
    // make part of generatePaths() or make local function
    func findNextBreadcrumb(currentTile: Tile, neighbors: [Tile]) -> Tile {
        var weights: [Tile] = [Tile]()
        
        for movable in 0...neighbors.count - 1 {
            for area in 0...tilesMatrix.count - 1 {
                for tile in 0 ..< tilesMatrix[area].count where neighbors[movable] == tilesMatrix[area][tile] {
                    weights.append(tilesMatrix[area][tile])
                }
            }
        }
        
        weights.sort(by: { $0.weight < $1.weight })
        return weights.count != 0 ? weights[0] : currentTile
    }
    
    func getNearestGoal(currentTile: Tile, tilesMatrix: [[Tile]]) -> [Tile] {
        var nearestGoal: [Tile] = [Tile]()
        var allPaths: [[Tile]] = [[Tile]]()
        let objectives = setWeightsForObjectives(tilesMatrix: tilesMatrix)
        
        for obj in objectives {
            allPaths.append(generatePath(currentTile: currentTile, destinationTile: obj))
        }
        allPaths.removeAll(where: { $0.count <= 0 })
        allPaths.sort(by: ({ $0.count < $1.count }))
        for path in 0 ..< allPaths.count {
            if checkNearestPath(nearestPath: allPaths[path]) {
                nearestGoal = allPaths[path]
                 break
            }
        }
        nearestGoal = allPaths[0]
        
        // Verifica se o nearestGoal representa um player ou um tile objetivo, se for um player e existir um array no allPaths que possui o mesmo tamnho e representa um tile objetivo, ele dá a preferencia para esse tile.
        for objectives in 0 ..< allPaths.count where allPaths[objectives].count == nearestGoal.count {
            if (nearestGoal[0].character != nil && allPaths[objectives][0].character == nil) {
                nearestGoal = allPaths[objectives]
            }
        }
        
        return nearestGoal
    }
    
    func removeObstacles() {
        for area in 0 ..< tilesMatrix.count {
            tilesMatrix[area].removeAll(where: { $0.weight == 100 })
        }
        tilesMatrix.removeAll(where: { $0.count <= 0 })
    }
    
    // Comment(Alex) - this is only called by getNearestGoal()
    // make part of getNearestGoal() or make local function
    func checkNearestPath(nearestPath: [Tile]) -> Bool {
        var path = nearestPath
        path.removeLast()
        for tile in path where !tile.isWalkable {
            return false
        }
        return true
    }
}
