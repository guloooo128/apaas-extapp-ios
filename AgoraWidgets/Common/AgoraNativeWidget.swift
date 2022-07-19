//
//  AgoraNativeWidget.swift
//  AgoraWidgets
//
//  Created by Cavan on 2022/7/12.
//

import AgoraWidget

public class AgoraNativeWidget: AgoraBaseWidget, AgoraWidgetLogTube {
    var logger: AgoraWidgetLogger
    
    override init(widgetInfo: AgoraWidgetInfo) {
        
        let logger = AgoraWidgetLogger(widgetId: widgetInfo.widgetId,
                                       logId: widgetInfo.localUserInfo.userUuid)
#if DEBUG
        logger.isPrintOnConsole = true
#endif
        self.logger = logger
        
        super.init(widgetInfo: widgetInfo)
        
        // TODO: better
        setUIMode()
        setUIConfig()
    }
    
    public override func onLoad() {
        super.onLoad()
        
        log(content: "on load",
            extra: info.agDescription,
            type: .info,
            fromClass: self.classForCoder)
    }
    
    public override func onMessageReceived(_ message: String) {
        log(content: "on message received",
            extra: message,
            type: .info,
            fromClass: self.classForCoder)
    }
    
    public override func onWidgetRoomPropertiesUpdated(_ properties: [String : Any],
                                                       cause: [String : Any]?,
                                                       keyPaths: [String],
                                                       operatorUser: AgoraWidgetUserInfo?) {
        super.onWidgetRoomPropertiesUpdated(properties,
                                            cause: cause,
                                            keyPaths: keyPaths,
                                            operatorUser: operatorUser)
        
        let array = ["properties: \(properties.description)",
                     "cause: \(StringIsEmpty(cause?.description))",
                     "keyPaths: \(keyPaths.agDescription)",
                     "operatorUser: \(StringIsEmpty(operatorUser?.agDescription))"]
        
        
        log(content: "on widget room properties updated",
            extra: array.agDescription,
            type: .info,
            fromClass: self.classForCoder)
    }
    
    public override func onWidgetUserPropertiesUpdated(_ properties: [String : Any],
                                                       cause: [String : Any]?,
                                                       keyPaths: [String],
                                                       operatorUser: AgoraWidgetUserInfo?) {
        super.onWidgetUserPropertiesUpdated(properties,
                                            cause: cause,
                                            keyPaths: keyPaths,
                                            operatorUser: operatorUser)
        
        let array = ["properties: \(properties.description)",
                     "cause: \(StringIsEmpty(cause?.description))",
                     "keyPaths: \(keyPaths.agDescription)",
                     "operatorUser: \(StringIsEmpty(operatorUser?.agDescription))"]
        
        log(content: "on widget user properties updated",
            extra: array.agDescription,
            type: .info,
            fromClass: self.classForCoder)
    }
    
    public override func sendMessage(_ message: String) {
        log(content: "send message",
            extra: message,
            type: .info,
            fromClass: self.classForCoder)
        
        super.sendMessage(message)
    }
    
    public override func updateRoomProperties(_ properties: [String : Any],
                                              cause: [String : Any]?,
                                              success: AgoraWidgetCompletion?,
                                              failure: AgoraWidgetErrorCompletion? = nil) {
        let array = ["properties: \(properties.description)",
                     "cause: \(StringIsEmpty(cause?.description))"]
        
        log(content: "update widget room properties",
            extra: array.agDescription,
            type: .info,
            fromClass: self.classForCoder)
        
        super.updateRoomProperties(properties,
                                   cause: cause) { [weak self] in
            guard let `self` = self else {
                return
            }
            
            self.log(content: "update widget room properties successfully",
                     type: .info,
                     fromClass: self.classForCoder)
        } failure: { [weak self] (error) in
            guard let `self` = self else {
                return
            }
            
            self.log(content: "update widget room properties unsuccessfully",
                      type: .error,
                      fromClass: self.classForCoder)
        }

        super.updateRoomProperties(properties,
                                   cause: cause, success: success, failure: failure)
    }
}
