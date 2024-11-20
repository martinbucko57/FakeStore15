//
//  String+Extension.swift
//  FakeStore
//
//  Created by Martin Bucko on 19/11/2024.
//

import Foundation

extension String {
    func localize() -> String { NSLocalizedString(self, comment: "") }
}
