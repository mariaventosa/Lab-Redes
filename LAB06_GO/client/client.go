package main

import("fmt"
		"strings"
		"github.com/chzyer/readline"
		"os"
)

func main() {
	l, err := readline.NewEx(&readline.Config{
							Prompt: ">> ",
							HistoryFile: "hist.tmp",
							AutoComplete: nil,
							InterruptPrompt: "^c",
							EOFPrompt: "exit",
							HistorySearchFold: false,
							FuncFilterInputRune: nil,

	})
	if err != nil {
		fmt.Println("error creando interfaz", err.Error())
		os.Exit(1)
	}
	defer l.Close()
	read := true
	for read {
		line, _ := l.Readline()
		line = strings.TrimSpace(line)
		fmt.Println("%[",line,"]")
		switch{
		case strings.HasPrefix(line, "exit"):
			fmt.Println("Bye")
			read = false
			break
		}
	}
}

