LoadYellowTitleScreenGFX:
	ld hl, PokemonLogoGraphics
	ld de, vChars2
	ld bc, PokemonLogoGraphicsEnd - PokemonLogoGraphics
	ld a, BANK(PokemonLogoGraphics)
	call FarCopyData
	ld hl, PokemonLogoExtraGraphics
	ld de, vChars0 + 253 * $10
	ld bc, PokemonLogoExtraGraphicsEnd - PokemonLogoExtraGraphics
	ld a, BANK(PokemonLogoExtraGraphics)
	call FarCopyData
	ld hl, ClefairyLogoGraphics
	ld de, vChars1
	ld bc, ClefairyLogoGraphicsEnd - ClefairyLogoGraphics
	ld a, BANK(ClefairyLogoGraphics)
	call FarCopyData
	ld hl, TitlePikachuOBGraphics
	ld de, vChars1 tile $70
	ld bc, TitlePikachuOBGraphicsEnd - TitlePikachuOBGraphics
	ld a, BANK(TitlePikachuOBGraphics)
	call FarCopyData
	ret

TitleScreen_PlacePokemonLogo:
	hlcoord 2, 1
	ld de, TitleScreenPokemonLogoTilemap
	lb bc, 7, 16
	call Bank3D_CopyBox
	ret

TitleScreen_PlacePikaSpeechBubble:
	hlcoord 6, 4
	ld de, TitleScreenPikaBubbleTilemap
	lb bc, 4, 7
	call Bank3D_CopyBox
	hlcoord 9, 8
	ld [hl], $64
	inc hl
	ld [hl], $65
	ret

TitleScreen_PlacePikachu:
; place Clefairy in the screen with the tilemap
	hlcoord 3, 9
	ld de, TitleScreenPikachuTilemap
	lb bc, 8, 12
	call Bank3D_CopyBox

; place rightmost part of clefairy (not included in the tilemap for some reason)
	hlcoord 15, 13
	ld [hl], $ad
	hlcoord 15, 14
	ld [hl], $b6
	hlcoord 15, 15
	ld [hl], $bc
	hlcoord 15, 16
	ld [hl], $c1
	
; place clefairy's eyes where they belong
	ld hl, TitleScreenPikachuEyesOAMData
	ld de, wShadowOAM
	ld bc, $20
	call CopyData

; set clefairy's blush and mouth
	ld hl, TitleScreenClefairyBlushMouthOAMData
	ld de, wShadowOAM + $20
	ld bc, $18
	call CopyData
	ret

TitleScreenPikachuEyesOAMData:
; left eye
	db $74, $43, $f1, $22
	db $74, $4b, $f0, $22
	db $7c, $43, $f3, $22
	db $7c, $4b, $f2, $22

; right eye
	db $74, $5a, $f0, $02
	db $74, $62, $f1, $02
	db $7c, $5a, $f2, $02
	db $7c, $62, $f3, $02

TitleScreenClefairyBlushMouthOAMData:
; it might be a good idea to create a macro for oam attributes
; so X, Y, flags and tiles are easier to see and understand
; but for now these ugly maths will do
; they take the tile number and convert it to screen space coordinates
; so the blush and mouth with the correct color are in the correct place
; blush
	db $0e * 8 + 16, $07 * 8 + 8, $c2, $01
	db $0e * 8 + 16, $08 * 8 + 8, $c3, $01
	db $0e * 8 + 16, $0b * 8 + 8, $c4, $01
	db $0e * 8 + 16, $0c * 8 + 8, $c5, $01

; mouth
	db $0f * 8 + 16, $09 * 8 + 8, $c6, $01
	db $0f * 8 + 16, $0a * 8 + 8, $c7, $01


Bank3D_CopyBox:
; copy cxb (xy) screen area from de to hl
.row
	push bc
	push hl
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

TitleScreenPokemonLogoTilemap:
; 16x7 (xy)
	db $f5, $f5, $f5, $f5, $f5, $f5, $49, $f5, $72, $30, $f5, $f5, $f5, $f5, $f5, $f5
	db $fd, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $f5, $0d, $0e, $0f
	db $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f
	db $f5, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f
	db $f5, $41, $42, $43, $44, $45, $46, $47, $48, $f5, $4a, $4b, $4c, $4d, $4e, $4f
	db $f5, $6a, $6b, $6c, $6d, $f5, $f5, $f5, $f5, $f5, $f5, $6e, $6f, $70, $71, $f5

Pointer_f4669: ; unreferenced
	db $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $5f

TitleScreenPikaBubbleTilemap: ; 7x4
	INCBIN "gfx/title/pika_bubble.tilemap"

TitleScreenPikachuTilemap:
; 12x8 (xy)
	db $00, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a
	db $00, $8b, $8c, $8d, $8e, $8f, $90, $91, $92, $93, $94, $95
	db $00, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $a0
	db $00, $00, $a1, $a2, $9e, $a3, $a4, $a5, $a6, $9e, $a7, $00
	db $a8, $a9, $aa, $9a, $9e, $9e, $9e, $9e, $9e, $9e, $ab, $ac
	db $ae, $af, $9e, $9e, $b0, $b1, $b2, $b3, $b4, $b5, $9e, $9e
	db $96, $b7, $b8, $9e, $9e, $9e, $b9, $ba, $9e, $9e, $9e, $bb
	db $00, $00, $bd, $be, $9e, $9e, $9e, $9e, $9e, $9e, $bf, $c0

PokemonLogoGraphics: INCBIN "gfx/title/pokemon_logo.2bpp"
PokemonLogoGraphicsEnd:
PokemonLogoExtraGraphics:    INCBIN "gfx/title/extra_graphics.2bpp"
PokemonLogoExtraGraphicsEnd:
ClefairyLogoGraphics: INCBIN "gfx/title/clefairy.2bpp"
ClefairyLogoGraphicsEnd:
TitlePikachuOBGraphics: INCBIN "gfx/title/pikachu_ob.2bpp"
TitlePikachuOBGraphicsEnd:
