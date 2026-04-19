def hello := "world"

def helloWorld : IO Unit := do
  IO.println "Hello Big World"

#eval helloWorld
