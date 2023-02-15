//
//  SettingsView.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import SwiftUI
import Combine

struct SettingsView: View {
    @StateObject var vm: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("Settings")
                    
                    Spacer()
                    
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(CustomFonts.callout.bold)
                }
                .padding(.bottom, 40)
                
                HStack {
                    Text("Height")
                    Spacer()
                    Picker("Select", selection: $vm.currentHeight) {
                        Text("m").tag(LongUnitsModel.meters)
                        Text("ft").tag(LongUnitsModel.feat)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 150, alignment: .trailing)
                }
                .padding(.bottom, 20)
                
                HStack {
                    Text("Diameter")
                    Spacer()
                    Picker("Select", selection: $vm.currentDiameter) {
                        Text("m").tag(LongUnitsModel.meters)
                        Text("ft").tag(LongUnitsModel.feat)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 150, alignment: .trailing)
                }
                .padding(.bottom, 20)
                
                HStack {
                    Text("Mass")
                    Spacer()
                    Picker("Select", selection: $vm.currentMass) {
                        Text("kg").tag(MassUnitsModel.kg)
                        Text("lb").tag(MassUnitsModel.lb)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 150, alignment: .trailing)
                }
                .padding(.bottom, 20)
                
                HStack {
                    Text("Weights")
                    Spacer()
                    Picker("Select", selection: $vm.currentWeights) {
                        Text("kg").tag(MassUnitsModel.kg)
                        Text("lb").tag(MassUnitsModel.lb)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 150, alignment: .trailing)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .font(CustomFonts.callout.font)
            .foregroundColor(.white)
            .padding(20)
        }
    }
}

extension SettingsView {
    class ViewModel: ObservableObject {
        @Published var currentHeight: LongUnitsModel
        @Published var currentDiameter: LongUnitsModel
        @Published var currentMass: MassUnitsModel
        @Published var currentWeights: MassUnitsModel
        
        let container: DIContainer
        private let cancelBag = CancelBag()
        
        init(container: DIContainer) {
            self.container = container
            let appState = container.appState
            
            currentHeight = appState[\.appProcess.heightRocket]
            currentDiameter = appState[\.appProcess.diameterRocket]
            currentMass = appState[\.appProcess.massRocket]
            currentWeights = appState[\.appProcess.weightsRocket]
            
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
            
            cancelBag.collect {
                $currentHeight
                    .removeDuplicates()
                    .dropFirst()
                    .sink {appState[\.appProcess.heightRocket] = $0}
                $currentDiameter
                    .removeDuplicates()
                    .dropFirst()
                    .sink {appState[\.appProcess.diameterRocket] = $0}
                $currentMass
                    .removeDuplicates()
                    .dropFirst()
                    .sink {appState[\.appProcess.massRocket] = $0}
                $currentWeights
                    .removeDuplicates()
                    .dropFirst()
                    .sink {appState[\.appProcess.weightsRocket] = $0}
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(vm: .init(container: .preview))
    }
}
