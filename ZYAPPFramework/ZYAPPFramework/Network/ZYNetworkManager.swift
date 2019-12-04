//
//  ZYNetworkManager.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/4/15.
//  Copyright © 2019 石志愿. All rights reserved.
//

import UIKit

import UIKit
import Alamofire

///域名
let kBaseUrl = ""

final class ZYNetworkManager: NSObject {
    
    /// 单例
    static let shared = ZYNetworkManager()
    private override init() {}
    
    //MARK: public
    
    /* post请求
     *
     * api 相对URL地址
     * parameters 参数
     * successed 成功回调
     * failed 失败回调
     */
    func post(api: String, parameters: [String : Any], showLoading: Bool = true, loadingMessage: String? = nil, successed: @escaping(_ response: [String : Any])->(), failed: ((_ error: NSError?)->())? = nil) {
        postRequest(api: api, parameters: parameters, showLoading: showLoading, loadingMessage: loadingMessage, successed: { (responseObject) in
            successed(responseObject)
        }) { (error) in
            failed?(error)
        }
    }
    
    /* get请求
     *
     * api 相对URL地址
     * parameters 参数
     * successed 成功回调
     * failed 失败回调
     */
    func get(api: String, parameters: [String : Any]?, showLoading: Bool = true, loadingMessage: String? = nil, successed: @escaping(_ response: [String : Any])->(), failed: ((_ error: NSError?)->())? = nil) {
        getRequest(api: api, parameters: parameters, showLoading: showLoading, loadingMessage: loadingMessage, successed: { (responseObject) in
            successed(responseObject)
        }) { (error) in
            failed?(error)
        }
    }
}

extension ZYNetworkManager {
    
    //MARK: base method
    
    /// post
    private func postRequest(api: String, parameters: [String : Any], showLoading: Bool = true, loadingMessage: String? = nil, successed: @escaping(_ responseObject: [String : Any])->(), failed: @escaping(_ error: NSError?)->()) {
        let url = kBaseUrl + api
        ZYPrint("==request: \(url)",parameters)
        if showLoading {
            ZYShowMessage(message: loadingMessage)
        }
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if showLoading {
                ZYHiddenLoading()
            }
            if response.result.isSuccess {
                if let result = response.result.value as? [String : Any] {
                    ZYPrint("==response: \(url)", response.result.value ?? "")
                    successed(result)
                } else {
                    ZYPrint("==response: \(url) -- 数据格式错误", response.result.value ?? "nil")
                }
            } else {
                ZYPrint("==response: \(url)", response.result.error ?? "")
                failed(response.result.error as NSError?)
            }
        }
    }
    
    /// get
    private func getRequest(api: String, parameters: [String : Any]?, showLoading: Bool = true, loadingMessage: String? = nil, successed: @escaping(_ responseObject: [String : Any])->(), failed: @escaping(_ error: NSError?)->()) {
        let url = kBaseUrl + api
        if showLoading {
            ZYShowMessage(message: loadingMessage)
        }
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if showLoading {
                ZYHiddenLoading()
            }
            if response.result.isSuccess {
                if let result = response.result.value as? [String : Any] {
                    ZYPrint("==response: \(url)", response.result.value ?? "")
                    successed(result)
                } else {
                    ZYPrint("==response: \(url) -- 数据格式错误", response.result.value ?? "nil")
                }
            } else {
                ZYPrint("==response: \(url)", response.result.error ?? "")
                failed(response.result.error as NSError?)
            }
        }
    }
}

//MARK: 上传图片/文件
extension ZYNetworkManager {
    
    /* 上传单张图片
     *
     * api 相对URL地址
     * fileData 上传数据
     * filekey  上传到服务器，接受此文件的字段名
     * successed 成功回调
     * failed 失败回调
     */
    func uploadImage(api: String, parameters: [String : String]?, showLoading: Bool = true, image: UIImage, filekey: String, successed: @escaping(_ response: [String: Any])->(), failed: ((_ error: Error?)->())? = nil) {
        if showLoading {
            ZYShowLoading()
        }
        let maxImageLength: CGFloat = 5000
        let maxSizeKB: CGFloat = 10000
        guard let data = image.compressSize(maxImageLength: maxImageLength, maxSizeKB: maxSizeKB) else {
            return
        }
        upload(api: api, parameters: parameters, fileDatas: [data], filekey: filekey, mimeType: "image/png", successed: successed, failed: failed)
    }
    
    /// 上传多张图片
    func uploadImages(api: String, parameters: [String : String]?, showLoading: Bool = true, images: [UIImage], filekey: String, successed: @escaping(_ response: [String: Any])->(), failed: ((_ error: Error?)->())? = nil) {
        if showLoading {
            ZYHiddenLoading()
        }
        var datas = [Data]()
        for image in images {
            if let data = image.compressSize(maxImageLength: 5000, maxSizeKB: 10000) {
                datas.append(data)
            }
        }
        upload(api: api, parameters: parameters, fileDatas: datas, filekey: filekey, mimeType: "image/png", successed: successed, failed: failed)
    }
    
    /// 上传文件
    func uploadData(api: String, parameters: [String : String]?, showLoading: Bool = true, fileData: Data, filekey: String, successed: @escaping(_ response: [String: Any])->(), failed: @escaping(_ error: Error?)->()) {
        upload(api: api, parameters: parameters, fileDatas: [fileData], filekey: filekey, mimeType: "multipart/form-data", successed: { (response) in
            
        }) { (error) in
        }
    }
}

//MARK: upload
extension ZYNetworkManager {
    
    /* 上传文件
     *
     * api 相对URL地址
     * parameters 参数
     * fileDatas 上传数据
     * filekey  上传到服务器，接受此文件的字段名
     * mimeType 文件类型
     * successed 成功回调
     * failed 失败回调
     */
    private func upload(api: String, parameters: [String : String]?, showLoading: Bool = true, fileDatas: [Data], filekey: String, mimeType: String, successed: @escaping(_ response: [String: Any])->(), failed: ((_ error: Error?)->())? = nil) {
        uploadRequest(api: api, parameters: parameters, fileDatas: fileDatas, filekey: filekey, mimeType: mimeType, successed: { (responseObject) in
            successed(responseObject)
        }) { (error) in
            failed?(error)
        }
    }
    
    /// 上传
    private func uploadRequest(api: String, parameters: [String : String]?, showLoading: Bool = true, fileDatas: [Data], filekey: String, mimeType: String, successed: @escaping(_ responseObject: [String: Any])->(), failed: @escaping(_ error: Error?)->()) {
        let url = kBaseUrl + api
        ZYPrint("request: " + url,parameters ?? "")
        Alamofire.upload(multipartFormData: { (formData) in
            if let params = parameters {
                for (key, value) in params {
                    formData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            let suffix = mimeType == "image/png" ? ".png" : ""
            for (i, fileData) in fileDatas.enumerated() {
                let file = "\(Int(Date().timeIntervalSince1970))_\(i)\(suffix)"
                formData.append(fileData, withName: filekey, fileName: file, mimeType: mimeType)
            }
        }, to: url) { (encodingResult) in
            switch encodingResult {
            case .success(let uploadFile, _, _):
                uploadFile.uploadProgress(closure: { (progress) in
                    /// 上传进度
                    //                    ZYPrint("image upload progress: \(progress.fractionCompleted)")
                })
                uploadFile.responseJSON(completionHandler: { (response) in
                    if showLoading {
                        ZYHiddenLoading()
                    }
                    if response.result.isSuccess {
                        if let result = response.result.value as? [String : Any] {
                            ZYPrint("response: \(url)", "response: ", result)
                            successed(result)
                        } else {
                            ZYPrint("response: 数据格式错误 -- \(url)", "response: ", response.result.value ?? "nil")
                        }
                    } else {
                        ZYPrint(response.result.error as Any)
                        failed(response.result.error as NSError?)
                    }
                })
                
            case .failure(let error):
                if showLoading {
                    ZYHiddenLoading()
                }
                failed(error)
                ZYPrint("response: \(url)", "error: ", error)
            }
        }
    }
}
