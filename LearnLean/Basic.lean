def hello := "world"

def helloWorld : IO Unit := do
  let content ← IO.FS.readFile "LearnLean/adjective.txt"
  let adj := content.trimAscii.toString
  IO.println s!"Hello Big {adj} World"

#eval helloWorld
