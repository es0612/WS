import Nimble
import Quick
import Succinct

@testable import WeightScale

class ListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("List view controller に関するテスト") {
            it("タイトルが見える") {
                let listViewController = ListViewController()


                expect(listViewController.title).to(equal("リスト"))
            }
        }
    }
}
