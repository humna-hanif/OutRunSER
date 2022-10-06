//
//  WorkoutBuilderComponentStatus.swift
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

/// An enumeration indicating whether or not the component is ready for the recording to be started.
public enum WorkoutBuilderComponentStatus: Equatable {
    
    /// Indicates that the component is ready to record and provides the kind of component being ready.
    case ready(WorkoutBuilderComponent.Type)
    /// Indicates that the component is still preparing and provides the kind of component the builder is supposed to wait for.
    case preparing(WorkoutBuilderComponent.Type)
    
    // MARK: - Equatable
    
    public static func == (lhs: WorkoutBuilderComponentStatus, rhs: WorkoutBuilderComponentStatus) -> Bool {
        switch (lhs, rhs) {
        case (.ready(let lhsType), .ready(let rhsType)),
             (.preparing(let lhsType), .preparing(let rhsType)):
            return lhsType == rhsType
        default:
            return false
        }
    }
    
}
