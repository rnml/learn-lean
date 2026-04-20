inductive Dir where
  | L : Dir
  | R : Dir

def parseNum (chars : List Char) : Nat :=
  chars.foldl (fun acc c => acc * 10 + (c.toNat - '0'.toNat)) 0

def Input := List (Dir × Nat)

def loadInput : IO Input := do
  let content ← IO.FS.readFile "LearnLean/input.1"
  let content := content.trimAscii.toString
  let lines := content.splitOn "\n"
  return (
    List.map lines (f := fun line =>
      let chars := String.toList line
      match chars with
      | 'L' :: tail => (Dir.L, parseNum tail)
      | 'R' :: tail => (Dir.R, parseNum tail)
      | _ => (Dir.L, 0)))

partial def normalize (dial : Int) : Int :=
  if dial < 0 then normalize (dial + 100) else
  if dial >= 100 then normalize (dial - 100) else
  dial

def password (input : Input) : Int × Nat :=
  input.foldl (fun (dial,count) (dir, num) =>
  let dial :=
    match dir with
    | Dir.L => dial - Int.ofNat num
    | Dir.R => dial + Int.ofNat num
  let dial := normalize dial
  let count := if dial = 0 then count + 1 else count
  (dial, count)) (Int.ofNat 50, 0)

def main : IO Unit := do
  let input ← loadInput
  let (finalDial, count) := password input
  IO.println s!"Final dial: {finalDial}, Count: {count}"

#eval main
