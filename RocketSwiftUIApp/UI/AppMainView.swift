//
//  ContentView.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 14.02.2023.
//

import SwiftUI

struct AppMainView: View {
    @StateObject var vm: AppMainViewVM
    var body: some View {
        Group {
            switch vm.currentState {
            case .rocket:
                RocketView(vm: .init(container: vm.container))
            }
        }
        .transition(.backslide)
    }
}

extension AppMainView {
    class AppMainViewVM: ObservableObject {
        @Published var currentState: RoutingModel = .rocket
        @Published var text: String = "Hello"
        
        let container: DIContainer
        private let cancelBag = CancelBag()
        
        init(container: DIContainer) {
            self.container = container
            
            container.appState.map(\.routing.appCurrentState)
                .dropFirst()
                .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] state in
                    guard let self = self else { return }
                    withAnimation {
                        self.currentState = state
                    }
                }
                .store(in: cancelBag)
        }
    }
}


struct AppMainView_Previews: PreviewProvider {
    static var previews: some View {
        AppMainView(vm: .init(container: .preview))
    }
}
