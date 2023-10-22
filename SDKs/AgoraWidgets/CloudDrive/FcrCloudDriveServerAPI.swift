//
//  FcrCloudDriveServerAPI.swift
//  AgoraWidgets
//
//  Created by ZYP on 2021/10/21.
//

import Armin

class FcrCloudDriveServerAPI: AgoraWidgetServerAPI {
    typealias SuccessBlock<FcrCloudDriveFileListServerObject> = (FcrCloudDriveFileListServerObject) -> ()
    
    func requestResourceInUser(pageNo: Int,
                               pageSize: Int,
                               resourceName: String? = nil,
                               success: @escaping SuccessBlock<FcrCloudDriveFileListServerObject>,
                               failure: @escaping FailureCompletion) {
        let path = "/edu/apps/\(appId)/v3/users/\(userId)/resources/page"
        let urlString = host + path
        
        var parameters: [String : Any] = ["pageNo" : pageNo,
                                          "pageSize" : pageSize]
        
        if let `resourceName` = resourceName {
            parameters["resourceName"] = resourceName
        }
        
        request(event: "cloud-drive-file-list",
                url: urlString,
                method: .get,
                parameters: parameters) { json in
            if let dataDic = json["data"] as? [String: Any],
               let source = dataDic.toObject(FcrCloudDriveFileListServerObject.self) {
                success(source)
            } else {
                failure(NSError(domain: "decode",
                                code: -1))
            }
        } failure: { error in
            failure(error)
        }
    }
    
    func requestDeleteResourceInUser(resourceUuid: String,
                                     success: @escaping StringCompletion,
                                     failure: @escaping FailureCompletion) {
        let path = "/edu/apps/\(appId)/v3/users/\(userId)/resources"
        let urlString = host + path
        
        var parameters: [String : Any] = ["resourceUuid" : resourceUuid]
        
        request(event: "cloud-drive-delete-file",
                url: urlString,
                method: .get,
                parameters: parameters) { json in
            success(resourceUuid)
        } failure: { error in
            failure(error)
        }
    }
}
