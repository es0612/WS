unit-tests:
	@/usr/bin/time xcodebuild \
	-project "WeightScale.xcodeproj" \
	-scheme "WeightScale" \
	-destination "platform=iOS Simulator,name=iPhone 12,OS=latest" \
	build test

sort:
	@perl ./bin/sortXcodeProject "WeightScale.xcodeproj/project.pbxproj"

tests: sort unit-tests

third-party-tests:
	@/usr/bin/time xcodebuild \
	-project "WeightScale.xcodeproj" \
	-scheme "WeightScaleThirdPartyAPITests" \
	-destination "platform=iOS Simulator,name=iPhone 12,OS=latest" \
	build test


bootstrap:
	@carthage bootstrap --platform iOS --no-use-binaries --cache-builds

update:
	@carthage update --platform iOS --no-use-binaries --cache-builds

xc:
	@carthage update --platform ios --use-xcframeworks

ci:
	bootstrap unit-tests

beta:
	@/usr/bin/time fastlane beta
