//
//  GetIPAddres.swift
//  CSSI
//
//  Created by apple on 11/18/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation
func getIP()-> String? {
    
    var address: String?
    var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next } // memory has been renamed to pointee in swift 3 so changed memory to pointee
            
            let interface = ptr?.pointee
            let addrFamily = interface?.ifa_addr.pointee.sa_family
            
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6)
            {
                //Modified by kiran V3.0 - ENGAGE0012379 -- Added filter to get only ipv4 address and added support for mobile data ip address
                //ENGAGE0012379 -- Start
                let name: String = String(cString: (interface?.ifa_name)!)
                if name == "en0" || name == "pdp_ip0"
                {  // String.fromCString() is deprecated in Swift 3. So use the following code inorder to get the exact IP Address.
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                    
                    let ipAddress = String(cString: hostname)
                    let ipRegEx = "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})"
                    let patters = NSPredicate.init(format: "SELF MATCHES %@", ipRegEx)
                    if patters.evaluate(with: ipAddress)
                    {
                        address = ipAddress
                    }
                    
                    //Old logic
                    //address = String(cString: hostname)
                }
                //ENGAGE0012379 -- End
                
            }
        }
        freeifaddrs(ifaddr)
    }
    
    return address
}
