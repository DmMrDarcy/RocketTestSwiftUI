//
//  StorageRepo.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import Foundation
import SwiftUI

fileprivate enum ConstantsLocal {
    static let heightRocket = "heightRocket"
    static let diameterRocket = "diameterRocket"
    static let massRocket = "massRocket"
    static let weightsRocket = "weightsRocket"
}

protocol StorageRepoProtocol {
    var heightRocket: LongUnitsModel {get set}
    var diameterRocket: LongUnitsModel {get set}
    var massRocket: MassUnitsModel {get set}
    var weightsRocket: MassUnitsModel {get set}
}

class StorageRepo: StorageRepoProtocol {
    var heightRocket: LongUnitsModel {
        get {
            return self.height_rocket.decode() ?? .meters
        }
        set {
            self.height_rocket = newValue.data
        }
    }
    var diameterRocket: LongUnitsModel {
        get {
            return self.diameter_rocket.decode() ?? .meters
        }
        set {
            self.diameter_rocket = newValue.data
        }
    }
    var massRocket: MassUnitsModel {
        get {
            return self.mass_rocket.decode() ?? .kg
        }
        set {
            self.mass_rocket = newValue.data
        }
    }
    var weightsRocket: MassUnitsModel {
        get {
            return self.weights_rocket.decode() ?? .lb
        }
        set {
            self.weights_rocket = newValue.data
        }
    }
    
    @AppStorage(ConstantsLocal.heightRocket) private var height_rocket: Data = Data()
    @AppStorage(ConstantsLocal.diameterRocket) private var diameter_rocket: Data = Data()
    @AppStorage(ConstantsLocal.massRocket) private var mass_rocket: Data = Data()
    @AppStorage(ConstantsLocal.weightsRocket) private var weights_rocket: Data = Data()
}
