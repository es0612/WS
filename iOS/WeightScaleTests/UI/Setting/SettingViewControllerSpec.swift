import Nimble
import Quick
import Succinct

@testable import WeightScale

class SettingViewControllerSpec: QuickSpec {
    override func spec() {
        describe("setting view controller に関するテスト") {
            var settingViewController: SettingViewController!
            var stubTargetWeightRepository: StubTargetWeightRepository!
            var stubNotificationSender: StubNotificationSender!
            var stubNotificationSwitchStatusRepository: StubNotificationSwitchStatusRepository!
            var stubNotificationTimeRepository: StubNotificationTimeRepository!

            beforeEach {
                stubTargetWeightRepository
                    = StubTargetWeightRepository()
                stubNotificationSender = StubNotificationSender()
                stubNotificationSwitchStatusRepository
                    = StubNotificationSwitchStatusRepository()
                stubNotificationTimeRepository = StubNotificationTimeRepository()

                settingViewController
                    = SettingViewController(
                        targetWeightRepository:
                        stubTargetWeightRepository,
                        notificationSender:
                        stubNotificationSender,
                        notificationSwitchStatusRepository:
                        stubNotificationSwitchStatusRepository,
                        notificationTimeRepository: stubNotificationTimeRepository
                )
            }

            it("タイトルが見える") {
                expect(settingViewController.title)
                    .to(equal("設定"))
            }

            describe("個人設定について") {
                beforeEach {
                    stubTargetWeightRepository
                        .loadTargetWeight_returnValue = 50.0

                    settingViewController.viewWillAppear(false)
                }

                it("個人設定のラベルが見える") {
                    expect(settingViewController
                        .hasLabel(withExactText: "個人設定"))
                        .to(beTrue())

                }
                it("目標体重のラベルが見える") {
                    expect(settingViewController
                        .hasButton(withExactText: "目標体重"))
                        .to(beTrue())
                }

                it("目標体重の数値が見える") {
                    expect(settingViewController
                        .hasLabel(withExactText: "50.0 kg"))
                        .to(beTrue())
                }

                describe("picker周りのテスト") {
                    var textField: UITextField!
                    var pickerView: WeightPickerView!

                    beforeEach {
                        textField = settingViewController
                            .findTextField(withExactPlaceholderText: "Target Weight")
                        pickerView = textField?.inputView as? WeightPickerView
                    }

                    it("目標体重を入力するtextFieldがあるが、画面上は見えない") {
                        expect(settingViewController
                            .hasTextField(withExactPlaceholderText: "Target Weight"))
                            .to(beTrue())

                        expect(textField.isHidden).to(beTrue())
                    }

                    it("目標体重をpickerで設定できる") {
                        expect(textField?.inputView)
                            .to(beAKindOf(UIPickerView.self))
                    }

                    it("目標体重には１〜１００キロまで設定できる") {
                        expect(pickerView.numberOfRows(inComponent: 0)).to(equal(991))
                    }

                    it("目標体重pickerに初期値を設定できる") {
                        expect(WeightPickerView.Constants
                            .pickerDataArray[pickerView.selectedRow])
                            .to(equal(50.0))
                    }

                    it("目標体重を更新できる") {
                        settingViewController.tapButton(withExactText: "目標体重")

                        stubTargetWeightRepository
                            .loadTargetWeight_returnValue = 48.0

//                        textField?.inputAccessoryView?.findBarButtonItem(title: "OK")?.tap()
                        textField?.inputAccessoryView?.findBarButtonItem(title: "OK")?.tapAndFireTargetAction()

                        expect(settingViewController.hasLabel(withExactText: "48.0 kg"))
                            .to(beTrue())
                    }

                    it("目標体重を保存できる") {
                        settingViewController.tapButton(withExactText: "目標体重")
                        pickerView.selectRowFor(weight: 48.0)
//                        textField?.inputAccessoryView?.findBarButtonItem(title: "OK")?.tap()
                        textField?.inputAccessoryView?.findBarButtonItem(title: "OK")?.tapAndFireTargetAction()

                        expect(stubTargetWeightRepository.saveTargetWeight_argutment_weight)
                            .to(equal(48.0))
                    }
                }
            }

            describe("個人設定が未設定の場合") {
                beforeEach {
                    stubTargetWeightRepository
                        .loadTargetWeight_returnValue = 0.0

                    settingViewController.viewWillAppear(false)
                }

                it("ピッカーにデフォルト初期値が見える") {
                    let textField = settingViewController
                        .findTextField(withExactPlaceholderText: "Target Weight")
                    let pickerView = textField?.inputView as? WeightPickerView


                    expect(WeightPickerView.Constants
                        .pickerDataArray[pickerView!.selectedRow])
                        .to(equal(50.0))
                }
            }

            describe("通知について") {
                var notificationSwitch: UISwitch!

                beforeEach {
                    stubNotificationSwitchStatusRepository
                        .loadData_returnValue = false

                    stubNotificationSender.getSettings_returnValue = .unknown

                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat =  "HH:mm"
                    let setDate = dateFormatter.date(from: "17:30")
                    stubNotificationTimeRepository.loadTime_returnValue = setDate!

                    settingViewController.viewWillAppear(false)

                    notificationSwitch = settingViewController.findSwitch(colocatedWithUILabelWithExactText: "通知OFF")
                }

                it("通知のラベルが見える") {
                    expect(settingViewController
                        .hasLabel(withExactText: "通知"))
                        .to(beTrue())
                }

                it("通知ON/OFFのラベルが見える") {
                    expect(settingViewController
                        .hasLabel(withExactText: "通知OFF"))
                        .to(beTrue())
                }

                it("通知ON/OFFスイッチが見える") {
                    expect(notificationSwitch).notTo(beNil())
                }

                it("通知許可設定を取得する") {
                    expect(stubNotificationSender.getStettings_wasCalled)
                        .to(beTrue())

                }

                xit("通知設定が未知の場合、注意文が見える") {
                    expect(settingViewController.hasLabel(withExactText: "通知を受け取るにはOSの通知設定をONにしてください")).to(beTrue())
                }

                it("保存された通知の状態が見える") {
                    expect(stubNotificationSwitchStatusRepository.loadData_wasCalled)
                        .to(beTrue())
                    expect(notificationSwitch.isOff).to(beTrue())
                }

                describe("通知スイッチを押した場合") {
                    describe("OFF -> ON") {
                        context("通知が許可された場合") {
                            beforeEach {
                                stubNotificationSender.getSettings_returnValue = .authorized
                                settingViewController
                                    .tapSwitch(
                                        colocatedWithUILabelWithExactText: "通知OFF"
                                )
                            }

                            it("スイッチがONに切り替わる") {
                                expect(notificationSwitch.isOn).to(beTrue())
                            }

                            it("権限を設定できる") {
                                expect(stubNotificationSender.grant_wasCalled)
                                    .to(beTrue())
                            }

                            it("権限設定を確認できる") {
                                expect(stubNotificationSender.getStettings_wasCalled)
                                    .to(beTrue())
                            }

                            it("ラベルがONに切り替わる") {
                                expect(settingViewController.hasLabel(withExactText: "通知ON"))
                                    .to(beTrue())
                            }

                            it("スイッチの状態を保存できる") {
                                expect(stubNotificationSwitchStatusRepository.saveData_argument_value).to(beTrue())
                            }

                            it("通知を送るようにする") {
                                expect(stubNotificationSender.sendNotification_wasCalled).to(beTrue())
                            }

                            it("指定した時間に通知を送るようにする") {
                                expect(stubNotificationSender.sendNotification_argument_time)
                                    .to(equal(DateManager.convertStringToTime(string: "17:30")))
                            }

                            describe("ON -> OFF") {
                                beforeEach {
                                    settingViewController
                                        .tapSwitch(
                                            colocatedWithUILabelWithExactText: "通知ON"
                                    )
                                }
                                it("ラベルがOFFに切り替わる") {
                                    expect(settingViewController
                                        .hasLabel(withExactText: "通知OFF"))
                                        .to(beTrue())
                                }

                                it("スイッチの状態を再度保存できる") {
                                    expect(stubNotificationSwitchStatusRepository.saveData_CalledCount).to(equal(2))
                                }

                                it("通知を送らないようにする") {
                                    expect(stubNotificationSender.stopNotification_wasCalled).to(beTrue())
                                }
                            }
                        }

                        context("通知が拒否された場合") {
                            beforeEach {
                                stubNotificationSender.getSettings_returnValue = .denied
                                settingViewController
                                    .tapSwitch(
                                        colocatedWithUILabelWithExactText: "通知OFF"
                                )
                            }

                            it("ラベルがOFFのまま") {
                                expect(settingViewController.hasLabel(withExactText: "通知OFF"))
                                    .to(beTrue())
                                expect(notificationSwitch.isOn).to(beFalse())
                            }

                            it("ラベルが切り替えられなくなる") {
                                expect(notificationSwitch.isEnabled).to(beFalse())
                            }
                        }
                    }
                }

                it("通知時間のラベル（ボタン）が見える") {
                    expect(settingViewController
                        .hasButton(withExactText: "通知時間")).to(beTrue())
                }

                it("通知時間の時刻が見える") {
                    expect(settingViewController.hasLabel(withExactText: "17:30")).to(beTrue())
                }

                describe("通知時間のpicker") {
                    var textField: UITextField!
                    var pickerView: UIDatePicker!

                    beforeEach {
                        textField = settingViewController
                            .findTextField(withExactPlaceholderText: "Notification Time")
                        pickerView = textField?.inputView as? UIDatePicker
                    }

                    it("通知時間を入力するtextFieldがあるが、画面上は見えない") {
                        expect(settingViewController
                            .hasTextField(withExactPlaceholderText: "Notification Time"))
                            .to(beTrue())

                        expect(textField.isHidden).to(beTrue())
                    }

                    it("通知時間をpickerで設定できる") {
                        expect(textField?.inputView)
                            .to(beAKindOf(UIDatePicker.self))
                    }

                    it("通知時間は時間で設定できる") {
                        expect(pickerView.datePickerMode).to(equal(.time))
                    }

                    it("pickerにツールバーが見える") {
                        expect(textField?.inputAccessoryView)
                            .to(beAKindOf(UIToolbar.self))
                    }

                    describe("保存した通知時間を読み込む") {
                        it("保存した値を取得できる") {
                            expect(stubNotificationTimeRepository.loadTime_wasCalled).to(beTrue())
                        }

                        it("pickerに初期値として保存された値17:30が見える") {
                            let dateformatter = DateFormatter()
                            dateformatter.dateFormat = "HH:mm"
                            let dateString = dateformatter
                                .string(from: pickerView.date)


                            expect(dateString).to(equal("17:30"))
                        }
                    }


                    describe("OKボタンを押した時") {
                        beforeEach {
                            settingViewController
                                .tapSwitch(
                                    colocatedWithUILabelWithExactText: "通知OFF"
                            )

                            settingViewController
                                .tapButton(withExactText: "通知時間")

                            pickerView.date = DateManager
                                .convertStringToTime(string: "17:30")


                            textField?.inputAccessoryView?
//                                .findBarButtonItem(title: "OK")?.tap()
                                .findBarButtonItem(title: "OK")?.tapAndFireTargetAction()
                        }

                        it("通知時間ラベルを更新できる") {
                            expect(settingViewController
                                .hasLabel(withExactText: "17:30")).to(beTrue())
                        }

                        it("通知時間を保存できる") {
                            expect(stubNotificationTimeRepository.saveTime_argument_time)
                                .to(equal(pickerView.date))
                        }

                        it("通知をセットする") {
                            expect(stubNotificationSender.sendNotification_wasCalled)
                                .to(beTrue())
                        }

                        xit("pickerが閉じる") {
                            expect(textField.isFirstResponder).to(beFalse())
                        }
                    }
                }
            }

            describe("通知許可設定になっている場合") {
                beforeEach {
                    stubNotificationSender.getSettings_returnValue = .authorized

                    settingViewController.viewWillAppear(false)
                }
                it("注意文が見えない") {
                    expect(settingViewController.hasLabel(withExactText: "通知を受け取るにはOSの通知設定をONにしてください")).to(beFalse())
                }

            }

            describe("通知時間が保存されていない場合") {
                beforeEach {
                    stubNotificationTimeRepository.loadTime_returnValue = nil

                    settingViewController.viewWillAppear(false)
                }
                it("pickerにdefault初期値として17:00が見える") {
                    let textField = settingViewController
                        .findTextField(
                            withExactPlaceholderText: "Notification Time"
                    )
                    let pickerView = textField?.inputView as? UIDatePicker

                    let dateString = DateManager
                        .convertTimeToString(time: pickerView!.date)

                    expect(dateString).to(equal("17:00"))
                }

            }
        }
    }
}
