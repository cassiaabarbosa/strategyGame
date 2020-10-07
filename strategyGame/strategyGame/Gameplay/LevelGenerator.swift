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
""")
    
    static public func randomLevel() -> LevelDescription {
        return levels[Int.random(in: 0..<levels.count)]
    }
}
