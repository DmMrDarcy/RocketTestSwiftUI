//
//  LaunchView.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import SwiftUI
import Combine

struct LaunchView: View {
    @StateObject var vm: ViewModel
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(0...vm.launches.count-1, id: \.self) { index in
                        let launch = vm.launches[index]
                        LaunchBlock(title: launch.name, date: dateConverter(launch.dateLocal), imagePath: launch.links.patch.small!)
                    }
                }
                .padding(.horizontal, 25)
            }
        }
    }
}

extension LaunchView {
    class ViewModel: ObservableObject {
        
        var launches: [LaunchModel]
        let container: DIContainer
        private let cancelBag = CancelBag()
        
        init(container: DIContainer, launches: [LaunchModel]) {
            self.container = container
            self.launches = launches
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(vm: .init(container: .preview, launches: []))
    }
}
