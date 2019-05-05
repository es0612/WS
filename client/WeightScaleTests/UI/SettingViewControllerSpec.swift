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

            it("目標体重を入力するtextFieldがあるが、画面上は見えない") {
                expect(settingViewController
                    .hasTextField(withExactPlaceholderText: "Target Weight"))
                    .to(beTrue())

                expect(settingViewController.findTextField(withExactPlaceholderText: "Target Weight")?.isHidden).to(beTrue())
            }

            it("目標体重をpickerで設定できる") {
                let textField = settingViewController
                    .findTextField(withExactPlaceholderText: "Target Weight")


                expect(textField?.inputView)
                    .to(beAKindOf(UIPickerView.self))
            }

            it("目標体重には１〜１００キロまで設定できる") {
                let pickerView = settingViewController
                    .findTextField(withExactPlaceholderText: "Target Weight")?
                    .inputView as! UIPickerView


                expect(pickerView.numberOfRows(inComponent: 0)).to(equal(991))
            }

            it("目標体重pickerに初期値を設定できる") {
                let pickerView = settingViewController
                    .findTextField(withExactPlaceholderText: "Target Weight")?
                    .inputView as! WeightPickerView


                expect(WeightPickerView.Constants
                    .pickerDataArray[pickerView.selectedRow])
                    .to(equal(50.0))
            }

            it("目標体重を更新できる") {
                let textField = settingViewController
                    .findTextField(withExactPlaceholderText: "Target Weight")
                let pickerView = textField?.inputView as! WeightPickerView


                settingViewController.tapCell(withExactText: "目標体重")
                pickerView.selectRowFor(weight: 48.0)
                textField?.inputAccessoryView?.findBarButtonItem(title: "OK")?.tap()


                expect(settingViewController.hasLabel(withExactText: "48.0")).to(beTrue())
            }
        }
    }
}

extension UIView {
    func findBarButtonItem(title searchTitle: String) -> UIBarButtonItem? {
        if let toolbar = self as? UIToolbar {
            for barButtonItem in toolbar.items ?? [] {
                if barButtonItem.title == searchTitle {
                    return barButtonItem
                }
            }
        }

        for subview in subviews {
            if let toolbar = subview as? UIToolbar {
                for barButtonItem in toolbar.items ?? [] {
                    if barButtonItem.title == searchTitle {
                        return barButtonItem
                    }
                }
            }

            if let barButtonItem = subview.findBarButtonItem(title: searchTitle) {
                return barButtonItem
            }
        }

        return nil
    }
}
