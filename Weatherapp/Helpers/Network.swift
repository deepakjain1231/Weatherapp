//
//  Newwork.swift
//  Weatherapp
//
//  Created by DEEPAK JAIN on 17/10/25.
//

import SwiftUI
import Foundation
import Network

final class Network: ObservableObject {
    
    static let shared = Network()
    
    @Published private(set) var isConnectedToNetwork: Bool = true
    @Published private(set) var status: NWPath.Status = .satisfied
    
    private let monitor: NWPathMonitor
    private let monitorQueue = DispatchQueue(label: "NetworkMonitorQueue")
    
    // MARK: - INIT
    init(requiredInterfaceType: NWInterface.InterfaceType? = nil) {
        if let type = requiredInterfaceType {
            monitor = NWPathMonitor(requiredInterfaceType: type)
        } else {
            monitor = NWPathMonitor()
        }
        
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.status = path.status
                self?.isConnectedToNetwork = (path.status == .satisfied)
            }
        }
        
        monitor.start(queue: monitorQueue)
    }
    
    deinit {
        monitor.cancel()
    }
    
    // Optional helper to get a human-friendly reason
    var connectionDescription: String {
        switch status {
        case .satisfied:
            return "Connected"
        case .unsatisfied:
            return "No Connection"
        case .requiresConnection:
            return "Requires Connection"
        @unknown default:
            return "Unknown"
        }
    }
}
     
