// MARK: - Mocks generated from file: GitHubApp/Shared/Networking/Repositories/GithubSearchRepository.swift at 2021-03-05 22:50:50 +0000

//
//  GithubRepositoriesRepository.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import Cuckoo
@testable import GitHubApp

import Combine
import Foundation


 class MockGithubSearchRepository: GithubSearchRepository, Cuckoo.ProtocolMock {
    
     typealias MocksType = GithubSearchRepository
    
     typealias Stubbing = __StubbingProxy_GithubSearchRepository
     typealias Verification = __VerificationProxy_GithubSearchRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GithubSearchRepository?

     func enableDefaultImplementation(_ stub: GithubSearchRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getGithubRepositories(of query: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never> {
        
    return cuckoo_manager.call("getGithubRepositories(of: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>",
            parameters: (query),
            escapingParameters: (query),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getGithubRepositories(of: query))
        
    }
    
    
    
     func getGithubUsers(of query: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never> {
        
    return cuckoo_manager.call("getGithubUsers(of: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>",
            parameters: (query),
            escapingParameters: (query),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getGithubUsers(of: query))
        
    }
    

	 struct __StubbingProxy_GithubSearchRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getGithubRepositories<M1: Cuckoo.Matchable>(of query: M1) -> Cuckoo.ProtocolStubFunction<(String), AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGithubSearchRepository.self, method: "getGithubRepositories(of: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>", parameterMatchers: matchers))
	    }
	    
	    func getGithubUsers<M1: Cuckoo.Matchable>(of query: M1) -> Cuckoo.ProtocolStubFunction<(String), AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGithubSearchRepository.self, method: "getGithubUsers(of: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GithubSearchRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getGithubRepositories<M1: Cuckoo.Matchable>(of query: M1) -> Cuckoo.__DoNotUse<(String), AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return cuckoo_manager.verify("getGithubRepositories(of: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getGithubUsers<M1: Cuckoo.Matchable>(of query: M1) -> Cuckoo.__DoNotUse<(String), AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return cuckoo_manager.verify("getGithubUsers(of: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GithubSearchRepositoryStub: GithubSearchRepository {
    

    

    
     func getGithubRepositories(of query: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>).self)
    }
    
     func getGithubUsers(of query: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>).self)
    }
    
}



 class MockGithubSearchRepositoryImpl: GithubSearchRepositoryImpl, Cuckoo.ClassMock {
    
     typealias MocksType = GithubSearchRepositoryImpl
    
     typealias Stubbing = __StubbingProxy_GithubSearchRepositoryImpl
     typealias Verification = __VerificationProxy_GithubSearchRepositoryImpl

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: GithubSearchRepositoryImpl?

     func enableDefaultImplementation(_ stub: GithubSearchRepositoryImpl) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getGithubUsers(of query: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never> {
        
    return cuckoo_manager.call("getGithubUsers(of: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>",
            parameters: (query),
            escapingParameters: (query),
            superclassCall:
                
                super.getGithubUsers(of: query)
                ,
            defaultCall: __defaultImplStub!.getGithubUsers(of: query))
        
    }
    
    
    
     override func getGithubRepositories(of query: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never> {
        
    return cuckoo_manager.call("getGithubRepositories(of: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>",
            parameters: (query),
            escapingParameters: (query),
            superclassCall:
                
                super.getGithubRepositories(of: query)
                ,
            defaultCall: __defaultImplStub!.getGithubRepositories(of: query))
        
    }
    

	 struct __StubbingProxy_GithubSearchRepositoryImpl: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getGithubUsers<M1: Cuckoo.Matchable>(of query: M1) -> Cuckoo.ClassStubFunction<(String), AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGithubSearchRepositoryImpl.self, method: "getGithubUsers(of: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>", parameterMatchers: matchers))
	    }
	    
	    func getGithubRepositories<M1: Cuckoo.Matchable>(of query: M1) -> Cuckoo.ClassStubFunction<(String), AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGithubSearchRepositoryImpl.self, method: "getGithubRepositories(of: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GithubSearchRepositoryImpl: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getGithubUsers<M1: Cuckoo.Matchable>(of query: M1) -> Cuckoo.__DoNotUse<(String), AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return cuckoo_manager.verify("getGithubUsers(of: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getGithubRepositories<M1: Cuckoo.Matchable>(of query: M1) -> Cuckoo.__DoNotUse<(String), AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return cuckoo_manager.verify("getGithubRepositories(of: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GithubSearchRepositoryImplStub: GithubSearchRepositoryImpl {
    

    

    
     override func getGithubUsers(of query: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>).self)
    }
    
     override func getGithubRepositories(of query: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>).self)
    }
    
}

