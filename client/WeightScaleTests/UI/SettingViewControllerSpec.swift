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

            it("目標体重のラベルが見える") {
                let settingViewController = SettingViewController()
                expect(settingViewController
                    .hasLabel(withExactText: "目標体重"))
                    .to(beTrue())
            }

        }
    }
}

