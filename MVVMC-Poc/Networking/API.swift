//
//  API.swift
//  
//
//  Created by SUNNY on 22/04/20.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import ObjectMapper

class API {
    
    static let shared:API = {
        let instance = API()
        return instance
    }()
    
    init() {
        
    }
    
    func fetchLiveNews() -> Observable<DashBoardDataModel?> {
//        var rootResponse: DashBoardDataModel?
//        RxAlamofire.requestJSON(.get, APIUrl.URL)
//        .debug()
//        .subscribe(onNext: { (r, json) in
//            if r.statusCode == 200 {
//            rootResponse = Mapper<DashBoardDataModel>().map(JSON: json as! [String : Any])
//            }
//        },
//           onError: { (error) in
//                handler(nil, error)
//        }, onCompleted: {
//            if let rootResponse = rootResponse {
//                handler(rootResponse, nil)
//            }
//        })
        
        return Observable.create({ observer in
            RxAlamofire.requestJSON(.get, APIUrl.URL)
            .debug()
            .subscribe(onNext: { (r,j) in
                if r.statusCode == 200 {
                    let data = Mapper<DashBoardDataModel>().map(JSON: j as! [String : Any])
                    observer.onNext(data)
                    observer.on(.completed)
                    DLog("\(r) ,\(j)")
                }
            },
                onError: { (error) in
                    DLog(error.localizedDescription, logLevel: .error)
                    observer.on(.error(error))
            })
        })
        
        
//        Alamofire.request(APIUrl.URL).responseJSON { response in
//            if(response.response?.statusCode == 200){
//                if let json = response.result.value as AnyObject? {
//                    let rootResponse = Mapper<DashBoardDataModel>().map(JSON: response as! [String : Any])
//                    handler(rootResponse, nil)
//
//                    //let arrayResponse = json["articles"] as! NSArray
//                    //let arrayObject = Mapper<DashBoardDataModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]]);
//                    //self.presenter?.liveNewsFetched(news: (arrayObject[0]))
//                }
//            }
//            else {
//                //self.presenter?.liveNewsFetchedFailed();
//            }
//        }
    }
}
