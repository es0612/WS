import Nimble
import Quick
import Succinct

@testable import WeightScale

class ListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("List view controller に関するテスト") {
            var stubWeightRepository: StubWeightRepository!
            var listViewController: ListViewController!

            beforeEach {
                stubWeightRepository = StubWeightRepository()
                listViewController = ListViewController(weightRepository: stubWeightRepository)
            }
            it("タイトルが見える") {
                expect(listViewController.title)
                    .to(equal("リスト"))
            }

            it("体重データを読み込んで表示する") {
                expect(stubWeightRepository.loadData_wasCalled)
                    .to(beTrue())
            }
        }
    }
}
