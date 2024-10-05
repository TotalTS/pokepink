YellowIntro_AnimatedObjectFramesData:
	dw Unkn_fa100
	dw Unkn_fa103
	dw Unkn_fa10a
	dw Unkn_fa111
	dw Unkn_fa118
	dw Unkn_fa11b
	dw Unkn_fa11e
	dw Unkn_fa121
	dw Unkn_fa124
	dw Unkn_fa127
	dw Unkn_fa138

Unkn_fa100:
	frame $00, 32
	endanim

Unkn_fa103: ;pikachu running 1
	frame $01, 9
	frame $02, 9
	frame $01, 9
	frame $02, 9, OAM_HFLIP
	dorestart

Unkn_fa10a: ;pikachu running 2
	frame $06, 9
	frame $04, 9
	frame $06, 9
	frame $04, 9, OAM_HFLIP
	dorestart

Unkn_fa111: ;pikachu running 3
	frame $07, 9
	frame $09, 9
	frame $07, 9
	frame $09, 9, OAM_HFLIP
	dorestart

Unkn_fa118:
	frame $0a, 32
	endanim

Unkn_fa11b:
	frame $0b, 32
	endanim

Unkn_fa11e:
	frame $0c, 32
	endanim

Unkn_fa121:
	frame $0d, 32
	endanim

Unkn_fa124:
	frame $0e, 32
	endanim

Unkn_fa127:
	frame $0f, 31
	frame $11, 2
	frame $0f, 2
	frame $11, 2
	frame $0f, 31
	frame $11, 2
	frame $0f, 23
	frame $10, 32
	endanim

Unkn_fa138:
	frame $12, 4
	frame $13, 4
	dorestart
