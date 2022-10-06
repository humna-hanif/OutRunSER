//
//  Units.swift
//
//  OutRun
//  Copyright (C) 2020 Tim Fraedrich <timfraedrich@icloud.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import Foundation

protocol StandardizedUnit: Unit {
    
    static var standardUnit: Unit { get }
    static var standardBigUnit: Unit { get }
    static var standardBigLocalUnit: Unit { get }
    static var standardSmallLocalUnit: Unit { get }
    
}

// MARK: - UnitLength

extension UnitLength: StandardizedUnit {
    
    static var standardUnit: Unit {
        get {
            return UnitLength.meters
        }
    }
    
    static var standardBigUnit: Unit {
        get {
            return UnitLength.kilometers
        }
    }
    
    static var standardBigLocalUnit: Unit {
        get {
            return Locale.current.usesMetricSystem ? UnitLength.kilometers : UnitLength.miles
        }
    }
    
    static var standardSmallLocalUnit: Unit {
        get {
            return Locale.current.usesMetricSystem ? UnitLength.meters : UnitLength.feet
        }
    }
}

// MARK: - UnitSpeed

public extension UnitSpeed {
    
    static func minutesPerLengthUnit(from lenthUnit: UnitLength) -> UnitSpeed {
        
        let coefficient = lenthUnit.converter.value(fromBaseUnitValue: 1)
        
        return UnitSpeed(
            symbol: "\(UnitDuration.minutes.symbol)/\(lenthUnit.symbol)",
            converter: UnitConverterInverse(coefficient: coefficient / 60)
        )
        
    }
    
    static var feetPerSecond: UnitSpeed {
        get {
            UnitSpeed(
                symbol: "ft/s",
                converter: UnitLength.feet.converter
            )
        }
    }
    
    var isPaceUnit: Bool {
        for unit in [UnitLength.standardUnit, UnitLength.standardBigUnit, UnitLength.standardBigLocalUnit, UnitLength.standardSmallLocalUnit] {
            if let unit = unit as? UnitLength, self == UnitSpeed.minutesPerLengthUnit(from: unit) {
                return true
            }
        }
        return false
    }
    
}

extension UnitSpeed: StandardizedUnit {
    
    static var standardUnit: Unit {
        get {
            return UnitSpeed.metersPerSecond
        }
    }
    
    static var standardBigUnit: Unit {
        get {
            return UnitSpeed.kilometersPerHour
        }
    }
    
    static var standardBigLocalUnit: Unit {
        get {
            return Locale.current.usesMetricSystem ? UnitSpeed.kilometersPerHour : UnitSpeed.milesPerHour
        }
    }
    
    static var standardSmallLocalUnit: Unit {
        get {
            return Locale.current.usesMetricSystem ? UnitSpeed.metersPerSecond : .feetPerSecond
        }
    }
    
}

// MARK: - UnitEnergy

extension UnitEnergy: StandardizedUnit {
    
    static var standardUnit: Unit {
        get {
            return UnitEnergy.kilocalories
        }
    }
    
    static var standardBigUnit: Unit {
        get {
            return standardUnit
        }
    }
    
    static var standardBigLocalUnit: Unit {
        get {
            return standardUnit
        }
    }
    
    static var standardSmallLocalUnit: Unit {
        get {
            return UnitEnergy.calories
        }
    }
}

// MARK: - UnitMass

extension UnitMass: StandardizedUnit {
    
    static var standardUnit: Unit {
        get {
            return UnitMass.kilograms
        }
    }
    
    static var standardBigUnit: Unit {
        get {
            return standardUnit
        }
    }
    
    static var standardBigLocalUnit: Unit {
        get {
            return Locale.current.usesMetricSystem ? UnitMass.kilograms : UnitMass.pounds
        }
    }
    
    static var standardSmallLocalUnit: Unit {
        get {
            return Locale.current.usesMetricSystem ? UnitMass.grams : UnitMass.ounces
        }
    }
}

// MARK: - UnitPower

public extension UnitPower {
    
    static func energyPerMinute(from energyUnit: UnitEnergy) -> UnitPower {
        
        let coefficient = energyUnit.converter.value(fromBaseUnitValue: 1)
        
        return UnitPower(
            symbol: "\(energyUnit.symbol)/\(UnitDuration.minutes.symbol)",
            converter: UnitConverterLinear(coefficient: 60 * coefficient)
        )
        
    }
    
}
