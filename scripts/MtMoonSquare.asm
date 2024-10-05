MtMoonSquare_Script:
	call EnableAutoTextBoxDrawing
	ld hl, MtMoonSquare_ScriptPointers
	ld a, [wMtMoonSquareCurScript]
	jp CallFunctionInTable

MtMoonSquare_ScriptPointers:
	dw MtMoonSquareDefaultScript ;$1
	dw MtMoonSquareClefairyDanceScript ;$2
	dw ClefairyMovementScript ;$3
	dw MtMoonSquareScript1 ;$4
	
MtMoonSquareDefaultScript:
	xor a ; SCRIPT_MTMOONSQUARE_DEFAULT
	ld [wJoyIgnore], a
	ld [wMtMoonSquareCurScript], a
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	call Random
	cp 25 ; prob_spawning = (n+1)/256
	ret nc
	ResetEvent EVENT_CLEFAIRY_DANCE
	ld a, $1 ;MtMoonSquareClefairyDanceScript
    ld [wMtMoonSquareCurScript], a
	ret

MtMoonSquareClefairyDanceScript:
	CheckEvent EVENT_CLEFAIRY_DANCE
    ret nz
	ld hl, .MtMoonSquareCoords
	call ArePlayerCoordsInArray
	ret nc
	call StopAllMusic
	ld c, BANK(Music_YellowUnusedSong)
	ld a, MUSIC_YELLOW_UNUSED_SONG
	call PlayMusic
	xor a
	ldh [hJoyHeld], a
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, HS_MT_MOON_SQUARE_CLEFAIRY
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, $f ;Clefairy Starter
	ld [wEmotionBubbleSpriteIndex], a
	xor a ; EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, $4
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirection
	ld a, CLEFAIRY
	call PlayCry
	ld a, HS_MT_MOON_SQUARE_ITEM_1 ; show Moon Stone
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld c, 15
	call DelayFrames
	call ClefairyMovementScript
	ret

.MtMoonSquareCoords:
	dbmapcoord 7, 10
	db -1 ; end

ClefairyMovementScript:
	ld de, MovementData_Clefairy
	ld a, $4
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, $3 ;MtMoonSquareScript1
    ld [wMtMoonSquareCurScript], a
	ret

MovementData_Clefairy:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db -1

MtMoonSquareScript1:
	ld a, [wd730]
	bit 0, a
	ret nz
	SetEvent EVENT_CLEFAIRY_DANCE
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, $4
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirection
	ld a, $4 ;Clefairy Starter
	ld [wEmotionBubbleSpriteIndex], a
	xor a ; EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, CLEFAIRY
	call PlayCry
	call GBFadeOutToWhite
	ld a, HS_MT_MOON_SQUARE_CLEFAIRY ; hide Clefairy NPC
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	call Delay3
	call GBFadeInFromWhite
	call PlayDefaultMusic
	jp MtMoonSquareDefaultScript

MtMoonSquare_TextPointers:
	dw MtMoonSquareCooltrainerFText
	dw MtMoonSquareHikerText
	dw MtMoonSquareGolemText
	dw MtMoonSquareClefairyText
	dw PickUpItemText
	dw PickUpItemText
	dw MtMoonSquareSignText

MtMoonSquareCooltrainerFText:
	text_far _MtMoonSquareCooltrainerFText
	text_end
	
MtMoonSquareClefairyText:
	text_far _MtMoonSquareClefairyText
	text_end

MtMoonSquareHikerText:
	text_far _MtMoonSquareHikerText
	text_end

MtMoonSquareGolemText:
	text_far _MtMoonSquareGolemText
	text_asm
	ld a, GOLEM
	call PlayCry
	jp TextScriptEnd

MtMoonSquareSignText:
	text_far _MtMoonSquareSignText
	text_end
