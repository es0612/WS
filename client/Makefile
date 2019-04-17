unit-tests:
	@/usr/bin/time xcodebuild \
	-project "WeightScale.xcodeproj" \
	-scheme "WeightScale" \
	-destination "platform=iOS Simulator,name=iPhone XR,OS=latest" \
	build test

sort:
	@perl ./bin/sortXcodeProject "WeightScale.xcodeproj/project.pbxproj"

tests: sort unit-tests
