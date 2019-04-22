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
    func post(api: String, parameters: [String : Any], successed: @escaping(_ response: [String : Any])->(), failed: ((_ error: NSError?)->())?) {
        postRequest(api: api, parameters: parameters, successed: { (responseObject) in
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
    func get(api: String, parameters: [String : Any]?, successed: @escaping(_ response: AnyObject)->(), failed: @escaping(_ error: NSError?)->()) {
        getRequest(api: api, parameters: parameters, successed: { (responseObject) in
            successed(responseObject)
        }) { (error) in
            failed(error)
        }
    }
    
    /* 上传图片
     *
     * api 相对URL地址
     * fileData 上传数据
     * filekey  上传到服务器，接受此文件的字段名
     * fileName 文件名称
     * successed 成功回调
     * failed 失败回调
     */
    
    func uploadImage(api: String, image: UIImage, filekey: String, fileName: String, successed: @escaping(_ response: AnyObject)->(), failed: @escaping(_ error: NSError?)->()) {
        guard let data = image.pngData() else {
            return
        }
        upload(api: api, fileData: data, filekey: filekey, fileName: fileName, mimeType: "image/png", successed: { (responseObject) in
            successed(responseObject)
        }) { (error) in
            failed(error)
        }
    }
    
    /* 上传文件
     *
     * api 相对URL地址
     * fileData 上传数据
     * filekey  上传到服务器，接受此文件的字段名
     * fileName 文件名称
     * mimeType 文件类型
     * successed 成功回调
     * failed 失败回调
     */
    
    func upload(api: String, fileData: Data, filekey: String, fileName: String, mimeType: String, successed: @escaping(_ response: AnyObject)->(), failed: @escaping(_ error: NSError?)->()) {
        uploadRequest(api: api, fileData: fileData,filekey: filekey, fileName: fileName, mimeType: mimeType, successed: { (responseObject) in
            successed(responseObject)
        }) { (error) in
            failed(error)
        }
    }
}

extension ZYNetworkManager {
    
    //MARK: base method
    
    /// post
    private func postRequest(api: String, parameters: [String : Any], successed: @escaping(_ responseObject: [String : Any])->(), failed: @escaping(_ error: NSError?)->()) {
        ZYPrint("===========request===========\n" + api + "\n",parameters)
        let url = kBaseUrl + api
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                ZYPrint("===========response===========\n" + url + "\n",  response.result.value ?? "nil")
                successed(response.result.value as! Dictionary)
            } else {
                ZYPrint("===========response===========\n" + url + "\n", response.result.error ?? "nil")
                failed(response.result.error as NSError?)
            }
        }
    }
    
    /// get
    private func getRequest(api: String, parameters: [String : Any]?, successed: @escaping(_ responseObject: AnyObject)->(), failed: @escaping(_ error: NSError?)->()) {
        let url = kBaseUrl + api
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                ZYPrint("===========response===========\n" + url + "\n")
                successed(response.result.value as AnyObject)
            } else {
                ZYPrint("===========response===========\n" + url + "\n", response.result.error ?? "nil")
                failed(response.result.error as NSError?)
            }
        }
    }
    
    /// 上传
    private func uploadRequest(api: String, fileData: Data, filekey: String, fileName: String, mimeType: String, successed: @escaping(_ responseObject: AnyObject)->(), failed: @escaping(_ error: NSError?)->()) {
        let url = kBaseUrl + api
        Alamofire.upload(multipartFormData: { (formData) in
            formData.append(fileData, withName: filekey, fileName: fileName, mimeType: mimeType)
        }, to: url) { (encodingResult) in
            switch encodingResult {
            case .success(let uploadFile, _, _):
                uploadFile.uploadProgress(closure: { (progress) in
                    /// 上传进度
                })
                uploadFile.responseJSON(completionHandler: { (response) in
                    if response.result.isSuccess {
                        successed(response.result.value as AnyObject)
                    } else {
                        print(response.result.error as Any)
                        failed(response.result.error as NSError?)
                    }
                })
                
            case .failure(let error):
                ZYPrint("===========response===========\n" + url + "\n", error)
            }
        }
    }
}
