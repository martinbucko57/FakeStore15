//
//  View+Extension.swift
//  FakeStore
//
//  Created by Martin Bucko on 19/11/2024.
//

import SwiftUI

extension View {
    func emptyState<EmptyContent>(
        _ isEmpty: Bool,
        emptyContent: @escaping () -> EmptyContent
    ) -> some View where EmptyContent: View {
        modifier(EmptyStateViewModifier(isEmpty: isEmpty, emptyContent: emptyContent))
  }
}
