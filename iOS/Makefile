unit-tests:
	@/usr/bin/time xcodebuild \
	-workspace "WeightScale.xcworkspace" \
	-scheme "WeightScale" \
	-destination "platform=iOS Simulator,name=iPhone 12,OS=latest" \
	build test

sort:
	@perl ./bin/sortXcodeProject "WeightScale.xcodeproj/project.pbxproj"

tests: sort unit-tests

third-party-tests:
	@/usr/bin/time xcodebuild \
	-workspace "WeightScale.xcworkspace" \
	-scheme "WeightScaleThirdPartyAPITests" \
	-destination "platform=iOS Simulator,name=iPhone 12,OS=latest" \
	build test


install:
	@pod install --repo-update

update:
	@pod update

xc:
	# @carthage update --platform ios --use-xcframeworks

ci:
	install unit-tests

beta:
	@/usr/bin/time fastlane beta
