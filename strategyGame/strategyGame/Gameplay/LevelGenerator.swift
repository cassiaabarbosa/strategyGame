//
//  LevelGenerator.swift
//  level-printer
//
//  Created by Artur Carneiro on 23/12/19.
//  Copyright © 2019 Artur Carneiro. All rights reserved.
//

import Foundation

class LevelGenerator {
    
    static public var levels: [LevelDescription] = [
        level1,
        level2,
        level3,
        level4,
        level5,
        level6,
        level7,
        level8,
        level9,
        level10
    ]
    
    static public var tutorialIndex = 0
    
    static public var tutorials: [LevelDescription] = [
        tutorial1,
        tutorial2,
        tutorial3,
        tutorial4,
        tutorial5,
        tutorial6,
        tutorial7,
        tutorial8
    ]
    
    static public let level1 = LevelDescription(width: 6, height: 8, tileSet: """
.h....\
.....v\
hc.m..\
hh.m..\
sM.Thh\
..h..h\
..Rl..\
..h...
""")
    static public let level2 = LevelDescription(width: 6, height: 8, tileSet: """
......\
....v.\
...c..\
...m..\
.h..h.\
.sR.lT\
M..m..\
......
""")
    static public let level3 = LevelDescription(width: 6, height: 8, tileSet: """
......\
.c....\
.h.v..\
......\
m.m.h.\
......\
Rs.M.l\
.....T
""")
    static public let level4 = LevelDescription(width: 6, height: 8, tileSet: """
......\
.c....\
....v.\
.m....\
...m.h\
h.M...\
....T.\
s.Rl..
""")
    static public let level5 = LevelDescription(width: 6, height: 8, tileSet: """
.....v\
......\
..c...\
..h...\
mM..Tm\
......\
shR.hl\
......
""")
    
    static public let level6 = LevelDescription(width: 6, height: 8, tileSet: """
....v.\
.hc...\
....m.\
......\
.h..h.\
.M...T\
.m..l.\
..sRh.
""")
    
    static public let level7 = LevelDescription(width: 6, height: 8, tileSet: """
......\
..c...\
...m..\
...v..\
.h...s\
h.....\
..mMh.\
..RlT.
""")
    
    static public let level8 = LevelDescription(width: 6, height: 8, tileSet: """
......\
.....v\
.ch.m.\
.m....\
....l.\
.s.Mm.\
h.hT.h\
...R..
""")
    
    static public let level9 = LevelDescription(width: 6, height: 8, tileSet: """
......\
...h..\
.mc.mv\
.m..m.\
h.....\
.mT.mM\
.s.Rl.\
..h...
""")
    
    static public let level10 = LevelDescription(width: 6, height: 8, tileSet: """
..v...\
....m.\
.c....\
m..m.s\
.h..T.\
mM..h.\
.lRh..\
......
""")
    
    static public let tutorial1 = LevelDescription(width: 3, height: 3, tileSet: """
..v\
...\
.M.
""", tutorialText: "Select Marcus and kill the Volclam. Then end your turn."
    )
    
    static public let tutorial2 = LevelDescription(width: 1, height: 8, tileSet: """
h\
v\
.\
.\
.\
.\
.\
M
""", tutorialText: "Use your special attack to throw the Volclam into the hole")
    
    static public let tutorial3 = LevelDescription(width: 3, height: 7, tileSet: """
.v.\
mm.\
...\
.mm\
...\
mm.
.R.
""", tutorialText: "Maggy is a ranged character. Use her wisely")
    
    static public let tutorial4 = LevelDescription(width: 3, height: 4, tileSet: """
.vh\
mmm\
...\
R..
""", tutorialText: "Use Maggies special attack to throw the Volclam into the hole")
    
    static public let tutorial5 = LevelDescription(width: 3, height: 5, tileSet: """
mvm\
m.m\
.T.\
...\
...
""", tutorialText: "Clark is a trickster. You can plant traps using his special attack")

    static public let tutorial6 = LevelDescription(width: 3, height: 5, tileSet: """
hhh\
vvv\
...\
...\
MRT
""", tutorialText: "You can move and attack once with every character")
    
    static public let tutorial7 = LevelDescription(width: 3, height: 4, tileSet: """
.c.\
m.m\
.M.\
.R.
""", tutorialText: "Watch out for Cassias. She's stronger than the Volclam")
    
    static public let tutorial8 = LevelDescription(width: 6, height: 8, tileSet: """
....v.\
.hc...\
....m.\
......\
.h..h.\
.M...T\
.m..l.\
..sRh.
""", tutorialText: "Protect the buildings and kill the monsters to win")
    
    static public func randomLevel() -> LevelDescription {
        return levels[Int.random(in: 0..<levels.count)]
    }
    
    static public func nextTutorial() -> LevelDescription {
        let level = tutorials[tutorialIndex]
        tutorialIndex += 1
        if tutorialIndex == 8 {
            tutorialIndex = 0
        }
        return level
    }
}
