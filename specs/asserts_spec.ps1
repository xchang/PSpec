Spec "should not be equal for two different strings" {
	AssertNotEquals "Hello" "World"
}

Spec "should be equal for same strings" {
	AssertEquals "Hello World!" "Hello World!"
}

Spec "should be equal for same strings" {
	AssertEquals "Hello World!" "Hello World!"
}

Spec "should be equal for two integers" {
	AssertEquals 12345 12345
}

Spec "should not be equal for two different integers" {
	AssertNotEquals 12345 54321
}