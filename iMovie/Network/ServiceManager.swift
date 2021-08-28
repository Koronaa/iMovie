//
//  ServiceManager.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation
import Alamofire
import RxSwift

protocol ServiceManager {
    typealias onAPIRxResponse = (_ observable:Observable<(Data?,Int)>)->()
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters?,onResponse:@escaping onAPIRxResponse)
    static var sessionManager:Session {get set}
}

class ServiceManagerIMPL:ServiceManager{
    
    internal static var sessionManager:Session = {
        let config = URLSessionConfiguration.af.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify({ _, response in
            let userInfo = ["date":Date()]
            return CachedURLResponse(response: response.response, data: response.data, userInfo: userInfo, storagePolicy: .allowed)
        }))
        return Session(configuration: config,cachedResponseHandler: responseCacher)
    }()
    
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters? = nil,onResponse: @escaping onAPIRxResponse){
        Log(url.absoluteString)
        sessionManager.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { response in
            if let statusCode = response.response?.statusCode {
                onResponse(Observable.just((response.data,statusCode)))
            }else{
                onResponse(Observable.just((nil,999)))
            }
        }
    }
}
