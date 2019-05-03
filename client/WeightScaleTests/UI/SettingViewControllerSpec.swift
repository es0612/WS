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

            it("通知のラベルが見える") {
                expect(settingViewController
                    .hasLabel(withExactText: "ON/OFF"))
                    .to(beTrue())
                expect(settingViewController
                    .hasLabel(withExactText: "通知時間"))
                    .to(beTrue())
            }

            xit("セクション名が見える") {
                expect(settingViewController
                    .hasLabel(withExactText: "設定"))
                    .to(beTrue())
                expect(settingViewController
                    .hasLabel(withExactText: "通知"))
                    .to(beTrue())
            }

            it("目標体重の数値が見える") {
                expect(settingViewController
                    .hasLabel(withExactText: "50.0"))
                    .to(beTrue())
            }
        }
    }
}

