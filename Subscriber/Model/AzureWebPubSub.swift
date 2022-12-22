//
//  AzureWebPubSub.swift
//  Subscriber
//
//  Created by Denis Blondeau on 2022-12-19.
//

import Foundation


struct Ack: Decodable {
    let type: String
    let ackId: Int
    let success: Bool
    let error: AckError?
}

struct AckError: Decodable {
    let name: String
    let message: String
}

//{
//    "type": "ack",
//    "ackId": 1, // The ack id for the request to ack
//    "success": false, // true or false
//    "error": {
//        "name": "Forbidden|InternalServerError|Duplicate",
//        "message": "<error_detail>"
//    }
//}
struct Message: Decodable {
    let type: String
    let from: String
    let group: String
    let dataType: DataType.RawValue
    let data: String
    let fromUserId: String?
}

enum Subprotocol: String {
    case json = "json.webpubsub.azure.v1"
    case jsonReliable = "json.reliable.webpubsub.azure.v1"
    case protobub = "protobuf.webpubsub.azure.v1"
    case protobufReliable = "protobuf.reliable.webpubsub.azure.v1"
}

/*
 Role                               Permission
 Not specified                      The client can send event requests.
 webpubsub.joinLeaveGroup           The client can join/leave any group.
 webpubsub.sendToGroup              The client can publish messages to any group.
 webpubsub.joinLeaveGroup.<group>   The client can join/leave group <group>.
 webpubsub.sendToGroup.<group>      The client can publish messages to group <group>.
*/
enum Permission {
    case joinLeaveGroup(String)
    case sendToGroup(String)
    
    var role: String {
        
        switch self {
            
        case .joinLeaveGroup(let group):
            if group.isEmpty {
                return "webpubsub.joinLeaveGroup"
            } else {
                return "webpubsub.joinLeaveGroup." + group
            }
            
        case .sendToGroup(let group):
            if group.isEmpty {
                return "webpubsub.sendToGroup"
            }
            else {
                return "webpubsub.sendToGroup." + group
            }
        }
    }
}

enum DataType: String {
    case binary
    case json
    case text
}

enum Request  {
    case joinGroup(group: String, ackId: Int = 0)
    case leaveGroup(group: String, ackId: Int = 0)
    case sendToGroup(group: String, ackId: Int = 0, noEcho: Bool = false, dataType: DataType = .json, data: Any)
  
  //  case sendToGroup

    var value: [String: Any] {
        switch self {
            
        case .joinGroup(group: let group, ackId: let ackId):
            if ackId == 0 {
                return ["type": "joinGroup", "group": group]
            } else {
                return ["type": "joinGroup", "group": group, "ackId": ackId]
            }
            
        case .leaveGroup(group: let group, ackId: let ackId):
            if ackId == 0 {
                return ["type": "leaveGroup", "group": group]
            } else {
                return ["type": "leaveGroup", "group": group, "ackId": ackId]
            }
            
        case .sendToGroup(group: let group, ackId: let ackId, noEcho: let noEcho, dataType: let dataType, data: let data):
            
            if ackId == 0 {
                return ["type": "sendToGroup", "group": group, "noEcho": noEcho, "dataType": dataType.rawValue, "data": data]
            }
            else {
                return ["type": "sendToGroup", "group": group, "ackId": ackId, "noEcho": noEcho, "dataType": dataType.rawValue, "data": data]
            }
            
            
        }
    }
    
}


//"type": "sendToGroup",
//   "group": "<group_name>",
//   "ackId" : 1,
//   "noEcho": true|false,
//   "dataType" : "json|text|binary",
//   "data": {}, // data can be string or valid json token depending on the dataType
