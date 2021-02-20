//
//  Array+Only.swift
//  Memoreizek
//
//  Created by Richard.ZHENG on 2021/2/2.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
