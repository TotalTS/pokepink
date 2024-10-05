MtMoonSquare_Object:
	db $2c ; border block

	def_warp_events
	warp_event 20,  5, MT_MOON_B1F, 10

	def_bg_events
	bg_event 17,  7, 7

	def_object_events
	object_event 14,  8, SPRITE_COOLTRAINER_F, WALK, UP_DOWN, 1
	object_event  5, 12, SPRITE_HIKER, STAY, LEFT, 2
	object_event  4, 12, SPRITE_MONSTER, STAY, DOWN, 3
	object_event  6,  6, SPRITE_CLEFAIRY, STAY, DOWN, 4
	object_event  7,  7, SPRITE_POKE_BALL, STAY, NONE, 5, MOON_STONE
	object_event 24,  7, SPRITE_POKE_BALL, STAY, NONE, 6, SUPER_POTION

	def_warps_to MT_MOON_SQUARE
