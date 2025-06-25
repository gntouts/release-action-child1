package main

import (
	_ "embed"
	"fmt"
	"log"
	"os"
	"strings"

	"codeberg.org/msantos/embedexe/exec"
)

//go:embed bin
var bin []byte

var version string

func main() {
	args := os.Args[1:]
	if len(args) == 1 && args[0] == "--version" {
		versionString := fmt.Sprintf("capicalecho %s built with", version)
		fmt.Println(versionString)
		args = []string{"--version"}
	} else {
		newArgs := make([]string, 0, len(args))
		for _, arg := range args {
			temp := strings.ToUpper(arg)
			newArgs = append(newArgs, temp)
		}
		args = newArgs
	}

	cmd := exec.Command(bin, args...)

	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err := cmd.Run(); err != nil {
		log.Fatalln("run:", cmd, err)
	}
}
