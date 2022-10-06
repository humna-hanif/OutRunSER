//
//  DataManager+Error.swift
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
import CoreStore

extension DataManager {
    
    // MARK: - Manipulation Errors
    
    /// An enumeration of possible errors coming up during the setup of data management.
    enum SetupError: Error, CustomDebugStringConvertible {
        
        /// CoreStore failed to add the SQLiteStorage to the DataStack.
        case failedToAddStorage(error: CoreStoreError)
        /// While performing intermediate mapping actions in between migrations, the mapping action closure returned with a failure indication.
        case intermediateMappingActionsFailed(version: ORDataModel.Type)
        
        var debugDescription: String {
            switch self {
            case .failedToAddStorage(let error):
                return "CoreStore failed to add the SQLiteStorage to the DataStack:\n \(error.debugDescription)"
            case .intermediateMappingActionsFailed(let version):
                return "While performing intermediate mapping actions in between migrations, the mapping action closure returned with a failure indication for version: \(version.identifier)"
            }
        }
    }
    
    /// An enumeration of possible errors coming up during the saving process of an object by the `DataManager`.
    enum SaveError: Error, CustomDebugStringConvertible {
        
        /// The object already exists inside the database.
        case alreadySaved
        /// The object could not be validated.
        case notValid
        /// There was an error while trying to insert the object into the database.
        case databaseError(error: CoreStoreError)
        
        var debugDescription: String {
            switch self {
            case .alreadySaved:
                return "The object already exists inside the database."
            case .notValid:
                return "The object could not be validated"
            case .databaseError(let error):
                return "There was an error while trying to insert the object into the database:\n\(error.debugDescription)"
            }
        }
    }
    
    /// An enumeration of possible errors coming up during the saving process of multiple objects by the `DataManager`.
    enum SaveMultipleError: Error, CustomDebugStringConvertible {
        
        /// Not all data sets provided could be saved to the database.
        case notAllSaved
        /// Not all objects could be valided, only the ones that could be, were saved to the database.
        case notAllValid
        /// There was an error while trying to insert the objects into the database.
        case databaseError(error: CoreStoreError)
    
        var debugDescription: String {
            switch self {
            case .notAllSaved:
                return "Not all data sets provided could be saved to the database."
            case .notAllValid:
                return "Not all objects could be valided, only the ones that could be, were saved to the database."
            case .databaseError(let error):
                return "There was an error while trying to insert the objects into the database:\n\(error.debugDescription)"
            }
        }
    }
    
    /// An enumeration of possible errors coming up during the updating process of multiple objects by the `DataManager`.
    enum UpdateError: Error, CustomDebugStringConvertible {
        
        /// This workout was not saved to the database yet, so it cannot be altered.
        case notSaved
        /// The provided data set is equal to the one saved in the database.
        case notAltered
        /// The object could not be validated.
        case notValid
        /// There was an error while trying to update the workout.
        case databaseError(error: CoreStoreError)
        
        var debugDescription: String {
            switch self {
            case .notSaved:
                return "This workout was not saved to the database yet, so it cannot be altered."
            case .notAltered:
                return "The provided data set is equal to the one saved in the database."
            case .notValid:
                return "The object could not be validated."
            case .databaseError(let error):
                return "There was an error while trying to update the workout:\n\(error)"
            }
        }
        
    }
    
    /// An enumeration of possible errors coming up during the updating process of multiple objects by the `DataManager`.
    enum DeleteError: Error, CustomDebugStringConvertible {
        
        /// This workout was not saved to the database yet, so it cannot be deleted.
        case notSaved
        /// There was an error while trying to delete the workout.
        case databaseError(error: CoreStoreError)
        
        var debugDescription: String {
            switch self {
            case .notSaved:
                return "This workout was not saved to the database yet, so it cannot be deleted."
            case .databaseError(let error):
                return "There was an error while trying to delete the workout:\n\(error)"
            }
        }
        
    }
    
    // MARK: - Query Errors
    
    /// An enumeration of possible errors coming up during the query process of route location data
    enum LocationQueryError: Error, CustomDebugStringConvertible {
        
        /// The specified `ORWorkoutInterface` object was not yet saved to the database, no query on it can be performed.
        case notSaved
        /// The specified workout does not have any route data
        case noRouteData
        /// There was an error while trying to query locations from the workout.
        case databaseError(error: CoreStoreError)
        
        var debugDescription: String {
            switch self {
            case .notSaved:
                return "The specified `ORWorkoutInterface` object was not yet saved to the database, no query on it can be performed."
            case .noRouteData:
                return "The specified workout does not have any route data"
            case .databaseError(let error):
                return "There was an error while trying to query locations from the workout:\n\(error)"
            }
        }
        
    }
    
    /// An enumeration of possible errors coming up during the query process of backup data
    enum BackupQueryError: Error, CustomDebugStringConvertible {
        
        /// Fetching all objects to be included in the backup failed.
        case fetchFailed
        /// Encoding the backup object to JSON format failed.
        case encodeFailed
        /// There was an error while querying the objects to be included in the backup.
        case databaseError(error: CoreStoreError)
            
        var debugDescription: String {
            switch self {
            case .fetchFailed:
                return "Fetching all objects to be included in the backup failed."
            case .encodeFailed:
                return "Encoding the backup object to JSON format failed."
            case .databaseError(let error):
                return "There was an error while querying the objects to be included in the backup:\n\(error)"
            }
        }
        
    }
    
}
