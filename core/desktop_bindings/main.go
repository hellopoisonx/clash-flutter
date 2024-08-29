package main

import "C"

import (
	"fmt"
	"os/exec"

	"github.com/metacubex/mihomo/component/updater"
	Constant "github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/hub/executor"
	"github.com/metacubex/mihomo/hub/route"

	"go.uber.org/automaxprocs/maxprocs"
)

func init() {
	_, _ = maxprocs.Set(maxprocs.Logger(func(string, ...any) {}))
}

//export SetHomeDir
func SetHomeDir(path *C.char) {
	Constant.SetHomeDir(C.GoString(path))
}

//export SetConfig
func SetConfig(path *C.char) {
	Constant.SetConfig(C.GoString(path))
}

//export TestConfig
func TestConfig(path *C.char) *C.char {
	if _, err := executor.ParseWithPath(C.GoString(path)); err != nil {
		return C.CString(fmt.Sprintf("Failed to test configuration: %s", err.Error()))
	}
	return C.CString("")
}

//export UpdateGeoDatabases
func UpdateGeoDatabases() *C.char {
	if err := updater.UpdateGeoDatabases(); err != nil {
		return C.CString(fmt.Sprintf("[Geo] Failed to updating GeoDatabases: %s", err.Error()))
	}
	return C.CString("")
}

//export StartExternalController
func StartExternalController(addr *C.char) {
	go route.Start(C.GoString(addr), "", "", "", "", "", false)
}

//export StartCore
func StartCore() *C.char {
	cmd := exec.Command("pkexec")
	cmd.Run()
	cfg, err := executor.Parse()
	if err != nil {
		return C.CString(fmt.Sprintf("[Core] Failed to starting core: %s", err.Error()))
	}
	executor.ApplyConfig(cfg, true)
	return C.CString("")
}

//export StopCore
func StopCore() {
	executor.Shutdown()
}

func main() {}
