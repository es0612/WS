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

                let expectedWeightData = WeightData()
                expectedWeightData.dateString = "2019/5/1"
                expectedWeightData.weight = 50.0

                stubWeightRepository.loadData_returnValue =
                    [expectedWeightData]

                listViewController = ListViewController(
                    weightRepository: stubWeightRepository,
                    router: spyRouter
                )

                listViewController.viewWillAppear(false)
            }
            
            it("タイトルが見える") {
                expect(listViewController.title)
                    .to(equal("リスト"))
            }

            it("体重データを読み込んで表示する") {
                expect(stubWeightRepository.loadData_wasCalled)
                    .to(beTrue())
                expect(listViewController.hasLabel(withExactText: "2019/5/1"))
                    .to(beTrue())
                expect(listViewController.hasLabel(withExactText: "50.0"))
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
    }
}
