//
//  BookDetailViewModelTests.swift
//  CarrotSearchBookTests
//
//  Created by 김윤석 on 2023/11/12.
//

import Combine
import XCTest
@testable import CarrotSearchBook

class BookDetailViewModelTests: XCTestCase {
    var viewModel: BookDetailViewModelProtocol!
    var mockRepository: MockBookDetailRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockBookDetailRepository()
        viewModel = BookDetailViewModel(mockRepository, isbn: "TestISBN")
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchBookDetailSuccess() {
        let expectedDetail = BookDetailDomain(title: "Title: Test", subtitle: "", authors: "", publisher: "", language: "", isbn10: "", isbn13: "", pages: "", year: "", rating: "", desc: "", price: "", image: "", url: "", pdf: [:])
        mockRepository.mockBookDetail = expectedDetail

        let expectation = XCTestExpectation(description: "Successfully fetched book detail")

        viewModel.listenPublisher.sink { listenerType in
            if case .updateData = listenerType {
                XCTAssertEqual(self.viewModel.bookDetail, expectedDetail, "Fetched book detail should match expected detail")
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.viewDidLoad()
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchBookDetailError() {
        mockRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Error in fetching book detail")

        viewModel
            .listenPublisher
            .sink { listenerType in
            if case .message(let title, _) = listenerType {
                XCTAssertEqual(title, "Error", "Error message should be triggered")
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.viewDidLoad()
        wait(for: [expectation], timeout: 5.0)
    }

    func testRoutingToBookList() {
        let expectation = XCTestExpectation(description: "Dimiss current view and return to previous feature")

        viewModel
            .transitionPublisher
            .sink { transition in
            switch transition {
            case .dismiss:
                XCTAssert(true, "need to pop current screen")
                expectation.fulfill()
            default:
                break
            }
        }
        .store(in: &cancellables)
        
        //deinit viewModel
        viewModel = nil
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testRoutingToSafariServiceWithLink() {
        let expectation = XCTestExpectation(description: "click link and route to the relative view")
        
        viewModel.viewDidLoad()
        
        viewModel
            .transitionPublisher
            .sink { transition in
            switch transition {
            case .moveToLink(let link):
                XCTAssertEqual(link, "test.com")
                expectation.fulfill()
            default:
                break
            }
        }
        .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.moveToLink("test.com")
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
