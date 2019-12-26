//
//  LevelGenerator.swift
//  level-printer
//
//  Created by Artur Carneiro on 23/12/19.
//  Copyright © 2019 Artur Carneiro. All rights reserved.
//

import Foundation


class LevelGenerator {
    private var levelArrays: [String] = []
    
    private let one: String = """
.h....\
.....v\
hc.m..\
hh.m..\
sM.Thh\
..h..h\
..Rl..\
..h...
"""
    private let two: String = """
......\
....v.\
...c..\
...m..\
.h..h.\
.sR.lT\
M..m..\
......
"""
    private let three: String = """
......\
.c....\
.h.v..\
......\
m.m.h.\
......\
Rs.M.l\
.....T
"""
    private let four: String = """
......\
.c....\
....v.\
.m....\
...m.h\
h.M...\
....T.\
s.Rl..
"""
    private let five: String = """
.....v\
......\
..c...\
..h...\
mM..Tm\
......\
shR.hl\
......
"""
    
    private let six: String = """
....v.\
.hc...\
....m.\
......\
.h..h.\
.M...T\
.m..l.\
..sRh.
"""
    
    private let seven: String = """
......\
..c...\
...m..\
...v..\
.h...s\
h.....\
..mMh.\
..RlT.
"""
    
    private let eight: String = """
......\
.....v\
.ch.m.\
.m....\
....l.\
.s.Mm.\
h.hT.h\
...R..
"""
    
    private let nine: String = """
......\
...h..\
.mc.mv\
.m..m.\
h.....\
.mT.mM\
.s.Rl.\
..h...
"""
    
    private let ten: String = """
..v...\
....m.\
.c....\
m..m.s\
.h..T.\
mM..h.\
.lRh..\
......
"""
    
    public init() {
        populateLevelArray()
    }
    
    public func randomLevel() -> String {
        return levelArrays[Int.random(in: 0..<levelArrays.count)]
    }
    
    private func populateLevelArray() {
        levelArrays.append(one)
        levelArrays.append(two)
        levelArrays.append(three)
        levelArrays.append(four)
        levelArrays.append(five)
        levelArrays.append(six)
        levelArrays.append(seven)
        levelArrays.append(eight)
        levelArrays.append(nine)
        levelArrays.append(ten)
    }
}
