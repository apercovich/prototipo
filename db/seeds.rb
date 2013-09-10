# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Creacion de roles de usuario
UserRole.create(name: "Administrador")
UserRole.create(name: "Editor")
UserRole.create(name: "Observador")

# Creacion de estados de usuario
UserState.create(name: "Registrado")
UserState.create(name: "Activo")
UserState.create(name: "Rechazado")
UserState.create(name: "Deshabilitado")
