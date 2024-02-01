output "password" {
  value = [
  for i in random_password.password[*].result:
  nonsensitive(i)
]
}

