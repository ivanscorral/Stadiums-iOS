//
//  NetworkReachability.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 9/3/23.
//

import Network

/**
 A helper class for checking network reachability.
 
 This class provides a simple way to check whether the device is currently connected to a network with internet access. The `isConnected()` method uses the `Network` framework to determine whether the device is connected to a network with internet access. If the device is connected to a network with internet access, the method returns `true`, otherwise it returns `false`.
 
 - Note: This class does not provide real-time network monitoring. It only checks whether the device is currently connected to a network with internet access at the time of the method call.
 */
class NetworkReachability {
    
    /**
     Determines whether the device is currently connected to a network with internet access.
     
     - Returns: `true` if the device is connected to a network with internet access, `false` otherwise.
     */
    /**
     Determines whether the device is currently connected to a network with internet access.
     
     - Returns: `true` if the device is connected to a network with internet access, `false` otherwise.
     */
    static func isConnected() -> Bool {
        // Create a new path monitor to check for network connectivity
        let monitor = NWPathMonitor()
        // Create a new semaphore to wait for the path update handler to be called
        let semaphore = DispatchSemaphore(value: 0)
        // Initialize the flag for network connectivity
        var isConnected = false
        
        // Set the path update handler to update the isConnected flag when the network status changes
        monitor.pathUpdateHandler = { path in
            isConnected = path.status == .satisfied
            // Signal the semaphore to unblock the waiting thread
            semaphore.signal()
        }
        
        // Create a new serial queue for the path monitor
        let queue = DispatchQueue(label: "NetworkReachability")
        // Start the path monitor on the queue
        monitor.start(queue: queue)
        
        // Wait for the path update handler to be called or time out after 5 seconds
        _ = semaphore.wait(timeout: .now() + 5.0)
        // Cancel the path monitor
        monitor.cancel()
        
        // Return the value of the isConnected flag
        return isConnected
    }

    
}
