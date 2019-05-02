import Nimble
import Quick
import Succinct

@testable import WeightScale

class SettingViewControllerSpec: QuickSpec {
    override func spec() {
        describe("setting view controller に関するテスト") {
            var settingViewController: SettingViewController!

            beforeEach {
                settingViewController = SettingViewController()
            }

            it("タイトルが見える") {
                expect(settingViewController.title)
                    .to(equal("設定"))
            }

            it("目標体重のラベルが見える") {
                expect(settingViewController
                    .hasLabel(withExactText: "目標体重"))
                    .to(beTrue())
            }
        }
    }
}

