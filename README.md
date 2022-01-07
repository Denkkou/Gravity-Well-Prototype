# Gravity Well Prototype
 Mobile Shooter Game

 This is a messy prototype for the game project which will be a mobile-based infinite runner that uses touch-and-drag controls to steer and throttle a spaceship. The objective is to dodge gravity wells which will suck the player into them at increasing strength the closer the player gets to them.

 The prototype will be a proof of concept and any design decisions about features, mechanics, and game feel will be considered towards the end of prototyping. For now, it's just about getting the system up and running before all else.

 Post-prototype, I do plan to introduce skin resources for changing the look of the ship, its exhaust trails, the environment and so forth. This would introduce an Extras menu option. Additionally, I shall refactor the entire codebase to a professional standard.

 Then.... maybe release!

 Coded in GDscript on Godot v3.2.3

 Current tasks list:
 - Player:
	Vector-based movement	[X]
	Touch-drag controls	[X]
	Idle slowdown		[X]

 - Gravity Wells
	Well movement		[X]
	Spawn wells at interval [X]
	Despawn to waiting room	[ ]
	Spawn at random spawns  [ ]
	Collision with player	[ ]
	Distance-based pulling	[ ]

 - Game Systems
	Menu->Gameplay->End->	[ ]
	Hi-Score create & log	[ ]
	Core Main Menu features	[ ]
		Play	[ ]
		Score	[ ]
		Options	[ ]
		Exit	[ ]