//
//  RestManager.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//
import Foundation
import Alamofire
import Combine

public class RestManager {
    private static let manager: Alamofire.Session = {
        var configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        let sessionManager = Session(configuration: configuration)
        
        return sessionManager
    }()
    
    public static func requestObservable<T: Codable>(url: String) -> AnyPublisher<Result<T, NetworkError>, Never> {
        return Future { promise in
            guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                return promise(.success(.failure(.invalidUrl)))
            }
            let request = RestManager.manager
                .request(encodedUrl, encoding: URLEncoding.default)
                .validate()
                .responseData { (response) in
                    switch response.result {
                    case .success(let value):
                        if let decodedObject: T = SerializationManager.parseData(jsonData: value) {
                            promise(.success(.success(decodedObject)))
                        } else {
                            promise(.success(.failure(NetworkError.parseFailed)))
                        }
                    case .failure(let error):
                        guard let urlError = error.underlyingError as? URLError else {
                            return promise(.success(.failure(NetworkError.generalError)))
                        }
                        
                        switch urlError.code {
                        case .timedOut:
                            promise(.success(.failure(.connectionTimedOut)))
                        case .notConnectedToInternet:
                            promise(.success(.failure(.notConnectedToInternet)))
                        case .networkConnectionLost:
                            promise(.success(.failure(.networkConnectionLost)))
                        default:
                            promise(.success(.failure(.generalError)))
                        }
                    }
                }
            request.resume()
        }.eraseToAnyPublisher()
    }
}
