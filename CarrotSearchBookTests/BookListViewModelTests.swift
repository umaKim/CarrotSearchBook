//
//  BookListViewModelTests.swift
//  BookListViewModelTests
//
//  Created by 김윤석 on 2023/11/12.
//

import Combine
import XCTest
@testable import CarrotSearchBook

class BookListViewModelTests: XCTestCase {
    var viewModel: BookListViewModelProtocol!
    var mockRepository: MockBookListRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockBookListRepository()
        viewModel = BookListViewModel(mockRepository)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchBooksSuccess() {
        let expectation = XCTestExpectation(description: "Successfully fetched books")

        viewModel.listenPublisher.sink { [weak self] listenerType in
            if case .update = listenerType {
                print(self?.viewModel.books)
                XCTAssertTrue(self?.viewModel.books.count == 1, "Books count should be 1")
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.updateQuery("Test", completion: {})
        wait(for: [expectation], timeout: 500.0)
    }

    func testFetchBooksEmpty() {
        mockRepository.shouldReturnEmpty = true
        let expectation = XCTestExpectation(description: "No books fetched")

        viewModel
            .listenPublisher
            .sink { [weak self] listenerType in
            if case .update = listenerType {
                XCTAssertTrue(self?.viewModel.books.isEmpty == true, "Books array should be empty")
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.updateQuery("Test", completion: {})
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchBooksError() {
        mockRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Error in fetching books")

        viewModel
            .listenPublisher
            .sink { listenerType in
            if case .message(let title, _) = listenerType {
                XCTAssertEqual(title, "Error", "Error message should be triggered")
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.updateQuery("Test", completion: {})
        wait(for: [expectation], timeout: 5.0)
    }
}
