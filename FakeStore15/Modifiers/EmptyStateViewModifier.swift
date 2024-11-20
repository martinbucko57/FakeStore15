//
//  EmptyStateViewModifier.swift
//  FakeStore
//
//  Created by Martin Bucko on 19/11/2024.
//

import SwiftUI

struct EmptyStateViewModifier<EmptyContent>: ViewModifier where EmptyContent: View {
    var isEmpty: Bool
    let emptyContent: () -> EmptyContent
    
    func body(content: Content) -> some View {
        if isEmpty {
            emptyContent()
        }
        else {
            content
        }
    }
}
