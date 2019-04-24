import Nimble
import Quick
import Succinct

@testable import WeightScale

class SettingViewControllerSpec: QuickSpec {
    override func spec() {
        describe("setting view controller に関するテスト") {
            it("タイトルが見える") {
                let settingViewController = SettingViewController()


                expect(settingViewController.title).to(equal("設定"))
            }
        }
    }
}

