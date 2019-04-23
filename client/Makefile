unit-tests:
	@/usr/bin/time xcodebuild \
	-project "WeightScale.xcodeproj" \
	-scheme "WeightScale" \
	-destination "platform=iOS Simulator,name=iPhone Xʀ,OS=latest" \
	build test

sort:
	@perl ./bin/sortXcodeProject "WeightScale.xcodeproj/project.pbxproj"

tests: sort unit-tests

bootstrap:
	@carthage bootstrap --platform iOS --no-use-binaries --cache-builds

update:
	@carthage update --platform iOS --no-use-binaries --cache-builds

ci:
	bootstrap unit-tests

beta:
	@/usr/bin/time fastlane beta
