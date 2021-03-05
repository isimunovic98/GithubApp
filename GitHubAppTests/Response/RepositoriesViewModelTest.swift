//
//  RepositoriesViewModelTest.swift
//  GitHubAppTests
//
//  Created by Ivan Simunovic on 06.03.2021..
//


import Cuckoo
import Quick
import Nimble
import Combine
import UIKit

@testable import GitHubApp

class RepositoriesViewModelTest: QuickSpec {

    func getResource<T: Codable>() -> T? {
        let bundle = Bundle.init(for: GitHubAppTests.self)
        
        guard let resourcePath = bundle.url(forResource: "RepositoriesResponse", withExtension: "json"),
        let data = try? Data(contentsOf: resourcePath),
        let parsedData: T = SerializationManager.parseData(jsonData: data) else {
            return nil
        }
        return parsedData
    }
    
    override func spec() {
        describe("Test for view model") {
            let mockRepository = MockGithubSearchRepository()
            var viewModel: RepositoriesViewModel!
            var disposeBag = Set<AnyCancellable>()
            
            context("Screen data initialized successfuly") {
                beforeEach {
                    setupViewModel()
                    successStub()
                }
                
                it("Screeen initalized") {
                    viewModel.loadData.send(true)
                    expect(viewModel.screenData.count).toEventually(equal(30))
                    expect(viewModel.screenData[0].forksCount).toEventually(equal(40))
                    expect(viewModel.screenData[1].stargazersCount).toEventually(equal(11))
                    expect(viewModel.screenData[0].fullName).toEventually(equal("Attnam/ivan"))
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
                viewModel = RepositoriesViewModel(repository: mockRepository)
                viewModel.initalizeScreenData(for: viewModel.loadData).store(in: &disposeBag)
            }
            
            func successStub() {
                stub(mockRepository) { (mock) in
                    guard let response: GithubRepositoriesResponse = getResource() else {
                        return
                    }
                    let publisher = CurrentValueSubject<Result<GithubRepositoriesResponse, NetworkError>, Never>(.success(response)).eraseToAnyPublisher()
                    when(mock.getGithubRepositories(of: Defaults.getLastSearch())).thenReturn(publisher)

                }
            }
            
            func failStub() {
                stub(mockRepository) { mock in
                    let error = NetworkError.connectionTimedOut
                    let publisher =  CurrentValueSubject<Result<GithubRepositoriesResponse, NetworkError>, Never>(.failure(error)).eraseToAnyPublisher()
                    when(mock.getGithubRepositories(of: Defaults.getLastSearch())).thenReturn(publisher)
                   
                }
            }
        }
    }
}
