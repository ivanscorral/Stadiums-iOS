//
//  NetworkReachability.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 9/3/23.
//

import Network
import SystemConfiguration

/**
 A helper class for checking network reachability.
 
 This class provides a simple way to check whether the device is currently connected to a network with internet access. The `isConnected()` method uses the `Network` framework to determine whether the device is connected to a network with internet access. If the device is connected to a network with internet access, the method returns `true`, otherwise it returns `false`.
 
 - Note: This class does not provide real-time network monitoring. It only checks whether the device is currently connected to a network with internet access at the time of the method call.
 */
class NetworkReachability {
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return isReachable && !needsConnection
    }
    /**
     Determines whether the device is currently connected to a network with internet access.
     
     - Returns: `true` if the device is connected to a network with internet access, `false` otherwise.
     */
    /**
     Determines whether the device is currently connected to a network with internet access.
     
     - Returns: `true` if the device is connected to a network with internet access, `false` otherwise.
     */
    static func isConnected() -> Bool {
//        // Create a new path monitor to check for network connectivity
//        let monitor = NWPathMonitor()
//        // Create a new semaphore to wait for the path update handler to be called
//        let semaphore = DispatchSemaphore(value: 0)
//        // Initialize the flag for network connectivity
//        var isConnected = false
//
//        // Set the path update handler to update the isConnected flag when the network status changes
//        monitor.pathUpdateHandler = { path in
//            isConnected = path.status == .satisfied
//            // Signal the semaphore to unblock the waiting thread
//            semaphore.signal()
//        }
//
//        // Create a new serial queue for the path monitor
//        let queue = DispatchQueue(label: "NetworkReachability")
//        // Start the path monitor on the queue
//        monitor.start(queue: queue)
//
//        // Wait for the path update handler to be called or time out after 10 seconds
//        _ = semaphore.wait(timeout: .now() + 10.0)        // Cancel the path monitor
//        monitor.cancel()
//
//        // Return the value of the isConnected flag
//        return isConnected
        return isConnectedToNetwork()
    }

    
}
