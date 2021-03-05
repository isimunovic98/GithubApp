//
//  UsersViewModelTest.swift
//  GitHubAppTests
//
//  Created by Ivan Simunovic on 05.03.2021..
//


import Cuckoo
import Quick
import Nimble
import Combine
import UIKit

@testable import GitHubApp

class UsersViewModelTest: QuickSpec {

    func getResource<T: Codable>() -> T? {
        let bundle = Bundle.init(for: GitHubAppTests.self)
        
        guard let resourcePath = bundle.url(forResource: "UsersResponse", withExtension: "json"),
        let data = try? Data(contentsOf: resourcePath),
        let parsedData: T = SerializationManager.parseData(jsonData: data) else {
            return nil
        }
        return parsedData
    }
    
    override func spec() {
        describe("Test for view model") {
            let mockRepository = MockGithubSearchRepository()
            var viewModel: GithubUsersViewModel!
            var disposeBag = Set<AnyCancellable>()
            
            context("Screen data initialized successfuly") {
                beforeEach {
                    setupViewModel()
                    successStub()
                }
                
                it("Screeen initalized") {
                    viewModel.loadData.send(true)
                    expect(viewModel.screenData.count).toEventually(equal(30))
                    expect(viewModel.screenData[0].login).toEventually(equal("ivan"))
                    expect(viewModel.screenData[1].login).toEventually(equal("SlaSerX"))
                    expect(viewModel.screenData[0].htmlUrl).toEventually(equal("https://github.com/ivan"))
                }
            }
            
            context("Initialization got error") {
                beforeEach {
                    setupViewModel()
                    failStub()
                }
                
                it("Screeen initalized") {
                    viewModel.loadData.send(true)
                    expect(viewModel.screenData.count).toEventually(equal(0))
                }
            }
            
            func setupViewModel() {
                viewModel = GithubUsersViewModel(repository: mockRepository)
                viewModel.initalizeScreenData(for: viewModel.loadData).store(in: &disposeBag)
            }
            
            func successStub() {
                stub(mockRepository) { (mock) in
                    guard let response: GithubUsersResponse = getResource() else {
                        return
                    }
                    let publisher = CurrentValueSubject<Result<GithubUsersResponse, NetworkError>, Never>(.success(response)).eraseToAnyPublisher()
                    when(mock.getGithubUsers(of: Defaults.getLastSearch())).thenReturn(publisher)

                }
            }
            
            func failStub() {
                stub(mockRepository) { mock in
                    let error = NetworkError.connectionTimedOut
                    let publisher =  CurrentValueSubject<Result<GithubUsersResponse, NetworkError>, Never>(.failure(error)).eraseToAnyPublisher()
                    when(mock.getGithubUsers(of: Defaults.getLastSearch())).thenReturn(publisher)
                   
                }
            }
        }
    }
}
