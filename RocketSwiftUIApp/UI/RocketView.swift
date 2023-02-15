//
//  RocketView.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 14.02.2023.
//

import SwiftUI
import Combine

struct RocketView: View {
    @StateObject var vm: ViewModel
    var body: some View {
        NavigationView {
            ZStack {
                if vm.loading {
                    LoadingView()
                } else {
                    content
                        .edgesIgnoringSafeArea(.top)
                        .navigationBarHidden(true)
                    
                    NavigationLink(isActive: $vm.showLaunches, destination: {
                        LaunchView(vm: .init(container: vm.container, launches: vm.launches))
                            .navigationTitle(vm.rocket!.name)
                            .navigationBarTitleDisplayMode(.inline)
                    }, label: {
                        EmptyView()
                    })
                }
                
                if vm.isError {
                    ErrorView()
                }
                
            }
            .background(Color.black.ignoresSafeArea())
        }
        .accentColor(.white)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var content: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image("Background")
                    .resizable()

                VStack(spacing: 0) {
                    HStack {
                        Text(vm.rocket!.name)
                            .font(CustomFonts.title2.medium)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: vm.goToSettings, label: {
                            Image(systemName: "gearshape")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 25, height: 25)
                        })
                        .sheet(isPresented: $vm.showSettings) {
                            SettingsView(vm: .init(container: vm.container))
                        }
                    }
                    .padding(.vertical, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0...3, id: \.self) { index in
                                Group {
                                    switch index {
                                    case 0:
                                        ParameterBlock(vm: .init(container: vm.container, rocket: vm.rocket!, type: .height))
                                    case 1:
                                        ParameterBlock(vm: .init(container: vm.container, rocket: vm.rocket!, type: .diameter))
                                    case 2:
                                        ParameterBlock(vm: .init(container: vm.container, rocket: vm.rocket!, type: .mass))
                                    case 3:
                                        ParameterBlock(vm: .init(container: vm.container, rocket: vm.rocket!, type: .weights))
                                    default:
                                        Text("No value")
                                    }
                                }
                                .font(CustomFonts.subheadline.light)
                                .foregroundColor(.gray)
                                .frame(width: 100, height: 100)
                                .background(Color("RectColor"))
                                .cornerRadius(25, corners: .allCorners)
                            }
                        }
                    }
                    .padding(.bottom, 40)
                    
                    Group {
                        HStack {
                            Text("First flight")
                            Spacer()
                            Text("\(dateConverter(vm.rocket!.firstFlight))")
                                .font(CustomFonts.callout.font)
                                .foregroundColor(.white)
                        }
                        HStack {
                            Text("Country")
                            Spacer()
                            Text(vm.rocket!.country.description)
                                .font(CustomFonts.callout.font)
                                .foregroundColor(.white)
                        }
                        HStack {
                            Text("Cost per launch")
                            Spacer()
                            Text("\(costConverter(vm.rocket!.costPerLaunch))")
                                .font(CustomFonts.callout.font)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.vertical, 8)
                    .font(CustomFonts.callout.light)
                    .foregroundColor(.gray)
                    
                    StepBlock(title: "First step",
                              engines: vm.rocket!.firstStage.engines.description,
                              fuelAmountTons: vm.rocket!.firstStage.fuelAmountTons.description,
                              burnTimeSEC: vm.rocket!.firstStage.burnTimeSEC!.description)
                    
                    StepBlock(title: "Second step",
                              engines: vm.rocket!.secondStage.engines.description,
                              fuelAmountTons: vm.rocket!.secondStage.fuelAmountTons.description,
                              burnTimeSEC: vm.rocket!.secondStage.burnTimeSEC!.description)
                    
                    Button(action: vm.goToLaunches, label: {
                        Text("View launches")
                            .frame(maxWidth: .infinity, idealHeight: 45, maxHeight: 45)
                            .foregroundColor(.white)
                            .font(CustomFonts.headline.bold)
                    })
                    .background(Color("RectColor"))
                    .cornerRadius(12, corners: .allCorners)
                    .padding(.top, 40)
                }
                .padding(.horizontal, 20)
                .background(
                    Color.black
                        .cornerRadius(25, corners: [.topLeft, .topRight])
                        .padding(.top, -30)
                )
            }
        }
    }
}

extension RocketView {
    class ViewModel: ObservableObject {
        @Published var loading: Bool = false
        @Published var isError: Bool = false
        @Published var showLaunches: Bool = false
        @Published var showSettings: Bool = false
        
        let container: DIContainer
        var rockets: [RocketModel] = []
        var launches: [LaunchModel] = []
        var rocket: RocketModel?
        private let cancelBag = CancelBag()
        
        init(container: DIContainer) {
            self.container = container

            getRockets()
        }
        
        func getRockets() {
            loading = true
            container.commonServices.getRockets()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] complition in
                    guard let self = self else {return}
                    switch complition {
                    case .failure(_):
                        self.isError = true
                    case .finished:
                        break
                    }
                } receiveValue: {[weak self] rockets in
                    guard let self = self else {return}
                    self.rockets = rockets
                    self.rocket = rockets[0]
                    self.loading = false
                    
                    self.getLaunchs()
                }
                .store(in: cancelBag)
        }
        
        func getLaunchs() {
            container.commonServices.getLaunchs(rocketId: rocket!.id)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] complition in
                    guard let self = self else {return}
                    switch complition {
                    case .failure(_):
                        self.isError = true
                    case .finished:
                        break
                    }
                } receiveValue: {[weak self] launches in
                    guard let self = self else {return}
                    self.launches = launches
                }
                .store(in: cancelBag)
        }
        
        func goToLaunches() {
            showLaunches = true
        }
        
        func goToSettings() {
            showSettings = true
        }
    }
}

struct RocketView_Previews: PreviewProvider {
    static var previews: some View {
        RocketView(vm: .init(container: .preview))
    }
}
