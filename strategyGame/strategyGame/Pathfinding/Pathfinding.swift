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
    
    func generatePath(currentTile: Tile, destinationTile: Tile) {
        guard let grid: Grid = self.grid else { fatalError("404 - Grid not founded on Pathfinding archive") }
        guard let tilesMatrix: [[Tile]] = grid.getAllNeightborsTilesInGroup(tile: destinationTile) as? [[Tile]] else { fatalError("404 - All Neightbors Tiles not founded on Pathfinding archive") }
        setWeights(tilesMatrix: tilesMatrix, destination: destinationTile)
        var ct: Tile = currentTile
        while ct.weight != destinationTile.weight {
            let neighbors: [Tile] = grid.getMovableTiles(currenTile: ct)
            ct = findNextBreadcrumb(currentTile: ct, neighbors: neighbors, tilesMatrix: tilesMatrix)
        }
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
}
