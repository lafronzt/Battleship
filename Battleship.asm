INCLUDE Irvine32.inc
INCLUDELIB winmm.lib
;INCLUDELIB winmm.dll
includelib user32.lib 
includelib kernel32.lib 
includelib gdi32.lib  
include macros.inc

;-------------------------------------------------------- Data Segment ---------------------------------------------------------------------

.data
arrayTop db ' ','1','2','3','4','5','6','7','8','9','10',0,0d,0h
arrayA db 'A','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayB db 'B','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayC db 'C','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayD db 'D','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayE db 'E','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayF db 'F','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayG db 'G','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayH db 'H','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayI db 'I','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayJ db 'J','-','-','-','-','-','-','-','-','-','-',0,0d,0h

arrayADisp db 'A','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayBDisp db 'B','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayCDisp db 'C','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayDDisp db 'D','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayEDisp db 'E','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayFDisp db 'F','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayGDisp db 'G','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayHDisp db 'H','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayIDisp db 'I','-','-','-','-','-','-','-','-','-','-',0,0d,0h
arrayJDisp db 'J','-','-','-','-','-','-','-','-','-','-',0,0d,0h

restcolor dd Black(lightGray*16)

randVal db ?
randValint dword ?
shipSize dword ?

hitCounter db 0
hitStreak db 1
var1 dd ?

replayEntered dd ?

UserROW db ?
UserCol db ?
UserInRow db "Please enter a letter: ",0
UserInCol db "Please Enter a number: ",0
AlreadyTargeted db "You already Targeted that location, try again.",0
FiringMessage db "Launching Missles NOW!",0
ErrorMes db "There seems to be an error. Please retry entering that location.",0
ErrorCol db "That column number seems to be out of bounds, try again.",0

score db 100
 
ship1 db "                            ?",10,13,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~|^~~~~~~~~~~~~~~~~~~~~~~~~~o~~~~~~~~~~~",10,13,"        o                   |                  o      __o",10,13,"         o                  |                 o     |X__>",10,13,"       ___o                 |                __o",10,13,"     (X___>--               |_____         |X__>     o",10,13,"                            |     \                   __o",10,13,"                            |      \                |X__>",10,13,0
ship2 db "   _________________________|_______\______________",10,13," <                                                \____________   _",10,13,"  \                                                            \ (_)",10,13,"   \    O       O       O                                       >=)",10,13,"    \__________________________________________________________/ (_)",10,13,10,13,0
ship15 db "                            ___",10,13,"                           / o \",10,13,"                      __   \   /   _",10,13,"                       \__/ | \__/ \",10,13,"                       \___//|\\___/\",10,13,"                        ___/ | \___",10,13, "                             |     \",10,13,"                             /",10,13,0

message1 db "Welcome to Battleship",0
message2 db "Created by: Colby Daly, Nic Bozanni, Tyler La Fronz",0 
message3 db "PRESS 1 FOR RULES: ",0
message4 db "PRESS 2 TO PLAY BATTLESHIP!: ",0
message5 db "ERROR: UNRECOGNIZED INPUT, TRY AGAIN: ",0
message6 db "Battleship at top as header in ascii art ",0
message7 db "BATTLESHIP RULES: ",0
rulesmes1 db "When the game starts, 5 battleships of different lengths are randomly placed horizontally or vertically on the board.",0
rulesmes2 db "The sizes of ships are as follows: ",0
rulesmes3 db "1 aircraft carrier of length 5 ",0
rulesmes4 db "1 battleship of length 4",0
rulesmes5 db "2 submarines of length 3",0
rulesmes6 db "1 patrol boat of length 2",0
rulesmes7 db "The board has 10 Rows (A-J) and 10 Columns (1-10) ",0
rulesmes8 db "The goal of the game is to sink all ships with as few misses as possible.",0
rulesmes9 db "To fire at a location, First enter the row (A-J), then enter the column (1-10) and press ENTER",0
rulesmes10 db "A '-' is an unkown space, an 'O' symbolizes a miss, and a 'X' denotes a hit ",0
rulesmes11 db "Press 1 to return to the homescreen",0

replaymes db "Do you want to play again? Enter Y for Yes or N for No: ",0
invalidReplay db "That's not a valid input. Enter Y for Yes or N for No: ",0

messageEnd db "You sunk all the battleships! Congratulations!",0
messageScore db "Your score is: ",0,0d,0h

topGun db ".\Top_Gun_Quote.WAV",0
Churchill db ".\Winston_Churchill_Quote.WAV",0
Torpedo db ".\torpedo.WAV",0

NULL equ 0
SND_ASYNC equ 1h
SND_FILENAME equ 20000h

PlaySound PROTO STDCALL :dword, :dword, :dword
ExitProcess PROTO STDCALL :DWORD

;-------------------------------------------------------- Code Segment ---------------------------------------------------------------------

.code
main PROC
Call homescreen
exit
main endp

;---------------------------------------------------------Home Screen -----------------------------------------------------------------------

HomeScreen PROC
mov eax,restcolor
call settextcolor
call clrscr
mov edx, offset ship1
call writestring
mov edx, offset ship2
call writestring
mov edx, offset ship15
call writestring
call crlf
mov edx, offset message1
call writestring
call crlf
mov edx, offset message2
call writestring
call crlf
mov edx, offset message3
call writestring
call crlf
mov edx, offset message4
call writestring
call crlf
oops:
Call readint
cmp eax, 1
je rulesproc
cmp eax, 2
je playgame
mov edx, offset message5
call writestring
call crlf
jmp oops

rulesproc:
Call rules
jmp bye

playgame:
call Driver
jmp bye

bye:
ret
HomeScreen ENDP

;---------------------------------------------------------Main Driver -----------------------------------------------------------------------

Driver proc
mov eax,restcolor
call settextcolor
Call Randomize
Call WriteBoard
Call LoopShips
;Call WriteBoard
mov ecx, 200
call clrscr
Call CheckHitCounter
Call WriteBoardv2
invoke PlaySound, OFFSET topgun, NULL, SND_FILENAME or SND_ASYNC	
Call UserInput
invoke PlaySound, OFFSET torpedo, NULL, SND_FILENAME or SND_ASYNC
David:
	call clrscr
	;Call WriteBoard
	Call CheckHitCounter
	Call WriteBoardv2
	Call UserInput
	invoke PlaySound, OFFSET torpedo, NULL, SND_FILENAME or SND_ASYNC
Loop David
ret
Driver endp

;--------------------------------------------------------Rules ----------------------------------------------------------------------------

Rules PROC
call clrscr
; battleship ascii art here again
;mov edx, offset message6
;call writestring
mov edx, offset ship1
call writestring
mov edx, offset ship2
call writestring
mov edx, offset ship15
call writestring
call crlf
call crlf
mov edx, offset message7
call writestring
call crlf
mov edx, offset rulesmes1
call writestring
call crlf
mov edx, offset rulesmes7
call writestring
call crlf
mov edx, offset rulesmes8
call writestring
call crlf
mov edx, offset rulesmes2
call writestring
call crlf
mov edx, offset rulesmes3
call writestring
call crlf
mov edx, offset rulesmes4
call writestring
call crlf
mov edx, offset rulesmes5
call writestring
call crlf
mov edx, offset rulesmes6
call writestring
call crlf
mov edx, offset rulesmes9
call writestring
call crlf
mov esi, offset rulesmes10
mov ecx, sizeof rulesmes10
call writestring2
call crlf
call crlf
call crlf
mov edx, offset rulesmes11
call writestring
call crlf
mov edx, offset message4
call writestring
call crlf
helper:
call readint
cmp eax, 1
je home
cmp eax, 2
je playme
mov edx, offset message5
call writestring
jmp helper

home:
call homescreen
jmp cya

playme:
call driver
jmp cya

cya:

ret
Rules ENDP

;-------------------------------------------------------- User Input ---------------------------------------------------------------------

UserInput Proc USES EAX EBX ECX EDX ;ESI EDI
jmp StartInput

StartInput:
mov edx, offset messageScore
Call WriteString
mov al, score
Call WriteDec
Call CRLF
Call CRLF

Retry1:
mov edx, offset UserInROW
Call WriteString
Call CRLF
Call ReadChar
Call WriteChar
mov UserRow,AL
Call CRLF
jmp Col
RetryCol:
mov edx, offset ErrorMes
Call writestring
Call Crlf
mov edx, offset ErrorCol
call writestring
call crlf
col:
mov edx, offset UserInCol
Call WriteString
Call CRlF
Call ReadInt
cmp al,1
jl RetryCol
cmp al,10
jg RetryCol
mov UserCol,al

mov eax,0
mov al,UserRow
cmp al,'A'
je TargetA
cmp al,'a'
je TargetA
cmp al,'B'
je TargetB
cmp al,'b'
je TargetB
cmp al,'C'
je TargetC
cmp al,'c'
je TargetC
cmp al,'D'
je TargetD
cmp al,'d'
je TargetD
cmp al,'E'
je TargetE
cmp al,'e'
je TargetE
cmp al,'F'
je TargetF
cmp al,'f'
je TargetF
cmp al,'G'
je TargetG
cmp al,'g'
je Targetg
cmp al,'H'
je TargetH
cmp al,'h'
je TargetH
cmp al,'I'
je TargetI
cmp al,'i'
je TargetI
cmp al,'J'
je TargetJ
cmp al,'j'
je TargetJ
mov edx, offset ErrorMes
Call writestring
Call Crlf
jmp Retry1

TargetA:
	mov eax,0
	mov al,UserCol
	mov esi,0
	mov esi, offset ArrayA
	mov edi, offset arrayADisp
	add esi,eax
	add edi,eax
	mov al,[esi]
	mov ah,[edi]
	cmp al,'X'
	je HitA
	jne Test1A
	HitA:
	mov al,'H'
	mov ah,'X'
	xchg [esi],al
	xchg [edi],al
	inc hitCounter
	mov bl, score
	mov bh, hitStreak
	inc bh
	add bl, bh
	mov hitStreak, bh
	mov score, bl
	jmp done
	Test1A:
	cmp al,'H'
	je Test2A
	cmp al,'M'
	je Test2A
	cmp al,'-'
	jmp MissA
	JMP done
	Test2A:
	mov edx, offset AlreadyTargeted
	Call WriteString
	Call Crlf
	Jmp Retry1
	MissA:
	mov al,'M'
	mov ah, 'O'
	xchg [esi],al
	xchg [edi],ah
	mov bl, score
	mov hitStreak, 0
	sub bl, 2
	mov score, bl
	jmp done

TargetB:
	mov eax,0
	mov al,UserCol
	mov esi,0
	mov esi, offset ArrayB
	mov edi, offset ArrayBDisp
	add esi,eax
	add edi,eax
	mov al,[esi]
	mov ah,[edi]
	cmp al,'X'
	je HitB
	jne Test1B
	HitB:
	mov al,'H'
	mov ah,'X'
	xchg [esi],al
	xchg [edi],ah
	inc hitCounter
	mov bl, score
	mov bh, hitStreak
	inc bh
	add bl, bh
	mov hitStreak, bh
	mov score, bl
	jmp done
	Test1B:
	cmp al,'H'
	je Test2B
	cmp al,'M'
	je Test2B
	cmp al,'-'
	jmp MissB
	JMP done
	Test2B:
	mov edx, offset AlreadyTargeted
	Call WriteString
	Call Crlf
	Jmp Retry1
	MissB:
	mov al,'M'
	mov ah,'O'
	xchg [esi],al
	xchg [edi],ah
	mov bl, score
	mov hitStreak, 0
	sub bl, 2
	mov score, bl
	jmp done

TargetC:
	mov eax,0
	mov al,UserCol
	mov esi,0
	mov edi, 0
	mov esi, offset ArrayC
	mov edi, offset ArrayCDisp
	add esi,eax
	add edi,eax
	mov al,[esi]
	mov ah,[edi]
	cmp al,'X'
	je HitC
	jne Test1C
	HitC:
	mov al,'H'
	mov ah,'X'
	xchg [esi],al
	xchg [edi],ah
	inc hitCounter
	mov bl, score
	mov bh, hitStreak
	inc bh
	add bl, bh
	mov hitStreak, bh
	mov score, bl
	jmp done
	Test1C:
	cmp al,'H'
	je Test2C
	cmp al,'M'
	je Test2C
	cmp al,'-'
	jmp MissC
	JMP done
	Test2C:
	mov edx, offset AlreadyTargeted
	Call WriteString
	Call Crlf
	Jmp Retry1
	MissC:
	mov al,'M'
	mov ah,'O'
	xchg [edi],ah
	xchg [esi],al
	mov bl, score
	mov hitStreak, 0
	sub bl, 2
	mov score, bl
	jmp done

TargetD:
	mov eax,0
	mov al,UserCol
	mov esi,0
	mov esi, offset ArrayD
	mov edi, offset ArrayDDisp
	add esi,eax
	add edi,eax
	mov al,[esi]
	mov ah,[edi]
	cmp al,'X'
	je HitD
	jne Test1D
	HitD:
	mov al,'H'
	mov ah,'X'
	xchg [edi],ah
	xchg [esi],al
	inc hitCounter
	mov bl, score
	mov bh, hitStreak
	inc bh
	add bl, bh
	mov hitStreak, bh
	mov score, bl
	jmp done
	Test1D:
	cmp al,'H'
	je Test2D
	cmp al,'M'
	je Test2D
	cmp al,'-'
	jmp MissD
	JMP done
	Test2D:
	mov edx, offset AlreadyTargeted
	Call WriteString
	Call Crlf
	Jmp Retry1
	MissD:
	mov al,'M'
	mov ah,'O'
	xchg [edi],ah
	xchg [esi],al
	mov bl, score
	mov hitStreak, 0
	sub bl, 2
	mov score, bl
	jmp done

TargetE:
	mov eax,0
	mov al,UserCol
	mov esi,0
	mov esi, offset ArrayE
	mov edi, offset ArrayEDisp
	add edi,eax
	add esi,eax
	mov al,[esi]
	mov ah,[edi]
	cmp al,'X'
	je HitE
	jne Test1E
	HitE:
	mov al,'H'
	mov ah,'X'
	xchg [esi],al
	xchg [edi],ah
	inc hitCounter
	mov bl, score
	mov bh, hitStreak
	inc bh
	add bl, bh
	mov hitStreak, bh
	mov score, bl
	jmp done
	Test1E:
	cmp al,'H'
	je Test2E
	cmp al,'M'
	je Test2E
	cmp al,'-'
	jmp MissE
	JMP done
	Test2E:
	mov edx, offset AlreadyTargeted
	Call WriteString
	Call Crlf
	Jmp Retry1
	MissE:
	mov al,'M'
	mov ah,'O'
	xchg [edi],ah
	xchg [esi],al
	mov bl, score
	mov hitStreak, 0
	sub bl, 2
	mov score, bl
	jmp done

TargetF:
	mov eax,0
	mov al,UserCol
	mov esi,0
	mov edi, 0
	mov esi, offset ArrayF
	mov edi, offset ArrayFDisp
	add edi,eax
	add esi,eax
	mov al,[esi]
	mov ah,[edi]
	cmp al,'X'
	je HitF
	jne Test1F
	HitF:
	mov al,'H'
	mov ah,'X'
	xchg [edi],ah
	xchg [esi],al
	inc hitCounter
	mov bl, score
	mov bh, hitStreak
	inc bh
	add bl, bh
	mov hitStreak, bh
	mov score, bl
	jmp done
	Test1F:
	cmp al,'H'
	je Test2F
	cmp al,'M'
	je Test2F
	cmp al,'-'
	jmp MissF
	JMP done
	Test2F:
	mov edx, offset AlreadyTargeted
	Call WriteString
	Call Crlf
	Jmp Retry1
	MissF:
	mov al,'M'
	mov ah,'O'
	xchg [esi],al
	xchg [edi],ah
	mov bl, score
	mov hitStreak, 0
	sub bl, 2
	mov score, bl
	jmp done
	
TargetG:
	mov eax,0
	mov al,UserCol
	mov esi,0
	mov esi, offset ArrayG
	mov edi, offset ArrayGDisp
	add esi,eax
	add edi, eax
	mov al,[esi]
	mov ah,[edi]
	cmp al,'X'
	je HitG
	jne Test1G
	HitG:
	mov al,'H'
	mov ah,'X'
	xchg [esi],al
	xchg [edi],ah
	inc hitCounter
	mov bl, score
	mov bh, hitStreak
	inc bh
	add bl, bh
	mov hitStreak, bh
	mov score, bl
	jmp done
	Test1G:
	cmp al,'H'
	je Test2G
	cmp al,'M'
	je Test2G
	cmp al,'-'
	jmp MissG
	JMP done
	Test2G:
	mov edx, offset AlreadyTargeted
	Call WriteString
	Call Crlf
	Jmp Retry1
	MissG:
	mov al,'M'
	mov ah,'O'
	xchg [edi],ah
	xchg [esi],al
	mov bl, score
	mov hitStreak, 0
	sub bl, 2
	mov score, bl
	jmp done
	
TargetH:
	mov eax,0
	mov al,UserCol
	mov esi,0
	mov esi, offset ArrayH
	mov edi, offset ArrayHDisp
	add edi,eax
	add esi,eax
	mov al,[esi]
	mov ah,[edi]
	cmp al,'X'
	je HitH
	jne Test1H
	HitH:
	mov al,'H'
	mov ah,'X'
	xchg [edi],ah
	xchg [esi],al
	inc hitCounter
	mov bl, score
	mov bh, hitStreak
	inc bh
	add bl, bh
	mov hitStreak, bh
	mov score, bl
	jmp done
	Test1H:
	cmp al,'H'
	je Test2H
	cmp al,'M'
	je Test2H
	cmp al,'-'
	jmp MissH
	JMP done
	Test2H:
	mov edx, offset AlreadyTargeted
	Call WriteString
	Call Crlf
	Jmp Retry1
	MissH:
	mov al,'M'
	mov ah,'O'
	xchg ah,[edi]
	xchg [esi],al
	mov bl, score
	mov hitStreak, 0
	sub bl, 2
	mov score, bl
	jmp done
	
TargetI:
mov eax,0
	mov al,UserCol
	mov esi,0
	mov esi, offset ArrayI
	mov edi, offset ArrayIDisp
	add edi,eax
	add esi,eax
	mov al,[esi]
	mov ah,[edi]
	cmp al,'X'
	je HitI
	jne Test1I
	HitI:
	mov al,'H'
	mov ah,'X'
	xchg ah,[edi]
	xchg [esi],al
	inc hitCounter
	mov bl, score
	mov bh, hitStreak
	inc bh
	add bl, bh
	mov hitStreak, bh
	mov score, bl
	jmp done
	Test1I:
	cmp al,'H'
	je Test2I
	cmp al,'M'
	je Test2I
	cmp al,'-'
	jmp MissI
	JMP done
	Test2I:
	mov edx, offset AlreadyTargeted
	Call WriteString
	Call Crlf
	Jmp Retry1
	MissI:
	mov al,'M'
	mov ah,'O'
	xchg [edi],ah
	xchg [esi],al
	mov bl, score
	mov hitStreak, 0
	sub bl, 2
	mov score, bl
	jmp done
	
TargetJ:
mov eax,0
	mov al,UserCol
	mov esi,0
	mov esi, offset ArrayJ
	mov edi,offset ArrayJDisp
	add edi,eax
	add esi,eax
	mov ah,[edi]
	mov al,[esi]
	cmp al,'X'
	je HitJ
	jne Test1J
	HitJ:
	mov al,'H'
	mov ah,'X'
	xchg [edi],ah
	xchg [esi],al
	inc hitCounter
	mov bl, score
	mov bh, hitStreak
	inc bh
	add bl, bh
	mov hitStreak, bh
	mov score, bl
	jmp done
	Test1J:
	cmp al,'H'
	je Test2J
	cmp al,'M'
	je Test2J
	cmp al,'-'
	jmp MissJ
	JMP done
	Test2J:
	mov edx, offset AlreadyTargeted
	Call WriteString
	Call Crlf
	Jmp Retry1
	MissJ:
	mov al,'M'
	mov ah,'O'
	xchg [edi],ah
	xchg [esi],al
	mov bl, score
	mov hitStreak, 0
	sub bl, 2
	mov score, bl
	jmp done
	
Error:
jmp retry1

Done:
	mov edx, offset FiringMessage
	Call WriteString
	mov eax, 1000
	call delay

ret
UserInput Endp

;-------------------------------------------------------- Write Back Board ---------------------------------------------------------------------

WriteBoard PROC ;USES EAX EBX ECX EDX ;ESI EDI

;Prints Top Row
mov esi,0
mov esi, offset arrayTop
mov ecx, sizeof arrayTop
Call writestringDisplay
Call CRLF

;Prints A Row
mov esi,0
mov esi, offset arrayA
mov ecx, sizeof arrayA
Call writestringDisplay
Call CRLF

;Prints B Row
mov esi,0
mov esi, offset arrayB
mov ecx, sizeof arrayB
Call writestringDisplay
Call CRLF

;Prints C Row
mov esi,0
mov esi, offset arrayC
mov ecx, sizeof arrayC
Call writestringDisplay
Call CRLF

;Prints D Row
mov esi,0
mov esi, offset arrayD
mov ecx, sizeof arrayD
Call writestringDisplay
Call CRLF

;Prints E Row
mov esi,0
mov esi, offset arrayE
mov ecx, sizeof arrayE
Call writestringDisplay
Call CRLF

;Prints F Row
mov esi,0
mov esi, offset arrayF
mov ecx, sizeof arrayF
Call writestringDisplay
Call CRLF

;Prints G Row
mov esi,0
mov esi, offset arrayG
mov ecx, sizeof arrayG
Call writestringDisplay
Call CRLF

;Prints H Row
mov esi,0
mov esi, offset arrayH
mov ecx, sizeof arrayH
Call writestringDisplay
Call CRLF

;Prints I Row
mov esi,0
mov esi, offset arrayI
mov ecx, sizeof arrayI
Call writestringDisplay
Call CRLF

;Prints J Row
mov esi,0
mov esi, offset arrayJ
mov ecx, sizeof arrayJ
Call writestringDisplay
Call CRLF

ret
WriteBoard endp

;-------------------------------------------------------- Ship Placement ---------------------------------------------------------------------

loopShips PROC ;USES EAX EBX ECX EDX ;ESI EDI
call RandomAC
call RandomBS
call RandomSub
call RandomSub
call RandomPB

ret
loopShips endp

;-------------------------------------------------------- Places Aircraft Carrier ---------------------------------------------------------------------

RandomAC PROC ;USES EAX EBX ECX ;EDX ;ESI EDI
restart:
mov edx, offset message4
call writestring
mov al, 10
Call RandomRange
add al, 65

mov randVal, al
mov al, 10
Call RandomRange
add eax, 1
mov edx, offset message2
call writeint
mov randValInt, eax
cmp randVal, 65
je isA
cmp randVal, 66
je isB
cmp randVal, 67
je isC
cmp randVal, 68
je isD
cmp randVal, 69
je isE
cmp randVal, 70
je isF
cmp randVal, 71
je isG
cmp randVal, 72
je isH
cmp randVal, 73
je isI
cmp randVal, 74
je isJ 
isA: 
mov edx, offset arraya
mov esi, 0
mov esi, randValInt
cmp arraya[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontala
call writestring
mov esi, randValInt 
cmp arrayb[esi], 'X'
je restart
cmp arrayc[esi], 'X'
je restart
cmp arrayd[esi], 'X'
je restart
cmp arraye[esi], 'X'
je restart
mov arraya[esi], 'X'
mov arrayb[esi], 'X'
mov arrayc[esi], 'X'
mov arrayd[esi], 'X'
mov arraye[esi], 'X'
jmp done
horizontala:
cmp randValInt, 1
je indexa1
cmp randValInt, 2
je indexa2
cmp randValInt, 3
je indexa3
cmp randValInt, 4
je indexa4
cmp randValInt, 5
je indexa5
cmp randValInt, 6
je indexa6
cmp randValInt, 7
je indexa7
cmp randValInt, 8
je indexa8
cmp randValInt, 9
je indexa9
cmp randValInt, 10
je indexa10 
indexa1:
	mov esi, 1
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 1
	mov arraya[esi], 'X'
	mov esi, 2
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa2:
	mov esi, 3
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 2
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa3:
	mov esi, 4
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 3
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa4:
	mov esi, 5
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 4
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa5:
	mov esi, 6
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 5
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa6:
	mov esi, 7
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 6
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa7:
	mov esi, 6
	cmp arraya[esi], 'X'
	je restart
	mov esi, 8 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 6
	mov arraya[esi], 'X'
	mov esi, 7
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa8: 
	mov esi, 6
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 9
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 6
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	mov esi, 8
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa9:
	mov esi, 6
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 10 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 6
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	mov esi, 9
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa10: 
	mov esi, 6
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 6
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
isB: 
mov edx, offset arrayb
mov esi, 0
mov esi, randValInt
cmp arrayb[esi], 'X'
je restart
call oneorzero
mov esi, randValInt 
cmp arrayc[esi], 'X'
je restart
cmp arrayd[esi], 'X'
je restart
cmp arraye[esi], 'X'
je restart
cmp arrayf[esi], 'X'
je restart
mov arrayb[esi], 'X'
mov arrayc[esi], 'X'
mov arrayd[esi], 'X'
mov arraye[esi], 'X'
mov arrayf[esi], 'X'
jmp done
horizontalb:
cmp randValInt, 1
je indexb1
cmp randValInt, 2
je indexb2
cmp randValInt, 3
je indexb3
cmp randValInt, 4
je indexb4
cmp randValInt, 5
je indexb5
cmp randValInt, 6
je indexb6
cmp randValInt, 7
je indexb7
cmp randValInt, 8
je indexb8
cmp randValInt, 9
je indexb9
cmp randValInt, 10
je indexb10 
indexb1:
	mov esi, 1
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 1
	mov arrayb[esi], 'X'
	mov esi, 2
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb2:
	mov esi, 3
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 2
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb3:
	mov esi, 4
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 3
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb4:
	mov esi, 5
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 4
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb5:
	mov esi, 6
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 5
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb6:
	mov esi, 7
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 6
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb7:
	mov esi, 6
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 8 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 6
	mov arrayb[esi], 'X'
	mov esi, 7
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb8: 
	mov esi, 6
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 9
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 6
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	mov esi, 8
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb9:
	mov esi, 6
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 6
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	mov esi, 9
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb10: 
	mov esi, 6
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 6
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
isC: 
mov edx, offset arrayc
mov esi, 0
mov esi, randValInt
cmp arrayc[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalc
mov esi, randValInt 
cmp arrayd[esi], 'X'
je restart
cmp arraye[esi], 'X'
je restart
cmp arrayf[esi], 'X'
je restart
cmp arrayg[esi], 'X'
je restart
mov arrayc[esi], 'X'
mov arrayd[esi], 'X'
mov arraye[esi], 'X'
mov arrayf[esi], 'X'
mov arrayg[esi], 'X'
jmp done
horizontalc:
cmp randValInt, 1
je indexc1
cmp randValInt, 2
je indexc2
cmp randValInt, 3
je indexc3
cmp randValInt, 4
je indexc4
cmp randValInt, 5
je indexc5
cmp randValInt, 6
je indexc6
cmp randValInt, 7
je indexc7
cmp randValInt, 8
je indexc8
cmp randValInt, 9
je indexc9
cmp randValInt, 10
je indexc10 
indexc1:
	mov esi, 1
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 1
	mov arrayc[esi], 'X'
	mov esi, 2
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc2:
	mov esi, 3
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 2
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc3:
	mov esi, 4
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 3
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc4:
	mov esi, 5
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 4
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc5:
	mov esi, 6
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 5
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc6:
	mov esi, 7
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 6
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc7:
	mov esi, 6
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 8 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 6
	mov arrayc[esi], 'X'
	mov esi, 7
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc8: 
	mov esi, 6
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 9
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 6
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	mov esi, 8
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc9:
	mov esi, 6
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 6
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	mov esi, 9
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc10: 
	mov esi, 6
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 6
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
isD: 
mov edx, offset arrayd
mov esi, 0
mov esi, randValInt
cmp arrayd[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontald
mov esi, randvalint
cmp arraye[esi], 'X'
je restart
cmp arrayf[esi], 'X'
je restart
cmp arrayg[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
mov arrayd[esi], 'X'
mov arraye[esi], 'X'
mov arrayf[esi], 'X'
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
jmp done
horizontald:
cmp randValInt, 1
je indexd1
cmp randValInt, 2
je indexd2
cmp randValInt, 3
je indexd3
cmp randValInt, 4
je indexd4
cmp randValInt, 5
je indexd5
cmp randValInt, 6
je indexd6
cmp randValInt, 7
je indexd7
cmp randValInt, 8
je indexd8
cmp randValInt, 9
je indexd9
cmp randValInt, 10
je indexd10 
indexd1:
	mov esi, 1
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 1
	mov arrayd[esi], 'X'
	mov esi, 2
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd2:
	mov esi, 3
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 2
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd3:
	mov esi, 4
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 3
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd4:
	mov esi, 5
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 4
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd5:
	mov esi, 6
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 5
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd6:
	mov esi, 7
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 6
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd7:
	mov esi, 6
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 8 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 6
	mov arrayd[esi], 'X'
	mov esi, 7
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd8: 
	mov esi, 6
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 9
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 6
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	mov esi, 8
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd9:
	mov esi, 6
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 6
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	mov esi, 9
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd10: 
	mov esi, 6
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 6
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
isE: 
mov edx, offset arraye
mov esi, 0
mov esi, randValInt
cmp arraye[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontale
cmp arrayf[esi], 'X'
je restart
cmp arrayg[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
cmp arrayi[esi], 'X'
je restart
mov arraye[esi], 'X'
mov arrayf[esi], 'X'
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
mov arrayi[esi], 'X'
jmp done
horizontale:
cmp randValInt, 1
je indexe1
cmp randValInt, 2
je indexe2
cmp randValInt, 3
je indexe3
cmp randValInt, 4
je indexe4
cmp randValInt, 5
je indexe5
cmp randValInt, 6
je indexe6
cmp randValInt, 7
je indexe7
cmp randValInt, 8
je indexe8
cmp randValInt, 9
je indexe9
cmp randValInt, 10
je indexe10 
indexe1:
	mov esi, 1
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 1
	mov arraye[esi], 'X'
	mov esi, 2
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe2:
	mov esi, 3
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 2
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe3:
	mov esi, 4
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 3
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe4:
	mov esi, 5
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 4
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe5:
	mov esi, 6
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 5
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe6:
	mov esi, 7
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 6
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe7:
	mov esi, 6
	cmp arraye[esi], 'X'
	je restart
	mov esi, 8 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 6
	mov arraye[esi], 'X'
	mov esi, 7
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe8: 
	mov esi, 6
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 9
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 6
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	mov esi, 8
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe9:
	mov esi, 6
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 10 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 6
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	mov esi, 9
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe10: 
	mov esi, 6
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 6
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
isF: 
mov edx, offset arrayf
mov esi, 0
mov esi, randValInt
cmp arrayf[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalf
cmp arrayg[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
cmp arrayi[esi], 'X'
je restart
cmp arrayj[esi], 'X'
je restart
mov arrayf[esi], 'X'
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
mov arrayi[esi], 'X'
mov arrayj[esi], 'X'
jmp done
horizontalf:
cmp randValInt, 1
je indexf1
cmp randValInt, 2
je indexf2
cmp randValInt, 3
je indexf3
cmp randValInt, 4
je indexf4
cmp randValInt, 5
je indexf5
cmp randValInt, 6
je indexf6
cmp randValInt, 7
je indexf7
cmp randValInt, 8
je indexf8
cmp randValInt, 9
je indexf9
cmp randValInt, 10
je indexf10 
indexf1:
	mov esi, 1
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 1
	mov arrayf[esi], 'X'
	mov esi, 2
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf2:
	mov esi, 3
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 2
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf3:
	mov esi, 4
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 3
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf4:
	mov esi, 5
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 4
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf5:
	mov esi, 6
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 5
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf6:
	mov esi, 7
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 6
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf7:
	mov esi, 6
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 8 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 6
	mov arrayf[esi], 'X'
	mov esi, 7
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf8: 
	mov esi, 6
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 9
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 6
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	mov esi, 8
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf9:
	mov esi, 6
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 6
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	mov esi, 9
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf10: 
	mov esi, 6
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 6
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
isG: 
mov edx, offset arrayg
mov esi, 0
mov esi, randValInt
cmp arrayg[esi], 'X'
je restart
mov arrayg[esi], 'X'
call oneorzero
cmp var1, 1
je horizontalg
cmp arrayh[esi], 'X'
je restart
cmp arrayi[esi], 'X'
je restart
cmp arrayj[esi], 'X'
je restart
cmp arrayf[esi], 'X'
je restart
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
mov arrayi[esi], 'X'
mov arrayj[esi], 'X'
mov arrayf[esi], 'X'
jmp done
horizontalg:
cmp randValInt, 1
je indexg1
cmp randValInt, 2
je indexg2
cmp randValInt, 3
je indexg3
cmp randValInt, 4
je indexg4
cmp randValInt, 5
je indexg5
cmp randValInt, 6
je indexg6
cmp randValInt, 7
je indexg7
cmp randValInt, 8
je indexg8
cmp randValInt, 9
je indexg9
cmp randValInt, 10
je indexg10 
indexg1:
	mov esi, 1
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 1
	mov arrayg[esi], 'X'
	mov esi, 2
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg2:
	mov esi, 3
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 2
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg3:
	mov esi, 4
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 3
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg4:
	mov esi, 5
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 4
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg5:
	mov esi, 6
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 5
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg6:
	mov esi, 7
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 6
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg7:
	mov esi, 6
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 8 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 6
	mov arrayg[esi], 'X'
	mov esi, 7
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg8: 
	mov esi, 6
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 9
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 6
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	mov esi, 8
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg9:
	mov esi, 6
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 6
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	mov esi, 9
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg10: 
	mov esi, 6
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 6
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
isH: 
mov edx, offset arrayh
mov esi, 0
mov esi, randValInt
cmp arrayh[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalh
cmp arrayi[esi], 'X'
je restart
cmp arrayj[esi], 'X'
je restart
cmp arrayf[esi], 'X'
je restart
cmp arrayg[esi], 'X'
je restart
mov arrayh[esi], 'X'
mov arrayi[esi], 'X'
mov arrayj[esi], 'X'
mov arrayf[esi], 'X'
mov arrayg[esi], 'X'
jmp done
horizontalh:
cmp randValInt, 1
je indexh1
cmp randValInt, 2
je indexh2
cmp randValInt, 3
je indexh3
cmp randValInt, 4
je indexh4
cmp randValInt, 5
je indexh5
cmp randValInt, 6
je indexh6
cmp randValInt, 7
je indexh7
cmp randValInt, 8
je indexh8
cmp randValInt, 9
je indexh9
cmp randValInt, 10
je indexh10 
indexh1:
	mov esi, 1
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 1
	mov arrayh[esi], 'X'
	mov esi, 2
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh2:
	mov esi, 3
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 2
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh3:
	mov esi, 4
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 3
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh4:
	mov esi, 5
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 4
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh5:
	mov esi, 6
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 5
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh6:
	mov esi, 7
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 6
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh7:
	mov esi, 6
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 8 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 6
	mov arrayh[esi], 'X'
	mov esi, 7
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh8: 
	mov esi, 6
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 9
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 6
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	mov esi, 8
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh9:
	mov esi, 6
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 6
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	mov esi, 9
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh10: 
	mov esi, 6
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 6
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
isI: 
mov edx, offset arrayi
mov esi, 0
mov esi, randValInt
cmp arrayi[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontali
cmp arrayj[esi], 'X'
je restart
cmp arrayf[esi], 'X'
je restart
cmp arrayg[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
mov arrayi[esi], 'X'
mov arrayj[esi], 'X'
mov arrayf[esi], 'X'
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
jmp done
horizontali:
cmp randValInt, 1
je indexi1
cmp randValInt, 2
je indexi2
cmp randValInt, 3
je indexi3
cmp randValInt, 4
je indexi4
cmp randValInt, 5
je indexi5
cmp randValInt, 6
je indexi6
cmp randValInt, 7
je indexi7
cmp randValInt, 8
je indexi8
cmp randValInt, 9
je indexi9
cmp randValInt, 10
je indexi10 
indexi1:
	mov esi, 1
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 1
	mov arrayi[esi], 'X'
	mov esi, 2
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi2:
	mov esi, 3
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 2
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi3:
	mov esi, 4
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 3
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi4:
	mov esi, 5
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 4
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi5:
	mov esi, 6
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 5
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi6:
	mov esi, 7
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 6
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi7:
	mov esi, 6
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 8 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 6
	mov arrayi[esi], 'X'
	mov esi, 7
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi8: 
	mov esi, 6
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 9
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 6
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	mov esi, 8
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi9:
	mov esi, 6
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 6
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	mov esi, 9
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi10: 
	mov esi, 6
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 6
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
isJ: 
mov edx, offset arrayj
mov esi, 0
mov esi, randValInt
cmp arrayj[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalj
mov esi, randvalint
cmp arrayf[esi], 'X'
je restart
cmp arrayg[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
cmp arrayi[esi], 'X'
je restart
cmp arraye[esi], 'X'
je restart
mov arrayj[esi], 'X'
mov arrayf[esi], 'X'
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
mov arrayi[esi], 'X'
jmp done
horizontalj:
cmp randValInt, 1
je indexj1
cmp randValInt, 2
je indexj2
cmp randValInt, 3
je indexj3
cmp randValInt, 4
je indexj4
cmp randValInt, 5
je indexj5
cmp randValInt, 6
je indexj6
cmp randValInt, 7
je indexj7
cmp randValInt, 8
je indexj8
cmp randValInt, 9
je indexj9
cmp randValInt, 10
je indexj10 
indexj1:
	mov esi, 1
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 1
	mov arrayj[esi], 'X'
	mov esi, 2
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj2:
	mov esi, 3
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 2
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj3:
	mov esi, 4
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 3
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj4:
	mov esi, 5
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 4
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj5:
	mov esi, 6
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 5
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj6:
	mov esi, 7
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 6
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj7:
	mov esi, 6
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 8 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 6
	mov arrayj[esi], 'X'
	mov esi, 7
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj8: 
	mov esi, 6
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 9
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 6
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	mov esi, 8
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj9:
	mov esi, 6
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 6
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	mov esi, 9
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj10: 
	mov esi, 6
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 6
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
done:

call crlf
ret
RandomAC ENDP

;-------------------------------------------------------- Places Battleship ---------------------------------------------------------------------

RandomBS PROC ;USES EAX EBX ECX EDX ;ESI EDI
restart:
mov al, 10
Call RandomRange
add al, 65
mov randVal, al

call crlf
mov al, 10
Call RandomRange

add eax, 1
mov randValInt, eax
call crlf
cmp randVal, 65
je isA
cmp randVal, 66
je isB
cmp randVal, 67
je isC
cmp randVal, 68
je isD
cmp randVal, 69
je isE
cmp randVal, 70
je isF
cmp randVal, 71
je isG
cmp randVal, 72
je isH
cmp randVal, 73
je isI
cmp randVal, 74
je isJ 

isA: 
mov edx, offset arraya
mov esi, 0
mov esi, randValInt
cmp arrayA[esi], 'X'
je restart

call oneorzero
cmp var1, 1
je horizontala

mov esi, randvalint
cmp arrayb[esi], 'X'
je restart
cmp arrayc[esi], 'X'
je restart
cmp arrayd[esi], 'X' 
je restart
mov arrayb[esi], 'X'
mov arrayc[esi], 'X'
mov arrayd[esi], 'X'
mov arraya[esi], 'X'
jmp done
horizontala:
cmp randValInt, 1
je indexa1
cmp randValInt, 2
je indexa2
cmp randValInt, 3
je indexa3
cmp randValInt, 4
je indexa4
cmp randValInt, 5
je indexa5
cmp randValInt, 6
je indexa6
cmp randValInt, 7
je indexa7
cmp randValInt, 8
je indexa8
cmp randValInt, 9
je indexa9
cmp randValInt, 10
je indexa10 
indexa1:
	mov esi, 2
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 1
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa2:
	mov esi, 3
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 2
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa3:
	mov esi, 4
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 3
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa4:
	mov esi, 5
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 4
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa5:
	mov esi, 6
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 5
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa6:
	mov esi, 7
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 6
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa7:
	mov esi, 8
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 7
	mov arraya[esi], 'X'
	mov esi, 8
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa8: 
	mov esi, 7
	cmp arraya[esi], 'X'
	je restart
	mov esi, 9 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 7
	mov arraya[esi], 'X'
	mov esi, 8
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa9:
	mov esi, 7
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 10 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 7
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	mov esi, 10
	mov arraya[esi], 'X'
	jmp done
indexa10: 
	mov esi, 7
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 7
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
isB: 
mov edx, offset arrayb
mov esi, 0
mov esi, randValInt
cmp arrayb[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalb
mov esi, randvalint
cmp arrayc[esi], 'X'
je restart
cmp arrayd[esi], 'X'
je restart
cmp arraye[esi], 'X' 
je restart
mov arrayc[esi], 'X'
mov arrayd[esi], 'X'
mov arraye[esi], 'X'
mov arrayb[esi], 'X'
jmp done
horizontalb:
cmp randValInt, 1
je indexb1
cmp randValInt, 2
je indexb2
cmp randValInt, 3
je indexb3
cmp randValInt, 4
je indexb4
cmp randValInt, 5
je indexb5
cmp randValInt, 6
je indexb6
cmp randValInt, 7
je indexb7
cmp randValInt, 8
je indexb8
cmp randValInt, 9
je indexb9
cmp randValInt, 10
je indexb10 
indexb1:
	mov esi, 2
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 1
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb2:
	mov esi, 3
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 2
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb3:
	mov esi, 4
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 3
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb4:
	mov esi, 5
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 4
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb5:
	mov esi, 6
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 5
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb6:
	mov esi, 7
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 6
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb7:
	mov esi, 8
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 7
	mov arrayb[esi], 'X'
	mov esi, 8
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb8: 
	mov esi, 7
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 9 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 7
	mov arrayb[esi], 'X'
	mov esi, 8
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb9:
	mov esi, 7
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 7
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	mov esi, 10
	mov arrayb[esi], 'X'
	jmp done
indexb10: 
	mov esi, 7
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 7
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
isC: 
mov edx, offset arrayc
mov esi, 0
mov esi, randValInt
cmp arrayc[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalc
mov esi, randvalint
cmp arrayd[esi], 'X'
je restart
cmp arraye[esi], 'X'
je restart
cmp arrayf[esi], 'X' 
je restart
mov arrayd[esi], 'X'
mov arraye[esi], 'X'
mov arrayf[esi], 'X'
mov arrayc[esi], 'X'
jmp done
horizontalc:
cmp randValInt, 1
je indexc1
cmp randValInt, 2
je indexc2
cmp randValInt, 3
je indexc3
cmp randValInt, 4
je indexc4
cmp randValInt, 5
je indexc5
cmp randValInt, 6
je indexc6
cmp randValInt, 7
je indexc7
cmp randValInt, 8
je indexc8
cmp randValInt, 9
je indexc9
cmp randValInt, 10
je indexc10 
indexc1:
	mov esi, 2
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 1
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc2:
	mov esi, 3
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 2
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc3:
	mov esi, 4
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 3
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc4:
	mov esi, 5
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 4
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc5:
	mov esi, 6
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 5
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc6:
	mov esi, 7
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 6
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc7:
	mov esi, 8
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 7
	mov arrayc[esi], 'X'
	mov esi, 8
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc8: 
	mov esi, 7
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 9 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 7
	mov arrayc[esi], 'X'
	mov esi, 8
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc9:
	mov esi, 7
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 7
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	mov esi, 10
	mov arrayc[esi], 'X'
	jmp done
indexc10: 
	mov esi, 7
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 7
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
isD: 
mov edx, offset arrayd
mov esi, 0
mov esi, randValInt
cmp arrayd[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontald
mov esi, randvalint
cmp arraye[esi], 'X'
je restart
cmp arrayf[esi], 'X'
je restart
cmp arrayg[esi], 'X' 
je restart
mov arraye[esi], 'X'
mov arrayf[esi], 'X'
mov arrayg[esi], 'X'
mov arrayd[esi], 'X'
jmp done
horizontald:
cmp randValInt, 1
je indexd1
cmp randValInt, 2
je indexd2
cmp randValInt, 3
je indexd3
cmp randValInt, 4
je indexd4
cmp randValInt, 5
je indexd5
cmp randValInt, 6
je indexd6
cmp randValInt, 7
je indexd7
cmp randValInt, 8
je indexd8
cmp randValInt, 9
je indexd9
cmp randValInt, 10
je indexd10 
indexd1:
	mov esi, 2
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 1
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd2:
	mov esi, 3
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 2
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd3:
	mov esi, 4
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 3
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd4:
	mov esi, 5
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 4
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd5:
	mov esi, 6
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 5
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd6:
	mov esi, 7
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 6
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd7:
	mov esi, 8
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 7
	mov arrayd[esi], 'X'
	mov esi, 8
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd8: 
	mov esi, 7
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 9 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 7
	mov arrayd[esi], 'X'
	mov esi, 8
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd9:
	mov esi, 7
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 7
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	mov esi, 10
	mov arrayd[esi], 'X'
	jmp done
indexd10: 
	mov esi, 7
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 7
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
isE: 
mov edx, offset arraye
mov esi, 0
mov esi, randValInt
cmp arraye[esi], 'X'
je restart

call oneorzero
cmp var1, 1
je horizontale

mov esi, randvalint
cmp arrayf[esi], 'X'
je restart
cmp arrayg[esi], 'X'
je restart
cmp arrayh[esi], 'X' 
je restart
mov arrayf[esi], 'X'
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
mov arraye[esi], 'X'
jmp done
horizontale:
cmp randValInt, 1
je indexe1
cmp randValInt, 2
je indexe2
cmp randValInt, 3
je indexe3
cmp randValInt, 4
je indexe4
cmp randValInt, 5
je indexe5
cmp randValInt, 6
je indexe6
cmp randValInt, 7
je indexe7
cmp randValInt, 8
je indexe8
cmp randValInt, 9
je indexe9
cmp randValInt, 10
je indexe10 
indexe1:
	mov esi, 2
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 1
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe2:
	mov esi, 3
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 2
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe3:
	mov esi, 4
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 3
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe4:
	mov esi, 5
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 4
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe5:
	mov esi, 6
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 5
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe6:
	mov esi, 7
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 6
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe7:
	mov esi, 8
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 7
	mov arraye[esi], 'X'
	mov esi, 8
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe8: 
	mov esi, 7
	cmp arraye[esi], 'X'
	je restart
	mov esi, 9 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 7
	mov arraye[esi], 'X'
	mov esi, 8
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe9:
	mov esi, 7
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 10 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 7
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	mov esi, 10
	mov arraye[esi], 'X'
	jmp done
indexe10: 
	mov esi, 7
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 7
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
isF: 
mov edx, offset arrayf
mov esi, 0
mov esi, randValInt
cmp arrayf[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalf
mov esi, randvalint
cmp arrayg[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
cmp arrayi[esi], 'X' 
je restart
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
mov arrayi[esi], 'X'
mov arrayf[esi], 'X'
jmp done
horizontalf:
cmp randValInt, 1
je indexf1
cmp randValInt, 2
je indexf2
cmp randValInt, 3
je indexf3
cmp randValInt, 4
je indexf4
cmp randValInt, 5
je indexf5
cmp randValInt, 6
je indexf6
cmp randValInt, 7
je indexf7
cmp randValInt, 8
je indexf8
cmp randValInt, 9
je indexf9
cmp randValInt, 10
je indexf10 
indexf1:
	mov esi, 2
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 1
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf2:
	mov esi, 3
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 2
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf3:
	mov esi, 4
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 3
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf4:
	mov esi, 5
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 4
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf5:
	mov esi, 6
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 5
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf6:
	mov esi, 7
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 6
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf7:
	mov esi, 8
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 7
	mov arrayf[esi], 'X'
	mov esi, 8
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf8: 
	mov esi, 7
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 9 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 7
	mov arrayf[esi], 'X'
	mov esi, 8
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf9:
	mov esi, 7
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 7
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	mov esi, 10
	mov arrayf[esi], 'X'
	jmp done
indexf10: 
	mov esi, 7
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 7
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
isG: 
mov edx, offset arrayg
mov esi, 0
mov esi, randValInt
cmp arrayg[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalg
mov esi, randvalint
cmp arrayh[esi], 'X'
je restart
cmp arrayi[esi], 'X'
je restart
cmp arrayj[esi], 'X' 
je restart
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
mov arrayi[esi], 'X'
mov arrayj[esi], 'X'
jmp done
horizontalg:
cmp randValInt, 1
je indexg1
cmp randValInt, 2
je indexg2
cmp randValInt, 3
je indexg3
cmp randValInt, 4
je indexg4
cmp randValInt, 5
je indexg5
cmp randValInt, 6
je indexg6
cmp randValInt, 7
je indexg7
cmp randValInt, 8
je indexg8
cmp randValInt, 9
je indexg9
cmp randValInt, 10
je indexg10 
indexg1:
	mov esi, 2
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 1
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg2:
	mov esi, 3
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 2
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg3:
	mov esi, 4
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 3
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg4:
	mov esi, 5
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 4
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg5:
	mov esi, 6
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 5
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg6:
	mov esi, 7
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 6
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg7:
	mov esi, 8
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 7
	mov arrayg[esi], 'X'
	mov esi, 8
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg8: 
	mov esi, 7
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 9 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 7
	mov arrayg[esi], 'X'
	mov esi, 8
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg9:
	mov esi, 7
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 7
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	mov esi, 10
	mov arrayg[esi], 'X'
	jmp done
indexg10: 
	mov esi, 7
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 7
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
isH: 
mov edx, offset arrayh
mov esi, 0
mov esi, randValInt
cmp arrayh[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalh
mov esi, randvalint
cmp arrayi[esi], 'X'
je restart
cmp arrayj[esi], 'X'
je restart
cmp arrayg[esi], 'X' 
je restart
mov arrayi[esi], 'X'
mov arrayj[esi], 'X'
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
jmp done
horizontalh:
cmp randValInt, 1
je indexh1
cmp randValInt, 2
je indexh2
cmp randValInt, 3
je indexh3
cmp randValInt, 4
je indexh4
cmp randValInt, 5
je indexh5
cmp randValInt, 6
je indexh6
cmp randValInt, 7
je indexh7
cmp randValInt, 8
je indexh8
cmp randValInt, 9
je indexh9
cmp randValInt, 10
je indexh10 
indexh1:
	mov esi, 2
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 1
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh2:
	mov esi, 3
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 2
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh3:
	mov esi, 4
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 3
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh4:
	mov esi, 5
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 4
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh5:
	mov esi, 6
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 5
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh6:
	mov esi, 7
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 6
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh7:
	mov esi, 8
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 7
	mov arrayh[esi], 'X'
	mov esi, 8
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh8: 
	mov esi, 7
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 9 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 7
	mov arrayh[esi], 'X'
	mov esi, 8
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh9:
	mov esi, 7
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 7
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	mov esi, 10
	mov arrayh[esi], 'X'
	jmp done
indexh10: 
	mov esi, 7
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 7
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
isI: 
mov edx, offset arrayi
mov esi, 0
mov esi, randValInt
cmp arrayi[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontali
mov esi, randvalint
cmp arrayj[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
cmp arrayg[esi], 'X' 
je restart
mov arrayj[esi], 'X'
mov arrayh[esi], 'X'
mov arrayg[esi], 'X'
mov arrayi[esi], 'X'
jmp done
horizontali:
cmp randValInt, 1
je indexi1
cmp randValInt, 2
je indexi2
cmp randValInt, 3
je indexi3
cmp randValInt, 4
je indexi4
cmp randValInt, 5
je indexi5
cmp randValInt, 6
je indexi6
cmp randValInt, 7
je indexi7
cmp randValInt, 8
je indexi8
cmp randValInt, 9
je indexi9
cmp randValInt, 10
je indexi10 
indexi1:
	mov esi, 2
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 1
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi2:
	mov esi, 3
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 2
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi3:
	mov esi, 4
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 3
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi4:
	mov esi, 5
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 4
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi5:
	mov esi, 6
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 5
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi6:
	mov esi, 7
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 6
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi7:
	mov esi, 8
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 7
	mov arrayi[esi], 'X'
	mov esi, 8
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi8: 
	mov esi, 7
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 9 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 7
	mov arrayi[esi], 'X'
	mov esi, 8
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi9:
	mov esi, 7
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 7
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	mov esi, 10
	mov arrayi[esi], 'X'
	jmp done
indexi10: 
	mov esi, 7
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 7
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
isJ: 
mov edx, offset arrayj
mov esi, 0
mov esi, randValInt
cmp arrayj[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalj
mov esi, randvalint
cmp arrayi[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
cmp arrayg[esi], 'X' 
je restart
mov arrayi[esi], 'X'
mov arrayh[esi], 'X'
mov arrayg[esi], 'X'
mov arrayj[esi], 'X'
jmp done
horizontalj:
cmp randValInt, 1
je indexj1
cmp randValInt, 2
je indexj2
cmp randValInt, 3
je indexj3
cmp randValInt, 4
je indexj4
cmp randValInt, 5
je indexj5
cmp randValInt, 6
je indexj6
cmp randValInt, 7
je indexj7
cmp randValInt, 8
je indexj8
cmp randValInt, 9
je indexj9
cmp randValInt, 10
je indexj10 
indexj1:
	mov esi, 2
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 1
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj2:
	mov esi, 3
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 2
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj3:
	mov esi, 4
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 3
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj4:
	mov esi, 5
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 4
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj5:
	mov esi, 6
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 5
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj6:
	mov esi, 7
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 6
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj7:
	mov esi, 8
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 7
	mov arrayj[esi], 'X'
	mov esi, 8
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj8: 
	mov esi, 7
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 9 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 7
	mov arrayj[esi], 'X'
	mov esi, 8
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj9:
	mov esi, 7
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 7
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	mov esi, 10
	mov arrayj[esi], 'X'
	jmp done
indexj10: 
	mov esi, 7
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 7
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
done:
call crlf
ret
RandomBS ENDP

;-------------------------------------------------------- Places Submarine --------------------------------------------

RandomSub PROC ;USES EAX EBX ECX EDX ;ESI EDI
restart:
mov al, 10
Call RandomRange
add al, 65
mov randVal, al
call crlf
mov al, 10
Call RandomRange
add eax, 1
mov randValInt, eax
call crlf
cmp randVal, 65
je isA
cmp randVal, 66
je isB
cmp randVal, 67
je isC
cmp randVal, 68
je isD
cmp randVal, 69
je isE
cmp randVal, 70
je isF
cmp randVal, 71
je isG
cmp randVal, 72
je isH
cmp randVal, 73
je isI
cmp randVal, 74
je isJ 
isA: 
mov edx, offset arraya
mov esi, 0
mov esi, randValInt
cmp arraya[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontala
mov esi, randvalint
cmp arrayb[esi], 'X'
je restart
cmp arrayc[esi], 'X'
je restart
cmp arraya[esi], 'X'
je restart
mov arrayb[esi], 'X'
mov arrayc[esi], 'X'
mov arraya[esi], 'X'
jmp done
horizontala:
cmp randValInt, 1
je indexa1
cmp randValInt, 2
je indexa2
cmp randValInt, 3
je indexa3
cmp randValInt, 4
je indexa4
cmp randValInt, 5
je indexa5
cmp randValInt, 6
je indexa6
cmp randValInt, 7
je indexa7
cmp randValInt, 8
je indexa8
cmp randValInt, 9
je indexa9
cmp randValInt, 10
je indexa10 
indexa1:
	mov esi, 2
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 1
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa2:
	mov esi, 3
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 2
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa3:
	mov esi, 4
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 3
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa4:
	mov esi, 5
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 4
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa5:
	mov esi, 6
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 5
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa6:
	mov esi, 7
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 6
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa7:
	mov esi, 8
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 7
	mov arraya[esi], 'X'
	mov esi, 8
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa8: 
	mov esi, 9
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 8
	mov arraya[esi], 'X'
	mov esi, 9
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa9:
	mov esi, 8
	cmp arraya[esi], 'X'
	je restart
	mov esi, 10 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 7
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
indexa10: 
	mov esi, 8
	cmp arraya[esi], 'X'
	je restart
	inc esi 
	cmp arraya[esi], 'X'
	je restart
	mov esi, 8
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	inc esi
	mov arraya[esi], 'X'
	jmp done
isB: 
mov edx, offset arrayb
mov esi, 0
mov esi, randValInt
cmp arrayb[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalb
cmp arrayc[esi], 'X'
je restart
cmp arrayd[esi], 'X'
je restart
cmp arrayb[esi], 'X'
je restart
mov arrayc[esi], 'X'
mov arrayd[esi], 'X'
mov arrayb[esi], 'X'
jmp done
horizontalb:
cmp randValInt, 1
je indexb1
cmp randValInt, 2
je indexb2
cmp randValInt, 3
je indexb3
cmp randValInt, 4
je indexb4
cmp randValInt, 5
je indexb5
cmp randValInt, 6
je indexb6
cmp randValInt, 7
je indexb7
cmp randValInt, 8
je indexb8
cmp randValInt, 9
je indexb9
cmp randValInt, 10
je indexb10 
indexb1:
	mov esi, 2
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 1
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb2:
	mov esi, 3
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 2
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb3:
	mov esi, 4
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 3
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb4:
	mov esi, 5
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 4
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb5:
	mov esi, 6
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 5
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb6:
	mov esi, 7
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 6
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb7:
	mov esi, 8
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 7
	mov arrayb[esi], 'X'
	mov esi, 8
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb8: 
	mov esi, 9
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 8
	mov arrayb[esi], 'X'
	mov esi, 9
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb9:
	mov esi, 8
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 7
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb10: 
	mov esi, 8
	cmp arrayb[esi], 'X'
	je restart
	inc esi 
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 8
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
isC: 
mov edx, offset arrayc
mov esi, 0
mov esi, randValInt
cmp arrayc[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalc
cmp arrayd[esi], 'X'
je restart
cmp arraye[esi], 'X'
je restart
mov arrayc[esi], 'X'
mov arrayd[esi], 'X'
mov arraye[esi], 'X'
jmp done
horizontalc:
cmp randValInt, 1
je indexc1
cmp randValInt, 2
je indexc2
cmp randValInt, 3
je indexc3
cmp randValInt, 4
je indexc4
cmp randValInt, 5
je indexc5
cmp randValInt, 6
je indexc6
cmp randValInt, 7
je indexc7
cmp randValInt, 8
je indexc8
cmp randValInt, 9
je indexc9
cmp randValInt, 10
je indexc10 
indexc1:
	mov esi, 2
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 1
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc2:
	mov esi, 3
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 2
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc3:
	mov esi, 4
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 3
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc4:
	mov esi, 5
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 4
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc5:
	mov esi, 6
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 5
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc6:
	mov esi, 7
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 6
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc7:
	mov esi, 8
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 7
	mov arrayc[esi], 'X'
	mov esi, 8
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc8: 
	mov esi, 9
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 8
	mov arrayc[esi], 'X'
	mov esi, 9
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc9:
	mov esi, 8
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 7
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc10: 
	mov esi, 8
	cmp arrayc[esi], 'X'
	je restart
	inc esi 
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 8
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
isD: 
mov edx, offset arrayd
mov esi, 0
mov esi, randValInt
cmp arrayd[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontald
cmp arraye[esi], 'X'
je restart
cmp arrayf[esi], 'X'
je restart
mov arrayd[esi], 'X'
mov arraye[esi], 'X'
mov arrayf[esi], 'X'
jmp done
horizontald:
cmp randValInt, 1
je indexd1
cmp randValInt, 2
je indexd2
cmp randValInt, 3
je indexd3
cmp randValInt, 4
je indexd4
cmp randValInt, 5
je indexd5
cmp randValInt, 6
je indexd6
cmp randValInt, 7
je indexd7
cmp randValInt, 8
je indexd8
cmp randValInt, 9
je indexd9
cmp randValInt, 10
je indexd10 
indexd1:
	mov esi, 2
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 1
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd2:
	mov esi, 3
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 2
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd3:
	mov esi, 4
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 3
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd4:
	mov esi, 5
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 4
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd5:
	mov esi, 6
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 5
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd6:
	mov esi, 7
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 6
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd7:
	mov esi, 8
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 7
	mov arrayd[esi], 'X'
	mov esi, 8
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd8: 
	mov esi, 9
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 8
	mov arrayd[esi], 'X'
	mov esi, 9
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd9:
	mov esi, 8
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 7
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd10: 
	mov esi, 8
	cmp arrayd[esi], 'X'
	je restart
	inc esi 
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 8
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
isE: 
mov edx, offset arraye
mov esi, 0
mov esi, randValInt
cmp arraye[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontale
cmp arrayf[esi], 'X'
je restart
cmp arrayg[esi], 'X'
je restart
mov arrayf[esi], 'X'
mov arrayg[esi], 'X'
mov arraye[esi], 'X'
jmp done
horizontale:
cmp randValInt, 1
je indexe1
cmp randValInt, 2
je indexe2
cmp randValInt, 3
je indexe3
cmp randValInt, 4
je indexe4
cmp randValInt, 5
je indexe5
cmp randValInt, 6
je indexe6
cmp randValInt, 7
je indexe7
cmp randValInt, 8
je indexe8
cmp randValInt, 9
je indexe9
cmp randValInt, 10
je indexe10 
indexe1:
	mov esi, 2
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 1
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe2:
	mov esi, 3
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 2
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe3:
	mov esi, 4
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 3
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe4:
	mov esi, 5
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 4
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe5:
	mov esi, 6
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 5
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe6:
	mov esi, 7
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 6
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe7:
	mov esi, 8
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 7
	mov arraye[esi], 'X'
	mov esi, 8
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe8: 
	mov esi, 9
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 8
	mov arraye[esi], 'X'
	mov esi, 9
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe9:
	mov esi, 8
	cmp arraye[esi], 'X'
	je restart
	mov esi, 10 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 7
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe10: 
	mov esi, 8
	cmp arraye[esi], 'X'
	je restart
	inc esi 
	cmp arraye[esi], 'X'
	je restart
	mov esi, 8
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
isF: 
mov edx, offset arrayf
mov esi, 0
mov esi, randValInt
cmp arrayf[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalf
cmp arrayg[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
mov arrayg[esi], 'X'
mov arrayh[esi], 'X'
mov arrayf[esi], 'X'
jmp done
horizontalf:
cmp randValInt, 1
je indexf1
cmp randValInt, 2
je indexf2
cmp randValInt, 3
je indexf3
cmp randValInt, 4
je indexf4
cmp randValInt, 5
je indexf5
cmp randValInt, 6
je indexf6
cmp randValInt, 7
je indexf7
cmp randValInt, 8
je indexf8
cmp randValInt, 9
je indexf9
cmp randValInt, 10
je indexf10 
indexf1:
	mov esi, 2
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 1
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf2:
	mov esi, 3
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 2
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf3:
	mov esi, 4
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 3
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf4:
	mov esi, 5
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 4
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf5:
	mov esi, 6
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 5
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf6:
	mov esi, 7
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 6
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf7:
	mov esi, 8
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 7
	mov arrayf[esi], 'X'
	mov esi, 8
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf8: 
	mov esi, 9
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 8
	mov arrayf[esi], 'X'
	mov esi, 9
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf9:
	mov esi, 8
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 7
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf10: 
	mov esi, 8
	cmp arrayf[esi], 'X'
	je restart
	inc esi 
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 8
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
isG: 
mov edx, offset arrayg
mov esi, 0
mov esi, randValInt
cmp arrayg[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalg
cmp arrayh[esi], 'X'
je restart
cmp arrayi[esi], 'X'
je restart
mov arrayh[esi], 'X'
mov arrayi[esi], 'X'
mov arrayg[esi], 'X'
jmp done
horizontalg:
cmp randValInt, 1
je indexg1
cmp randValInt, 2
je indexg2
cmp randValInt, 3
je indexg3
cmp randValInt, 4
je indexg4
cmp randValInt, 5
je indexg5
cmp randValInt, 6
je indexg6
cmp randValInt, 7
je indexg7
cmp randValInt, 8
je indexg8
cmp randValInt, 9
je indexg9
cmp randValInt, 10
je indexg10 
indexg1:
	mov esi, 2
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 1
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg2:
	mov esi, 3
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 2
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg3:
	mov esi, 4
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 3
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg4:
	mov esi, 5
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 4
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg5:
	mov esi, 6
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 5
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg6:
	mov esi, 7
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 6
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg7:
	mov esi, 8
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 7
	mov arrayg[esi], 'X'
	mov esi, 8
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg8: 
	mov esi, 9
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 8
	mov arrayg[esi], 'X'
	mov esi, 9
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg9:
	mov esi, 8
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 7
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg10: 
	mov esi, 8
	cmp arrayg[esi], 'X'
	je restart
	inc esi 
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 8
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
isH: 
mov edx, offset arrayh
mov esi, 0
mov esi, randValInt
cmp arrayh[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalh
cmp arrayi[esi], 'X'
je restart
cmp arrayj[esi], 'X'
je restart 
mov arrayi[esi], 'X'
mov arrayj[esi], 'X'
mov arrayh[esi], 'X'
jmp done
horizontalh:
cmp randValInt, 1
je indexh1
cmp randValInt, 2
je indexh2
cmp randValInt, 3
je indexh3
cmp randValInt, 4
je indexh4
cmp randValInt, 5
je indexh5
cmp randValInt, 6
je indexh6
cmp randValInt, 7
je indexh7
cmp randValInt, 8
je indexh8
cmp randValInt, 9
je indexh9
cmp randValInt, 10
je indexh10 
indexh1:
	mov esi, 2
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 1
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh2:
	mov esi, 3
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 2
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh3:
	mov esi, 4
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 3
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh4:
	mov esi, 5
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 4
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh5:
	mov esi, 6
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 5
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh6:
	mov esi, 7
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 6
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh7:
	mov esi, 8
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 7
	mov arrayh[esi], 'X'
	mov esi, 8
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh8: 
	mov esi, 9
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 8
	mov arrayh[esi], 'X'
	mov esi, 9
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh9:
	mov esi, 8
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 7
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh10: 
	mov esi, 8
	cmp arrayh[esi], 'X'
	je restart
	inc esi 
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 8
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
isI: 
mov edx, offset arrayi
mov esi, 0
mov esi, randValInt
cmp arrayi[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontali
cmp arrayj[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
mov arrayj[esi], 'X'
mov arrayh[esi], 'X'
mov arrayi[esi], 'X'
jmp done
horizontali:
cmp randValInt, 1
je indexi1
cmp randValInt, 2
je indexi2
cmp randValInt, 3
je indexi3
cmp randValInt, 4
je indexi4
cmp randValInt, 5
je indexi5
cmp randValInt, 6
je indexi6
cmp randValInt, 7
je indexi7
cmp randValInt, 8
je indexi8
cmp randValInt, 9
je indexi9
cmp randValInt, 10
je indexi10 
indexi1:
	mov esi, 2
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 1
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi2:
	mov esi, 3
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 2
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi3:
	mov esi, 4
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 3
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi4:
	mov esi, 5
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 4
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi5:
	mov esi, 6
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 5
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi6:
	mov esi, 7
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 6
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi7:
	mov esi, 8
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 7
	mov arrayi[esi], 'X'
	mov esi, 8
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi8: 
	mov esi, 9
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 8
	mov arrayi[esi], 'X'
	mov esi, 9
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi9:
	mov esi, 8
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 7
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi10: 
	mov esi, 8
	cmp arrayi[esi], 'X'
	je restart
	inc esi 
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 8
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
isJ: 
mov edx, offset arrayj
mov esi, 0
mov esi, randValInt
cmp arrayj[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalj
cmp arrayi[esi], 'X'
je restart
cmp arrayh[esi], 'X'
je restart
mov arrayi[esi], 'X'
mov arrayh[esi], 'X'
mov arrayj[esi], 'X'
jmp done
horizontalj:
cmp randValInt, 1
je indexj1
cmp randValInt, 2
je indexj2
cmp randValInt, 3
je indexj3
cmp randValInt, 4
je indexj4
cmp randValInt, 5
je indexj5
cmp randValInt, 6
je indexj6
cmp randValInt, 7
je indexj7
cmp randValInt, 8
je indexj8
cmp randValInt, 9
je indexj9
cmp randValInt, 10
je indexj10 
indexj1:
	mov esi, 2
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 1
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj2:
	mov esi, 3
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 2
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj3:
	mov esi, 4
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 3
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj4:
	mov esi, 5
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 4
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj5:
	mov esi, 6
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 5
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj6:
	mov esi, 7
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 6
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj7:
	mov esi, 8
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 7
	mov arrayj[esi], 'X'
	mov esi, 8
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj8: 
	mov esi, 9
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 8
	mov arrayj[esi], 'X'
	mov esi, 9
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj9:
	mov esi, 8
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 10 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 7
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj10: 
	mov esi, 8
	cmp arrayj[esi], 'X'
	je restart
	inc esi 
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 8
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
done:

call crlf
ret
RandomSub ENDP

;-------------------------------------------------------- Places Patrol Boat ---------------------------------------

RandomPB PROC ;USES EAX EBX ECX EDX ;ESI EDI
restart:
mov al, 10
Call RandomRange
add al, 65
mov randVal, al
call crlf
mov al, 10
Call RandomRange
add eax, 1
mov randValInt, eax
call crlf
cmp randVal, 65
je isA
cmp randVal, 66
je isB
cmp randVal, 67
je isC
cmp randVal, 68
je isD
cmp randVal, 69
je isE
cmp randVal, 70
je isF
cmp randVal, 71
je isG
cmp randVal, 72
je isH
cmp randVal, 73
je isI
cmp randVal, 74
je isJ 
isA: 
mov edx, offset arraya
mov esi, 0
mov esi, randValInt
cmp arraya[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontala
mov esi, randvalint
cmp arrayb[esi], 'X'
je restart
mov arrayb[esi], 'X'
mov arraya[esi], 'X'
jmp done
horizontala:
cmp randValInt, 1
je indexa1
cmp randValInt, 2
je indexa2
cmp randValInt, 3
je indexa3
cmp randValInt, 4
je indexa4
cmp randValInt, 5
je indexa5
cmp randValInt, 6
je indexa6
cmp randValInt, 7
je indexa7
cmp randValInt, 8
je indexa8
cmp randValInt, 9
je indexa9
cmp randValInt, 10
je indexa10 
indexa1:
	mov esi, 2
	cmp arraya[esi], 'X'
	je restart
	mov esi, 1
	mov arraya[esi], 'X'
	inc esi 
	mov arraya[esi], 'X'
	jmp done
indexa2:
	mov esi, 3
	cmp arraya[esi], 'X'
	je restart
	mov esi, 2
	mov arraya[esi], 'X'
	inc esi 
	mov arraya[esi], 'X'
	jmp done
indexa3:
	mov esi, 4
	cmp arraya[esi], 'X'
	je restart
	mov esi, 3
	mov arraya[esi], 'X'
	inc esi 
	mov arraya[esi], 'X'
	jmp done
indexa4:
	mov esi, 5
	cmp arraya[esi], 'X'
	je restart
	mov esi, 4
	mov arraya[esi], 'X'
	inc esi 
	mov arraya[esi], 'X'
	jmp done
indexa5:
	mov esi, 6
	cmp arraya[esi], 'X'
	mov esi, 5
	mov arraya[esi], 'X'
	inc esi 
	mov arraya[esi], 'X'
	jmp done
indexa6:
	mov esi, 7
	cmp arraya[esi], 'X'
	je restart
	mov esi, 6
	mov arraya[esi], 'X'
	inc esi 
	mov arraya[esi], 'X'
	jmp done
indexa7:
	mov esi, 8
	cmp arraya[esi], 'X'
	je restart
	mov esi, 7
	mov arraya[esi], 'X'
	inc esi 
	mov arraya[esi], 'X'
	jmp done
indexa8: 
	mov esi, 9
	cmp arraya[esi], 'X'
	je restart
	mov esi, 8
	mov arraya[esi], 'X'
	inc esi 
	mov arraya[esi], 'X'
	jmp done
indexa9:
	mov esi, 10
	cmp arraya[esi], 'X'
	je restart
	mov esi, 9
	mov arraya[esi], 'X'
	inc esi 
	mov arraya[esi], 'X'
	jmp done
indexa10: 
	mov esi, 9
	cmp arraya[esi], 'X'
	je restart
	mov esi, 9
	mov arraya[esi], 'X'
	inc esi 
	mov arraya[esi], 'X'
	jmp done
isB: 
mov edx, offset arrayb
mov esi, 0
mov esi, randValInt
cmp arrayb[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalb
mov esi, randvalint
cmp arrayc[esi], 'X'
je restart
mov arrayc[esi], 'X'
mov arrayb[esi], 'X'
jmp done
horizontalb:
cmp randValInt, 1
je indexb1
cmp randValInt, 2
je indexb2
cmp randValInt, 3
je indexb3
cmp randValInt, 4
je indexb4
cmp randValInt, 5
je indexb5
cmp randValInt, 6
je indexb6
cmp randValInt, 7
je indexb7
cmp randValInt, 8
je indexb8
cmp randValInt, 9
je indexb9
cmp randValInt, 10
je indexb10 
indexb1:
	mov esi, 2
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 1
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb2:
	mov esi, 3
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 2
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb3:
	mov esi, 4
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 3
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb4:
	mov esi, 5
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 4
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb5:
	mov esi, 6
	cmp arrayb[esi], 'X'
	mov esi, 5
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb6:
	mov esi, 7
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 6
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb7:
	mov esi, 8
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 7
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb8: 
	mov esi, 9
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 8
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb9:
	mov esi, 10
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 9
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
indexb10: 
	mov esi, 9
	cmp arrayb[esi], 'X'
	je restart
	mov esi, 9
	mov arrayb[esi], 'X'
	inc esi
	mov arrayb[esi], 'X'
	jmp done
isC: 
mov edx, offset arrayc
mov esi, 0
mov esi, randValInt
cmp arrayc[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalc
mov esi, randvalint
cmp arrayd[esi], 'X'
je restart
mov arrayd[esi], 'X'
mov arrayc[esi], 'X'
jmp done
horizontalc:
cmp randValInt, 1
je indexc1
cmp randValInt, 2
je indexc2
cmp randValInt, 3
je indexc3
cmp randValInt, 4
je indexc4
cmp randValInt, 5
je indexc5
cmp randValInt, 6
je indexc6
cmp randValInt, 7
je indexc7
cmp randValInt, 8
je indexc8
cmp randValInt, 9
je indexc9
cmp randValInt, 10
je indexc10 
indexc1:
	mov esi, 2
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 1
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc2:
	mov esi, 3
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 2
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc3:
	mov esi, 4
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 3
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc4:
	mov esi, 5
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 4
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc5:
	mov esi, 6
	cmp arrayc[esi], 'X'
	mov esi, 5
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc6:
	mov esi, 7
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 6
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc7:
	mov esi, 8
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 7
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc8: 
	mov esi, 9
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 8
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc9:
	mov esi, 10
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 9
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
indexc10: 
	mov esi, 9
	cmp arrayc[esi], 'X'
	je restart
	mov esi, 9
	mov arrayc[esi], 'X'
	inc esi
	mov arrayc[esi], 'X'
	jmp done
isD: 
mov edx, offset arrayd
mov esi, 0
mov esi, randValInt
cmp arrayd[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontald
mov esi, randvalint
cmp arraye[esi], 'X'
je restart
mov arraye[esi], 'X'
mov arrayd[esi], 'X'
jmp done
horizontald:
cmp randValInt, 1
je indexd1
cmp randValInt, 2
je indexd2
cmp randValInt, 3
je indexd3
cmp randValInt, 4
je indexd4
cmp randValInt, 5
je indexd5
cmp randValInt, 6
je indexd6
cmp randValInt, 7
je indexd7
cmp randValInt, 8
je indexd8
cmp randValInt, 9
je indexd9
cmp randValInt, 10
je indexd10 
indexd1:
	mov esi, 2
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 1
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd2:
	mov esi, 3
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 2
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd3:
	mov esi, 4
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 3
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd4:
	mov esi, 5
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 4
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd5:
	mov esi, 6
	cmp arrayd[esi], 'X'
	mov esi, 5
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd6:
	mov esi, 7
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 6
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd7:
	mov esi, 8
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 7
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd8: 
	mov esi, 9
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 8
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd9:
	mov esi, 10
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 9
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
indexd10: 
	mov esi, 9
	cmp arrayd[esi], 'X'
	je restart
	mov esi, 9
	mov arrayd[esi], 'X'
	inc esi
	mov arrayd[esi], 'X'
	jmp done
isE: 
mov edx, offset arraye
mov esi, 0
mov esi, randValInt
cmp arraye[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontale
mov esi, randvalint
cmp arrayf[esi], 'X'
je restart
mov arrayf[esi], 'X'
mov arraye[esi], 'X'
jmp done
horizontale:
cmp randValInt, 1
je indexe1
cmp randValInt, 2
je indexe2
cmp randValInt, 3
je indexe3
cmp randValInt, 4
je indexe4
cmp randValInt, 5
je indexe5
cmp randValInt, 6
je indexe6
cmp randValInt, 7
je indexe7
cmp randValInt, 8
je indexe8
cmp randValInt, 9
je indexe9
cmp randValInt, 10
je indexe10 
indexe1:
	mov esi, 2
	cmp arraye[esi], 'X'
	je restart
	mov esi, 1
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe2:
	mov esi, 3
	cmp arraye[esi], 'X'
	je restart
	mov esi, 2
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe3:
	mov esi, 4
	cmp arraye[esi], 'X'
	je restart
	mov esi, 3
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe4:
	mov esi, 5
	cmp arraye[esi], 'X'
	je restart
	mov esi, 4
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe5:
	mov esi, 6
	cmp arraye[esi], 'X'
	mov esi, 5
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe6:
	mov esi, 7
	cmp arraye[esi], 'X'
	je restart
	mov esi, 6
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe7:
	mov esi, 8
	cmp arraye[esi], 'X'
	je restart
	mov esi, 7
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe8: 
	mov esi, 9
	cmp arraye[esi], 'X'
	je restart
	mov esi, 8
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe9:
	mov esi, 10
	cmp arraye[esi], 'X'
	je restart
	mov esi, 9
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
indexe10: 
	mov esi, 9
	cmp arraye[esi], 'X'
	je restart
	mov esi, 9
	mov arraye[esi], 'X'
	inc esi
	mov arraye[esi], 'X'
	jmp done
isF: 
mov edx, offset arrayf
mov esi, 0
mov esi, randValInt
cmp arrayf[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalf
mov esi, randvalint
cmp arrayg[esi], 'X'
je restart
mov arrayg[esi], 'X'
mov arrayf[esi], 'X'
jmp done
horizontalf:
cmp randValInt, 1
je indexf1
cmp randValInt, 2
je indexf2
cmp randValInt, 3
je indexf3
cmp randValInt, 4
je indexf4
cmp randValInt, 5
je indexf5
cmp randValInt, 6
je indexf6
cmp randValInt, 7
je indexf7
cmp randValInt, 8
je indexf8
cmp randValInt, 9
je indexf9
cmp randValInt, 10
je indexf10 
indexf1:
	mov esi, 2
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 1
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf2:
	mov esi, 3
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 2
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf3:
	mov esi, 4
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 3
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf4:
	mov esi, 5
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 4
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf5:
	mov esi, 6
	cmp arrayf[esi], 'X'
	mov esi, 5
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf6:
	mov esi, 7
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 6
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf7:
	mov esi, 8
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 7
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf8: 
	mov esi, 9
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 8
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf9:
	mov esi, 10
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 9
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
indexf10: 
	mov esi, 9
	cmp arrayf[esi], 'X'
	je restart
	mov esi, 9
	mov arrayf[esi], 'X'
	inc esi
	mov arrayf[esi], 'X'
	jmp done
isG: 
mov edx, offset arrayg
mov esi, 0
mov esi, randValInt
cmp arrayg[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalg
mov esi, randvalint
cmp arrayh[esi], 'X'
je restart
mov arrayh[esi], 'X'
mov arrayg[esi], 'X'
jmp done
horizontalg:
cmp randValInt, 1
je indexg1
cmp randValInt, 2
je indexg2
cmp randValInt, 3
je indexg3
cmp randValInt, 4
je indexg4
cmp randValInt, 5
je indexg5
cmp randValInt, 6
je indexg6
cmp randValInt, 7
je indexg7
cmp randValInt, 8
je indexg8
cmp randValInt, 9
je indexg9
cmp randValInt, 10
je indexg10 
indexg1:
	mov esi, 2
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 1
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg2:
	mov esi, 3
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 2
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg3:
	mov esi, 4
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 3
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg4:
	mov esi, 5
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 4
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg5:
	mov esi, 6
	cmp arrayg[esi], 'X'
	mov esi, 5
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg6:
	mov esi, 7
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 6
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg7:
	mov esi, 8
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 7
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg8: 
	mov esi, 9
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 8
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg9:
	mov esi, 10
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 9
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
indexg10: 
	mov esi, 9
	cmp arrayg[esi], 'X'
	je restart
	mov esi, 9
	mov arrayg[esi], 'X'
	inc esi
	mov arrayg[esi], 'X'
	jmp done
isH: 
mov edx, offset arrayh
mov esi, 0
mov esi, randValInt
cmp arrayh[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalh
mov esi, randvalint
cmp arrayi[esi], 'X'
je restart
mov arrayh[esi], 'X'
mov arrayi[esi], 'X'
jmp done
horizontalh:
cmp randValInt, 1
je indexh1
cmp randValInt, 2
je indexh2
cmp randValInt, 3
je indexh3
cmp randValInt, 4
je indexh4
cmp randValInt, 5
je indexh5
cmp randValInt, 6
je indexh6
cmp randValInt, 7
je indexh7
cmp randValInt, 8
je indexh8
cmp randValInt, 9
je indexh9
cmp randValInt, 10
je indexh10 
indexh1:
	mov esi, 2
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 1
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh2:
	mov esi, 3
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 2
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh3:
	mov esi, 4
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 3
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh4:
	mov esi, 5
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 4
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh5:
	mov esi, 6
	cmp arrayh[esi], 'X'
	mov esi, 5
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh6:
	mov esi, 7
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 6
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh7:
	mov esi, 8
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 7
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh8: 
	mov esi, 9
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 8
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh9:
	mov esi, 10
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 9
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
indexh10: 
	mov esi, 9
	cmp arrayh[esi], 'X'
	je restart
	mov esi, 9
	mov arrayh[esi], 'X'
	inc esi
	mov arrayh[esi], 'X'
	jmp done
isI: 
mov edx, offset arrayi
mov esi, 0
mov esi, randValInt
cmp arrayi[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontali
mov esi, randvalint
cmp arrayj[esi], 'X'
je restart
mov arrayj[esi], 'X'
mov arrayi[esi], 'X'
jmp done
horizontali:
cmp randValInt, 1
je indexi1
cmp randValInt, 2
je indexi2
cmp randValInt, 3
je indexi3
cmp randValInt, 4
je indexi4
cmp randValInt, 5
je indexi5
cmp randValInt, 6
je indexi6
cmp randValInt, 7
je indexi7
cmp randValInt, 8
je indexi8
cmp randValInt, 9
je indexi9
cmp randValInt, 10
je indexi10 
indexi1:
	mov esi, 2
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 1
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi2:
	mov esi, 3
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 2
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi3:
	mov esi, 4
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 3
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi4:
	mov esi, 5
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 4
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi5:
	mov esi, 6
	cmp arrayi[esi], 'X'
	mov esi, 5
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi6:
	mov esi, 7
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 6
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi7:
	mov esi, 8
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 7
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi8: 
	mov esi, 9
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 8
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi9:
	mov esi, 10
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 9
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
indexi10: 
	mov esi, 9
	cmp arrayi[esi], 'X'
	je restart
	mov esi, 9
	mov arrayi[esi], 'X'
	inc esi
	mov arrayi[esi], 'X'
	jmp done
isJ: 
mov edx, offset arrayj
mov esi, 0
mov esi, randValInt
cmp arrayj[esi], 'X'
je restart
call oneorzero
cmp var1, 1
je horizontalj
mov esi, randvalint
cmp arrayi[esi], 'X'
je restart
mov arrayi[esi], 'X'
mov arrayj[esi], 'X'
jmp done
horizontalj:
cmp randValInt, 1
je indexj1
cmp randValInt, 2
je indexj2
cmp randValInt, 3
je indexj3
cmp randValInt, 4
je indexj4
cmp randValInt, 5
je indexj5
cmp randValInt, 6
je indexj6
cmp randValInt, 7
je indexj7
cmp randValInt, 8
je indexj8
cmp randValInt, 9
je indexj9
cmp randValInt, 10
je indexj10 
indexj1:
	mov esi, 2
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 1
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj2:
	mov esi, 3
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 2
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj3:
	mov esi, 4
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 3
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj4:
	mov esi, 5
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 4
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj5:
	mov esi, 6
	cmp arrayj[esi], 'X'
	mov esi, 5
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj6:
	mov esi, 7
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 6
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj7:
	mov esi, 8
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 7
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj8: 
	mov esi, 9
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 8
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj9:
	mov esi, 10
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 9
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
indexj10: 
	mov esi, 9
	cmp arrayj[esi], 'X'
	je restart
	mov esi, 9
	mov arrayj[esi], 'X'
	inc esi
	mov arrayj[esi], 'X'
	jmp done
done:
call crlf
ret
RandomPB ENDP


;-------------------------------------------------------- Checks for a One or Zero ---------------------------------------------------------------------

oneorzero PROC ;USES EAX EBX ECX EDX ;ESI EDI
mov al, 2
call RandomRange
mov var1, eax
ret
oneorzero endp

;-------------------------------------------------------- Writes Front End Board ---------------------------------------------------------------------

WriteBoardv2 PROC USES EAX EBX ECX EDX ;ESI EDI

;Prints Top Row
mov eax,restcolor
call settextcolor
mov esi,0
mov esi, offset arrayTop
mov ecx, sizeof arrayTop
Call writestringDisplay
Call CRLF

;Prints A Row
mov esi,0
mov esi, offset arrayADisp
mov ecx, sizeof arrayAdisp
Call writestringDisplay
Call CRLF

;Prints B Row
mov esi,0
mov esi, offset arrayBdisp
mov ecx, sizeof arrayBdisp
Call writestringDisplay
Call CRLF

;Prints C Row
mov esi,0
mov esi, offset arrayCDisp
mov ecx, sizeof arrayCDisp
Call writestringDisplay
Call CRLF

;Prints D Row
mov esi,0
mov esi, offset arrayDDisp
mov ecx, sizeof arrayDDisp
Call writestringDisplay
Call CRLF

;Prints E Row
mov esi,0
mov esi, offset arrayEDisp
mov ecx, sizeof arrayEDisp
Call writestringDisplay
Call CRLF

;Prints F Row
mov esi,0
mov esi, offset arrayFDisp
mov ecx, sizeof arrayFDisp
Call writestringDisplay
Call CRLF

;Prints G Row
mov esi,0
mov esi, offset arrayGDisp
mov ecx, sizeof arrayGDisp
Call writestringDisplay
Call CRLF

;Prints H Row
mov esi,0
mov esi, offset arrayHDisp
mov ecx, sizeof arrayHDisp
Call writestringDisplay
Call CRLF

;Prints I Row
mov esi,0
mov esi, offset arrayIDisp
mov ecx, sizeof arrayIDisp
Call writestringDisplay
Call CRLF

;Prints J Row
mov esi,0
mov esi, offset arrayJDisp
mov ecx, sizeof arrayJDisp
call writestringDisplay

Call CRLF

ret
WriteBoardv2 endp

;-------------------------------------------------------- Checks Game State ---------------------------------------------------------------------

CheckHitCounter PROC USES eax ebx ecx edx

mov al, hitCounter
cmp al, 17
je GameOver
jne KeepGoing

GameOver:
	call WriteBoardv2
	Call CRLF
	mov edx, offset messageEnd
	Call WriteString
	Call CRLF
	mov edx, offset messageScore
	Call WriteString
	mov al, score
	Call WriteDec
	invoke PlaySound, OFFSET churchill, NULL, SND_FILENAME or SND_ASYNC
	Call CRLF
	Call CRLF
	Call ReplayCheck

KeepGoing:
	Call CRLF
ret
CheckHitCounter endp

;------------------------------------------------ Our Writestring Proc ----------------------------------------------------------

WriteString2 proc uses eax ebx edx
Write:
mov al, [esi]
	cmp al,'-'
	jne NotBlue
	mov eax,lightblue(lightgray*16)
	call SetTextColor
	jmp Print
	NotBlue:
	cmp al,'X'
	jne NotRed
	mov eax,lightred(lightgray*16)
	call settextcolor
	jmp Print
	NotRed:
	cmp al,'O'
	jne NotYellow
	mov eax,yellow(lightgray*16)
	call settextcolor
	jmp Print
	NotYellow:
	mov eax,restcolor
	call settextcolor
	jmp Print
	Print:
	mov al,[esi]
	Call WriteChar
	inc esi
	mov eax,restcolor
	call settextcolor
Loop Write

ret
writestring2 endp

;------------------------------------------------ Our Writestring Proc for the board ----------------------------------------------------------

writestringDisplay proc uses eax ebx edx
mov eax,0
Write2:
mov al, [esi]
	cmp al,'-'
	jne NotBlue
	mov eax,lightblue(lightgray*16)
	call SetTextColor
	jmp Print
	NotBlue:
	cmp al,'X'
	jne NotRed
	mov eax,lightred(lightgray*16)
	call settextcolor
	jmp Print
	NotRed:
	cmp al,'O'
	jne NotYellow
	mov eax,yellow(lightgray*16)
	call settextcolor
	jmp Print
	NotYellow:
	mov eax,restcolor
	call settextcolor
	jmp Print
	Print:
	mov al,[esi]
	Call WriteChar
	inc esi
	mov al,' '
	call writechar
	mov eax,restcolor
	call settextcolor
Loop Write2
ret
writestringDisplay endp

;------------------------------------------------ Replay Check ----------------------------------------------------------
ReplayCheck PROC
Call CRLF
PUSH eax
mov edx, offset replaymes
Call WriteString
Call ReadChar
cmp al, 'Y'
je isY
jne notY

isY:
	Call homescreen

notY:
	cmp al, 'y'
	je islily
	jne notYory

islilY:
	Call homescreen

notYory:
	cmp al, 'N'
	je isN
	jne notN

isN:
	exit

notN:
	cmp al, 'n'
	je isN
	jne notNorn

notNorn:
	Call CRLF
	mov edx, offset invalidReplay
	Call WriteString
	Call ReplayCheck

POP eax
ret
ReplayCheck endp

END main