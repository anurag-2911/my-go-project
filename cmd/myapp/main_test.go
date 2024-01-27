package main

import
(
	"testing"
)
func TestXxx(t *testing.T) {
	str:="hello"
	if str!="hello"{
		t.Errorf("not matching")
	}
}