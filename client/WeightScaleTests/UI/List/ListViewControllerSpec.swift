import Nimble
import Quick
import Succinct

@testable import WeightScale

class ListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("List view controller に関するテスト") {
            var stubWeightRepository: StubWeightRepository!
            var spyRouter: SpyRouter!
            var listViewController: ListViewController!

            beforeEach {
                stubWeightRepository = StubWeightRepository()
                spyRouter = SpyRouter()
            }

            it("今日の体重を入力してない場合、入力画面へ遷移する") {
                stubWeightRepository
                    .checkInputOfToday_returnValue = false

                listViewController = ListViewController(
                    weightRepository: stubWeightRepository,
                    router: spyRouter
                )

                listViewController.viewWillAppear(false)

                
                expect(stubWeightRepository.checkInputOfToday_wasCalled)
                    .to(beTrue())
                expect(spyRouter.showInputScreen_wasCalled)
                    .to(beTrue())
            }

            describe("今日の体重を入力済みの場合、リスト画面を表示する") {
                beforeEach {
                    stubWeightRepository
                        .checkInputOfToday_returnValue = true

                    let expectedWeightData = WeightData()
                    expectedWeightData.dateString = "2019/05/01"
                    expectedWeightData.weight = 50.0

                    stubWeightRepository.loadData_returnValue =
                        [expectedWeightData]

                    listViewController = ListViewController(
                        weightRepository: stubWeightRepository,
                        router: spyRouter
                    )

                    listViewController.viewWillAppear(false)
                }

                it("入力画面へ遷移しない") {
                    expect(spyRouter.showInputScreen_wasCalled)
                        .to(beFalse())
                }

                it("タイトルが見える") {
                    expect(listViewController.title)
                        .to(equal("記録"))
                }

                it("体重データを読み込んで表示する") {
                    expect(stubWeightRepository.loadData_wasCalled)
                        .to(beTrue())
                    expect(listViewController.hasLabel(withExactText: "2019/05/01"))
                        .to(beTrue())
                    expect(listViewController.hasLabel(withExactText: "50.0 kg"))
                        .to(beTrue())
                }

                describe("入力ボタンに関するテスト") {
                    var barButtonItem: UIBarButtonItem!

                    beforeEach {
                        barButtonItem = listViewController
                            .navigationItem
                            .rightBarButtonItem
                    }

                    it("ナビゲーションバーに入力ボタンが見える") {
                        expect(barButtonItem?.image)
                            .to(equal(UIImage(assetIdentifier: .inputIcon)))
                    }

                    it("入力ボタンを押すと入力画面に遷移する") {
                        barButtonItem?.tap()


                        expect(spyRouter.showInputScreen_wasCalled)
                            .to(beTrue())
                    }
                }
            }

            describe("テーブルビューについて") {
                var tableView: UITableView!

                beforeEach {
                    stubWeightRepository
                        .checkInputOfToday_returnValue = true

                    let expectedWeightData = WeightData()
                    expectedWeightData.dateString = DateManager.getToday()
                    expectedWeightData.weight = 1.0

                    stubWeightRepository.loadData_returnValue =
                        [expectedWeightData]

                    listViewController = ListViewController(
                        weightRepository: stubWeightRepository,
                        router: spyRouter
                    )

                    listViewController.viewWillAppear(false)

                    tableView = listViewController.view.findTableView()

                }

                it("テーブルが見える") {
                    expect(tableView).notTo(beNil())
                }

                it("テーブルの１行目が選択された状態で見える") {
                    let selectedCell = tableView?.visibleCells.first


                    expect(selectedCell?.isSelected)
                        .to(beTrue())
                }
            }
        }
    }
}

extension UIView {
    public func findTableView() -> UITableView? {
        for subview in subviews {
            if let tableView = subview as? UITableView {
                return tableView
            }

            if let tableView = subview.findTableView() {
                return tableView
            }
        }

        return nil
    }
}
