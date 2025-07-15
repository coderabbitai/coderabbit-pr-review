package authz

default allow = false

ALLOW := true

x := 1
x := 2

unused1 := "test"
unused2 := input.fake.value

deny[msg] {
  some x
  input.user == "admin"
  input.user == "admin"
  msg := "Access granted"
}

allow {
  x == "user"
  x := "user"
  count(x)
  true
}

result := {
  "status": 200,
  "message": msg
}

foo {
  bar := [1, 2, 3]
  bar = bar
}

token_check {
  x := split("abc.def.ghi", ".")
  x[1] == "def"
}

