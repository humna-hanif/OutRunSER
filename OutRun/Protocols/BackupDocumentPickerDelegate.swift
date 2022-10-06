//
//  DocumentPickerDelegate.swift
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

import UIKit
import MobileCoreServices

class BackupDocumentPickerDelegate: NSObject, UIDocumentPickerDelegate {
    
    private var viewController: UIViewController
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let url = urls.first else {
            return
        }
        
        _ = viewController.startLoading(title: LS["Loading"], message: LS["Settings.ImportBackupData.Message"])
        
        BackupManager.insertBackup(from: url, completion: { (success, workouts, events) in
            print("was able to read and load backup:", success)
            
            controller.endLoading {
                if success {
                    self.viewController.displayInfoAlert(withMessage: LS["Settings.ImportBackupData.Success"])
                } else {
                    self.viewController.displayError(withMessage: LS["Settings.ImportBackupData.Error"])
                }
            }
        })
        
    }
    
    init(on controller: UIViewController) {
        self.viewController = controller
    }
    
}
