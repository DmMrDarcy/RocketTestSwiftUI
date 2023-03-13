//
//  ParameterBlock.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import SwiftUI
import Combine

struct ParameterBlock: View {
    @StateObject var vm: ViewModel
    var body: some View {
        VStack(spacing: 5) {
            Text(vm.valueParam())
                .font(CustomFonts.callout.bold)
                .foregroundColor(.white)
            Text(vm.title() + ", " + vm.typeUnit())
        }
    }
}

extension ParameterBlock {
    class ViewModel: ObservableObject {
        private var rocket: RocketModel
        private let container: DIContainer
        private var type: TypeRocketParamsModel
        private var heightUnit: LongUnitsModel = .feat
        private var diameterUnit: LongUnitsModel = .feat
        private var massUnit: MassUnitsModel = .lb
        private var weightsUnit: MassUnitsModel = .kg
        private let cancelBag = CancelBag()
        
        init(container: DIContainer, rocket: RocketModel, type: TypeRocketParamsModel) {
            self.container = container
            self.rocket = rocket
            self.type = type
            
            heightUnit = container.appState[\.appProcess.heightRocket]
            diameterUnit = container.appState[\.appProcess.diameterRocket]
            massUnit = container.appState[\.appProcess.massRocket]
            weightsUnit = container.appState[\.appProcess.weightsRocket]
            
            container.appState.map(\.appProcess.heightRocket)
                .dropFirst()
                .removeDuplicates()
                .sink { [weak self] heightUnit in
                    guard let self = self else { return }
                    self.heightUnit = heightUnit
                }
                .store(in: cancelBag)
            
            container.appState.map(\.appProcess.diameterRocket)
                .dropFirst()
                .removeDuplicates()
                .sink { [weak self] diameterUnit in
                    guard let self = self else { return }
                    self.diameterUnit = diameterUnit
                }
                .store(in: cancelBag)
            
            container.appState.map(\.appProcess.massRocket)
                .dropFirst()
                .removeDuplicates()
                .sink { [weak self] massUnit in
                    guard let self = self else { return }
                    self.massUnit = massUnit
                }
                .store(in: cancelBag)
            
            
            container.appState.map(\.appProcess.weightsRocket)
                .dropFirst()
                .removeDuplicates()
                .sink { [weak self] weightsUnit in
                    guard let self = self else { return }
                    self.weightsUnit = weightsUnit
                }
                .store(in: cancelBag)
        }
        
        func valueParam() -> String {
            switch type {
            case .height:
                return heightUnit == .feat ? rocket.height.feet!.description : rocket.height.meters!.description
            case .diameter:
                return diameterUnit == .feat ? rocket.diameter.feet!.description : rocket.diameter.meters!.description
            case .mass:
                return massUnit == .lb ? rocket.mass.kg.description : rocket.mass.lb.description
            case .weights:
                return weightsUnit == .lb ? rocket.payloadWeights[0].kg.description : rocket.payloadWeights[0].lb.description
            }
        }
        
        func title() -> String {
            switch type {
            case .height:
                return "Height"
            case .diameter:
                return "Diameter"
            case .mass:
                return "Mass"
            case .weights:
                return "Weights"
            }
        }
        
        func typeUnit() -> String {
            switch type {
            case .height:
                return heightUnit == .feat ? "ft" : "m"
            case .diameter:
                return diameterUnit == .feat ? "ft" : "m"
            case .mass:
                return massUnit == .lb ? "lb" : "kg"
            case .weights:
                return weightsUnit == .lb ? "lb" : "kg"
            }
        }
        
    }
}
