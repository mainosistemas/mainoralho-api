user = User.create(email: "maino@maino.com.br", password: "12345678", name: "Maino")

projects = Project.create([{ name: "woody", owner_id: user.id }, { name: "buzz", owner_id: user.id }])

sprints = Sprint.create([
	{ name: "faster", owner_id: user.id, project_id: projects.first.id },
	{ name: "fast", owner_id: user.id, project_id: projects.second.id },
	{ name: "stronger", owner_id: user.id, project_id: projects.first.id },
])
