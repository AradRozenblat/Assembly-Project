.486 ; create 32 bit code
.model flat, stdcall ; 32 bit memory model
option casemap :none ; case sensitive

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc
include \masm32\include\Advapi32.inc
include \masm32\include\winmm.inc
includelib \masm32\lib\winmm.lib
include \masm32\include\dialogs.inc ;macro file for dialogs
include \masm32\macros\macros.asm ;masm32 macro file
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\Comctl32.lib
includelib \masm32\lib\comdlg32.lib
includelib \masm32\lib\shell32.lib
includelib \masm32\lib\oleaut32.lib
includelib \masm32\lib\ole32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\include\msvcrt.inc
include \masm32\include\Ws2_32.inc
includelib \masm32\lib\Ws2_32.lib

.const
MAIN_TIMER_ID equ 0

RIGHT equ 1
DOWN equ 2
LEFT equ 3
UP	equ 4
STOP equ 5

FACING1 equ 3
FACING2 equ 1
VERTICAL1 equ 0
HORIZONTAL1 equ 1
VERTICAL2 equ 0
HORIZONTAL2 equ 1

GAME equ 1
SETTINGS equ 2
MAINMENU equ 3
COLOR equ 4
UNMUTEBUTTON equ 5
LOCALGAME equ 6
ONLINEGAME equ 7
PAUSING equ 8
ENDING equ 9
EXITING equ 10
HELPING equ 11
CREDITS equ 12
AUDIO equ 13
GRAPHICS equ 14
NEWGAMEBUTTON equ 15
MAINMENUBUTTON equ 16
BACKBUTTON equ 17
SETTINGSBUTTON equ 18
AUDIOBUTTON equ 19
GRAPHICSBUTTON equ 20
RESUMEBUTTON equ 21
HELPBUTTON equ 22
CREDITSBUTTON equ 23
EXITBUTTON equ 24
BIGHIGHLIGHT equ 25
VOLUMEBAR equ 26
SELECTOR equ 27
MUTEBUTTON equ 28
MUSICBUTTON equ 29
SFXBUTTON equ 30
RESIZEBUTTON equ 31
TRACKBUTTON equ 32
COLORSBUTTON equ 33
IMAGEBUTTON equ 34
GAME1 equ 35
GAME2 equ 36
GAME3 equ 37
GAME4 equ 38
GAME5 equ 39
GAME6 equ 40

COUNTGO equ 50
COUNT1 equ 51
COUNT2 equ 52
COUNT3 equ 53
COUNT4 equ 54
COUNT5 equ 55

ONBUTTON equ 56
OFFBUTTON equ 57
VOLUMEBUTTON equ 58
SMALLHIGHLIGHT equ 59
TIE equ 60
P1WINS equ 61
P2WINS equ 62
SINGLEGAME equ 63
WIN equ 64
LOSE equ 65

REG1 equ 1
DARK1 equ 3
LIGHT1 equ 5
REG2 equ 2
DARK2 equ 4
LIGHT2 equ 6

BOOSTS1 equ 3
BOOSTS2 equ 3

WINWIDTH equ 1000

WM_SOCKET equ WM_USER+100
TILES equ 20

.data

Player STRUCT
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	id db ?
	color dd ?
	x dd ?
	y dd ?
	speed dd ?
	facing dd ?
	vertical db ?
	horizontal db ?
	boosts db ?
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Player ENDS

WinWidth DWORD WINWIDTH
WinHeight DWORD ?
RealWidth DWORD ?
RealHeight DWORD ?

Color1 DWORD 000000ff0000h
Color2 DWORD 0000000000ffh
Darker1 DWORD ?
Darker2 DWORD ?
Lighter1 DWORD ?
Lighter2 DWORD ?
P1 Player <1, Color1, ?, ?, ?, FACING1, VERTICAL1, HORIZONTAL1, BOOSTS1>
P2 Player <2, Color2, ?, ?, ?, FACING2, VERTICAL2, HORIZONTAL2, BOOSTS2>
Me Player <?, ?, ?, ?, ?, ?, ?, ?, ?>
MyLastKey DWORD ?
MyNowKey DWORD ?
MyLastKeyTime DWORD ?
MyNowKeyTime DWORD ?
MyBoostTime DWORD ?
MyBoostTiles DWORD ?
MySlowTime DWORD ?
MyLastMoveTime DWORD ?

ClassName DB "TheClass", 0
windowTitle DB "TRON: REASSEMBLED", 0
backupecx	DWORD	?
grid DB 100*75 dup(0)
SettingsBMH HBITMAP ?
MainMenuBMH HBITMAP ?
PausingBMH HBITMAP ?
EndingBMH HBITMAP ?
ColorBMH HBITMAP ?
ExitingBMH HBITMAP ?
HelpingBMH HBITMAP ?
CreditsBMH HBITMAP ?
AudioBMH HBITMAP ?
GraphicsBMH HBITMAP ?
GameBMH HBITMAP ?
NewGameButtonBMH HBITMAP ?
NewGameButtonMaskBMH HBITMAP ?
MainMenuButtonBMH HBITMAP ?
MainMenuButtonMaskBMH HBITMAP ?
BackButtonBMH HBITMAP ?
BackButtonMaskBMH HBITMAP ?
SettingsButtonBMH HBITMAP ?
SettingsButtonMaskBMH HBITMAP ?
AudioButtonBMH HBITMAP ?
AudioButtonMaskBMH HBITMAP ?
GraphicsButtonBMH HBITMAP ?
GraphicsButtonMaskBMH HBITMAP ?
ResumeButtonBMH HBITMAP ?
ResumeButtonMaskBMH HBITMAP ?
HelpButtonBMH HBITMAP ?
HelpButtonMaskBMH HBITMAP ?
CreditsButtonBMH HBITMAP ?
CreditsButtonMaskBMH HBITMAP ?
ExitButtonBMH HBITMAP ?
ExitButtonMaskBMH HBITMAP ?
MuteButtonBMH HBITMAP ?
MuteButtonMaskBMH HBITMAP ?
UnmuteButtonBMH HBITMAP ?
UnmuteButtonMaskBMH HBITMAP ?
MusicButtonBMH HBITMAP ?
MusicButtonMaskBMH HBITMAP ?
SFXButtonBMH HBITMAP ?
SFXButtonMaskBMH HBITMAP ?
ResizeButtonBMH HBITMAP ?
ResizeButtonMaskBMH HBITMAP ?
TrackButtonBMH HBITMAP ?
TrackButtonMaskBMH HBITMAP ?
ColorsButtonBMH HBITMAP ?
ColorsButtonMaskBMH HBITMAP ?
ImageButtonBMH HBITMAP ?
ImageButtonMaskBMH HBITMAP ?
BigHighlightBMH HBITMAP ?
BigHighlightMaskBMH HBITMAP ?
SmallHighlightBMH HBITMAP ?
SmallHighlightMaskBMH HBITMAP ?
AudioGifBMH HBITMAP ?
VolumeBarBMH HBITMAP ?
VolumeBarMaskBMH HBITMAP ?
VolumeButtonBMH HBITMAP ?
VolumeButtonMaskBMH HBITMAP ?
OnButtonBMH HBITMAP ?
OnButtonMaskBMH HBITMAP ?
OffButtonBMH HBITMAP ?
OffButtonMaskBMH HBITMAP ?
LocalButtonBMH HBITMAP ?
LocalButtonMaskBMH HBITMAP ?
OnlineButtonBMH HBITMAP ?
OnlineButtonMaskBMH HBITMAP ?
SingleButtonBMH HBITMAP ?
SingleButtonMaskBMH HBITMAP ?
P1WinsBMH HBITMAP ?
P1WinsMaskBMH HBITMAP ?
P2WinsBMH HBITMAP ?
P2WinsMaskBMH HBITMAP ?
TieBMH HBITMAP ?
TieMaskBMH HBITMAP ?
YouLoseBMH HBITMAP ?
YouLoseMaskBMH HBITMAP ?
YouWinBMH HBITMAP ?
YouWinMaskBMH HBITMAP ?
Count1BMH HBITMAP ?
Count1MaskBMH HBITMAP ?
Count2BMH HBITMAP ?
Count2MaskBMH HBITMAP ?
Count3BMH HBITMAP ?
Count3MaskBMH HBITMAP ?
Count4BMH HBITMAP ?
Count4MaskBMH HBITMAP ?
Count5BMH HBITMAP ?
Count5MaskBMH HBITMAP ?
CountGoBMH HBITMAP ?
CountGoMaskBMH HBITMAP ?

SelectorBMH HBITMAP ?
SelectorMaskBMH HBITMAP ?
CurrentBMH HBITMAP ?
status DWORD MAINMENU
laststatus DWORD ?
LastKey1 DWORD ?
LastKey2 DWORD ?
NowKey1 DWORD ?
NowKey2 DWORD ?
LastKeyTime1 DWORD ?
LastKeyTime2 DWORD ?
NowKeyTime1 DWORD ?
NowKeyTime2 DWORD ?
BoostTime1 DWORD ?
BoostTime2 DWORD ?
BoostTiles1 DWORD ?
BoostTiles2 DWORD ?
SlowTime1 DWORD ?
SlowTime2 DWORD ?
LastMoveTime1 DWORD ?
LastMoveTime2 DWORD ?
LastFrameTime DWORD ?
NowFrameTime DWORD ?
Frame DWORD 1
Selected DWORD 1
Image DWORD 1

SelectorX DWORD ?
Volume DWORD 0FFFFh
BackupVolume DWORD ?
SFX DWORD 1
BackupSFX DWORD ?
Music DWORD 1
BackupMusic DWORD ?
Track DWORD 1

Game1BMH HBITMAP ?
Game2BMH HBITMAP ?
Game3BMH HBITMAP ?
Game4BMH HBITMAP ?
Game5BMH HBITMAP ?
Game6BMH HBITMAP ?

CoolTime DWORD ?
MouseX DWORD ?
MouseY DWORD ?
W1Eighth DWORD ?
W2Eighth DWORD ?
W4Eighth DWORD ?
W5Eighth DWORD ?
W6Eighth DWORD ?
H1Quarter DWORD ?
H2Quarter DWORD ?
H1Tenth DWORD ?
H2Tenth DWORD ?
H3Tenth DWORD ?
H4Tenth DWORD ?
H5Tenth DWORD ?
H6Tenth DWORD ?
H7Tenth DWORD ?
H8Tenth DWORD ?
H9Tenth DWORD ?
X1 DWORD ?
Y1 DWORD ?
X2 DWORD ?
Y2 DWORD ?
MyD DWORD ?

Slow DWORD ?
Speed DWORD ?
Boost DWORD ?
CountDown DWORD ?
CountTime DWORD ?

Winner DWORD ?
hWnd HWND ?

playTheSonOfFlynn BYTE "play TheSonOfFlynn.mp3 repeat",0
pauseTheSonOfFlynn BYTE "pause TheSonOfFlynn.mp3",0
resumeTheSonOfFlynn BYTE "resume TheSonOfFlynn.mp3",0
stopTheSonOfFlynn BYTE "stop TheSonOfFlynn.mp3",0
playTheGameHasChanged BYTE "play TheGameHasChanged.mp3 repeat",0
pauseTheGameHasChanged BYTE "pause TheGameHasChanged.mp3",0
resumeTheGameHasChanged BYTE "resume TheGameHasChanged.mp3",0
stopTheGameHasChanged BYTE "stop TheGameHasChanged.mp3",0
playDerezzed BYTE "play Derezzed.mp3 repeat",0
pauseDerezzed BYTE "pause Derezzed.mp3",0
resumeDerezzed BYTE "resume Derezzed.mp3",0
stopDerezzed BYTE "stop Derezzed.mp3",0
playOutlands BYTE "play Outlands.mp3 repeat",0
pauseOutlands BYTE "pause Outlands.mp3",0
resumeOutlands BYTE "resume Outlands.mp3",0
stopOutlands BYTE "stop Outlands.mp3",0
playRinzler BYTE "play Rinzler.mp3 repeat",0
pauseRinzler BYTE "pause Rinzler.mp3",0
resumeRinzler BYTE "resume Rinzler.mp3",0
stopRinzler BYTE "stop Rinzler.mp3",0
playEndOfLine BYTE "play EndOfLine.mp3 repeat",0
pauseEndOfLine BYTE "pause EndOfLine.mp3",0
resumeEndOfLine BYTE "resume EndOfLine.mp3",0
stopEndOfLine BYTE "stop EndOfLine.mp3",0
playApplause BYTE "play Applause.mp3",0
stopApplause BYTE "stop Applause.mp3",0
playBoost BYTE "play Boost.mp3",0
stopBoost BYTE "stop Boost.mp3",0
playTurn BYTE "play Turn.mp3",0
stopTurn BYTE "stop Turn.mp3",0
playCountdown BYTE "play Countdown.mp3",0
stopCountdown BYTE "stop Countdown.mp3",0

laststeps DB TILES*3 dup (-1)
sin sockaddr_in <>
clientsin sockaddr_in <>
IPAddress db "212.179.222.94",0 
Port dd 30001	
text db "placeholder",0
textoffset DWORD ?
pleaseconnectus db "please connect us!!!",0
doyouwanttoconnect db "Yes do you want to connect with your friend?",0
yesiamsure db "yes i am sure",0
get_ready_for_ip db "Get ready for IP.",0
expecting_IP db FALSE
expecting_PORT db FALSE
wsadata WSADATA <>
clientip db 20 dup(0)
clientport dd 0
infobuffer DB (TILES*3) dup(-1)
buffer_for_sock db 1024 dup(0)
available_data db 100 dup(0)	; the amount of data available from the socket 
actual_data_read db 100 dup(0)	; the actual amount of data read from the socket 
connected_to_peer db FALSE
sock DWORD ?
captionyesiwanttoconnect db 'yes i am sure',0

.code

sendLocation PROC, uselessparameter:DWORD
;----------------------------------------------------------------------------
again:
	mov ebx, offset laststeps
	mov edx, offset infobuffer
	invoke RtlMoveMemory, offset infobuffer, offset laststeps, sizeof laststeps
	invoke sendto, sock, offset infobuffer, sizeof infobuffer, 0, offset clientsin, sizeof clientsin
	invoke Sleep,10
	jmp again
	ret
;============================================================================
sendLocation ENDP

StopMusic PROC
;--------------------------------------------------------------------------------
	cmp Track, 1
	je stoptrack1
	cmp Track, 2
	je stoptrack2
	cmp Track, 3
	je stoptrack3
	cmp Track, 4
	je stoptrack4
	cmp Track, 5
	je stoptrack5
	ret
stoptrack1:
	invoke mciSendString, offset stopTheSonOfFlynn, NULL, NULL, NULL
	ret
stoptrack2:
	invoke mciSendString, offset stopTheGameHasChanged, NULL, NULL, NULL
	ret
stoptrack3:
	invoke mciSendString, offset stopOutlands, NULL, NULL, NULL
	ret
stoptrack4:
	invoke mciSendString, offset stopRinzler, NULL, NULL, NULL
	ret
stoptrack5:
	invoke mciSendString, offset stopEndOfLine, NULL, NULL, NULL
	ret
;================================================================================
StopMusic ENDP

StopSFX PROC
;--------------------------------------------------------------------------------
	invoke mciSendString, offset stopApplause, NULL, NULL, NULL
	invoke mciSendString, offset stopCountdown, NULL, NULL, NULL
	invoke mciSendString, offset stopBoost, NULL, NULL, NULL
	invoke Sleep, 1500
	ret
;================================================================================
StopSFX ENDP

PlayMusic PROC
;--------------------------------------------------------------------------------
	cmp Track, 1
	je playtrack1
	cmp Track, 2
	je playtrack2
	cmp Track, 3
	je playtrack3
	cmp Track, 4
	je playtrack4
	cmp Track, 5
	je playtrack5
	ret
playtrack1:
	invoke mciSendString, offset playTheSonOfFlynn, NULL, NULL, NULL
	ret
playtrack2:
	invoke mciSendString, offset playTheGameHasChanged, NULL, NULL, NULL
	ret
playtrack3:
	invoke mciSendString, offset playOutlands, NULL, NULL, NULL
	ret
playtrack4:
	invoke mciSendString, offset playRinzler, NULL, NULL, NULL
	ret
playtrack5:
	invoke mciSendString, offset playEndOfLine, NULL, NULL, NULL
	ret
;================================================================================
PlayMusic ENDP

ChangeTrack PROC
;--------------------------------------------------------------------------------
	inc Track
	cmp Track, 5
	jg looptrack
	ret
looptrack:
	mov eax, 1
	mov Track, eax
	ret
;================================================================================
ChangeTrack ENDP

ResizeWindow PROC, newwidth:DWORD, newheight:DWORD
;--------------------------------------------------------------------------------
	invoke DestroyWindow, hWnd
	mov eax, newwidth
	add eax, 15
	mov ebx, newheight
	add ebx, 40
	invoke CreateWindowExA, WS_EX_COMPOSITED, addr ClassName, addr windowTitle, WS_SYSMENU, 0, 0, eax, ebx, 0, 0, 0, 0 ;Create the window
	mov hWnd, eax ;Save the handle
	invoke ShowWindow, eax, SW_SHOW ;Show it
	invoke SetTimer, hWnd, MAIN_TIMER_ID, 20, NULL ;Set the repaint timer
	ret
;================================================================================
ResizeWindow ENDP

CheckMouse PROC, mousex:DWORD, mousey:DWORD, buttonx:DWORD, buttony:DWORD, buttonw:DWORD, buttonh:DWORD
;--------------------------------------------------------------------------------
	mov eax, mousex
	cmp eax, buttonx
	jl nohover
	mov eax, buttonx
	add eax, buttonw
	cmp mousex, eax
	jg nohover
	mov eax, mousey
	cmp eax, buttony
	jl nohover
	mov eax, buttony
	add eax, buttonh
	cmp mousey, eax
	jg nohover
hover:
	mov eax, 1
	ret
nohover:
	mov eax, 0
	ret
;================================================================================
CheckMouse ENDP

Scale PROC, w:DWORD
;--------------------------------------------------------------------------------
	mov eax, w
	mov ebx, 100
	xor edx, edx
	div ebx
	mov MyD, eax
	mov Speed, eax
	mov ebx, 2
	mul ebx
	mov Boost, eax
	xor edx, edx
	div ebx
	xor edx, edx
	div ebx
	mov Slow, eax
	mov eax, w
	mov ebx, 2
	mov WinWidth, eax
	mov ecx, eax
	add ecx, 15
	mov RealWidth, ecx
	xor edx, edx
	div ebx
	mov W4Eighth, eax
	xor edx, edx
	div ebx
	mov W2Eighth, eax
	xor edx, edx
	div ebx
	mov W1Eighth, eax
	mov eax, W4Eighth
	add eax, W1Eighth
	mov W5Eighth, eax
	add eax, W1Eighth
	mov W6Eighth, eax
	mov eax, w
	mov ebx, 3
	xor edx, edx
	mul ebx
	mov ebx, 4
	xor edx, edx
	div ebx
	mov WinHeight, eax
	mov ecx, eax
	add ecx, 40
	mov RealHeight, ecx
	mov ebx, 2
	xor edx, edx
	div ebx
	mov H2Quarter, eax
	xor edx, edx
	div ebx
	mov H1Quarter, eax
	mov eax, WinHeight
	mov ebx, 10
	xor edx, edx
	div ebx
	mov H1Tenth, eax
	mov ebx, 2
	mul ebx
	mov H2Tenth, eax
	xor edx, edx
	div ebx
	mov ebx, 3
	mul ebx
	mov H3Tenth, eax
	xor edx, edx
	div ebx
	mov ebx, 4
	mul ebx
	mov H4Tenth, eax
	xor edx, edx
	div ebx
	mov ebx, 5
	mul ebx
	mov H5Tenth, eax
	xor edx, edx
	div ebx
	mov ebx, 6
	mul ebx
	mov H6Tenth, eax
	xor edx, edx
	div ebx
	mov ebx, 7
	mul ebx
	mov H7Tenth, eax
	xor edx, edx
	div ebx
	mov ebx, 8
	mul ebx
	mov H8Tenth, eax
	xor edx, edx
	div ebx
	mov ebx, 9
	mul ebx
	mov H9Tenth, eax

	mov eax, WinWidth
	mov ebx, MyD
	xor edx, edx
	div ebx
	mov ebx, 4
	xor edx, edx
	div ebx
	mov X2, eax
	mov ebx, 3
	imul ebx
	mov X1, eax

	mov eax, WinHeight
	mov ebx, MyD
	xor edx, edx
	div ebx
	mov ebx, 2
	xor edx, edx
	div ebx
	mov Y1, eax
	mov Y2, eax
	invoke ResizeWindow, WinWidth, WinHeight
	ret
;================================================================================
Scale ENDP

ChangeImage PROC
;--------------------------------------------------------------------------------
	inc Image
	cmp Image, 6
	jle changeimage
loopimage:
	mov eax, 1
	mov Image, eax
changeimage:
	cmp Image, 1
	je image1
	cmp Image, 2
	je image2
	cmp Image, 3
	je image3
	cmp Image, 4
	je image4
	cmp Image, 5
	je image5
	cmp Image, 6
	je image6
	ret
image1:
	mov eax, Game1BMH
	mov CurrentBMH, eax
	ret
image2:
	mov eax, Game2BMH
	mov CurrentBMH, eax
	ret
image3:
	mov eax, Game3BMH
	mov CurrentBMH, eax
	ret
image4:
	mov eax, Game4BMH
	mov CurrentBMH, eax
	ret
image5:
	mov eax, Game5BMH
	mov CurrentBMH, eax
	ret
image6:
	mov eax, Game6BMH
	mov CurrentBMH, eax
	ret
;================================================================================
ChangeImage ENDP

DrawImage_WithMask PROC, hdc:HDC, img:HBITMAP, maskedimg:HBITMAP, destx:DWORD, desty:DWORD, srcx:DWORD, srcy:DWORD, destw:DWORD, desth:DWORD, srcw:DWORD, srch:DWORD
;--------------------------------------------------------------------------------
local hdcMem:HDC
local HOld:HDC
	invoke CreateCompatibleDC, hdc
	mov hdcMem, eax
	invoke SelectObject, hdcMem, maskedimg
	invoke SetStretchBltMode, hdc, COLORONCOLOR
	invoke StretchBlt , hdc, destx, desty, destw, desth, hdcMem, srcx, srcy, srcw, srch, SRCAND
	
	invoke SelectObject, hdcMem, img
	invoke StretchBlt , hdc, destx, desty, destw, desth, hdcMem, srcx, srcy, srcw, srch, SRCPAINT
	invoke DeleteDC, hdcMem
	ret
;================================================================================
DrawImage_WithMask ENDP

DrawImage PROC, hdc:HDC, img:HBITMAP, destx:DWORD, desty:DWORD, srcx:DWORD, srcy:DWORD, destw:DWORD, desth:DWORD, srcw:DWORD, srch:DWORD
;--------------------------------------------------------------------------------
local hdcMem:HDC
local HOld:HBITMAP
	invoke CreateCompatibleDC, hdc
	mov hdcMem, eax
	invoke SelectObject, hdcMem, img
	mov HOld, eax
	invoke SetStretchBltMode, hdc, COLORONCOLOR
	invoke StretchBlt, hdc, destx, desty, destw, desth, hdcMem, srcx, srcy, srcw, srch, SRCCOPY
	invoke SelectObject, hdcMem, HOld
	invoke DeleteDC, hdcMem 
	invoke DeleteObject, HOld
	ret
;================================================================================
DrawImage ENDP

Get_Handle_To_Mask_Bitmap PROC, hbmColour:HBITMAP, crTransparent:COLORREF
;--------------------------------------------------------------------------------
local hdcMem:HDC
local hdcMem2:HDC
local hbmMask:HBITMAP
local bm:BITMAP
local hold:HBITMAP
local hold2:HBITMAP
	invoke GetObject, hbmColour, SIZEOF(BITMAP), addr bm
	invoke CreateBitmap, bm.bmWidth, bm.bmHeight, 1, 1, NULL
	mov hbmMask, eax
	invoke CreateCompatibleDC, NULL
	mov hdcMem, eax
	invoke CreateCompatibleDC, NULL
	mov hdcMem2, eax
	invoke SelectObject, hdcMem, hbmColour
	invoke SelectObject, hdcMem2, hbmMask
	invoke SetBkColor, hdcMem, crTransparent
	invoke BitBlt, hdcMem2, 0, 0, bm.bmWidth, bm.bmHeight, hdcMem, 0, 0, SRCCOPY
	invoke BitBlt, hdcMem, 0, 0, bm.bmWidth, bm.bmHeight, hdcMem2, 0, 0, SRCINVERT
	invoke DeleteDC, hdcMem
	invoke DeleteDC, hdcMem2
	mov eax, hbmMask
	ret
;================================================================================
Get_Handle_To_Mask_Bitmap ENDP

DrawBG PROC, mystatus:DWORD, myrect:RECT, hdc:HDC, myhWnd:HWND
;----------------------------------------------------------------------------
	local OldHandle:HBITMAP

	cmp mystatus, GAME
	je gamedraw
	cmp mystatus, LOCALGAME
	je localdraw
	cmp mystatus, ONLINEGAME
	je onlinedraw
	cmp mystatus, SINGLEGAME
	je singledraw
	cmp mystatus, MAINMENU
	je mainmenudraw
	cmp mystatus, SETTINGS
	je settingsdraw
	cmp mystatus, PAUSING
	je pausingdraw
	cmp mystatus, ENDING
	je endingdraw
	cmp mystatus, COLOR
	je colordraw
	cmp mystatus, EXITING
	je exitingdraw
	cmp mystatus, HELPING
	je helpingdraw
	cmp mystatus, CREDITS
	je creditsdraw
	cmp mystatus, AUDIO
	je audiodraw
	cmp mystatus, GRAPHICS
	je graphicsdraw
	invoke ExitProcess, 0

gamedraw:
	mov eax, Frame
	dec eax
	imul eax, 1000
	invoke DrawImage, hdc, GameBMH, 0, 0, eax, 0, WinWidth, WinHeight, 1000, 750
	cmp Selected, 1
	je gamelocalselect
	cmp Selected, 2
	je gameonlineselect
	cmp Selected ,3
	je gamesingleselect
	cmp Selected, 4
	je gamebackselect
	ret
	
gamelocalselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextgame
gameonlineselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextgame
gamesingleselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextgame
gamebackselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H4Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextgame

nextgame:
	invoke DrawImage_WithMask, hdc, LocalButtonBMH, LocalButtonMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, OnlineButtonBMH, OnlineButtonMaskBMH,  W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, SingleButtonBMH, SingleButtonMaskBMH,  W2Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, BackButtonBMH, BackButtonMaskBMH,  W2Eighth, H4Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke GetTickCount
	mov NowFrameTime, eax
	sub eax, LastFrameTime
	cmp eax, 60
	jge gamegifdraw
	ret
gamegifdraw:
	mov eax, NowFrameTime
	mov LastFrameTime, eax
	mov eax, Frame
	inc eax
	mov Frame, eax
	cmp Frame, 40
	jg gamegifloop
	ret
gamegifloop:
	mov eax, 1
	mov Frame, eax
	ret

localdraw:
	invoke DrawImage, hdc, CurrentBMH, 0, 0, 0, 0, WinWidth, WinHeight, 1000, 750
	cmp CountDown, 0	;-1
	je localnocount
	;cmp CountDown, 0
	;je localcountgo
	cmp CountDown, 1
	je localcount1
	cmp CountDown, 2
	je localcount2
	cmp CountDown, 3
	je localcount3
	cmp CountDown, 4
	je localcount4
	cmp CountDown, 5
	je localcount5
	ret
localcountgo:
	invoke DrawImage_WithMask, hdc, CountGoBMH, CountGoMaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 679, 346
	ret
localcount1:
	invoke DrawImage_WithMask, hdc, Count1BMH, Count1MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
localcount2:
	invoke DrawImage_WithMask, hdc, Count2BMH, Count2MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
localcount3:
	invoke DrawImage_WithMask, hdc, Count3BMH, Count3MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
localcount4:
	invoke DrawImage_WithMask, hdc, Count4BMH, Count4MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
localcount5:
	invoke DrawImage_WithMask, hdc, Count5BMH, Count5MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
localnocount:
	ret

onlinedraw:
	invoke DrawImage, hdc, CurrentBMH, 0, 0, 0, 0, WinWidth, WinHeight, 1000, 750
	cmp CountDown, 0	;-1
	je onlinenocount
	;cmp CountDown, 0
	;je onlinecountgo
	cmp CountDown, 1
	je onlinecount1
	cmp CountDown, 2
	je onlinecount2
	cmp CountDown, 3
	je onlinecount3
	cmp CountDown, 4
	je onlinecount4
	cmp CountDown, 5
	je onlinecount5
	ret
onlinecountgo:
	invoke DrawImage_WithMask, hdc, CountGoBMH, CountGoMaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 679, 346
	ret
onlinecount1:
	invoke DrawImage_WithMask, hdc, Count1BMH, Count1MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
onlinecount2:
	invoke DrawImage_WithMask, hdc, Count2BMH, Count2MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
onlinecount3:
	invoke DrawImage_WithMask, hdc, Count3BMH, Count3MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
onlinecount4:
	invoke DrawImage_WithMask, hdc, Count4BMH, Count4MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
onlinecount5:
	invoke DrawImage_WithMask, hdc, Count5BMH, Count5MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
onlinenocount:
	ret

singledraw:
	invoke DrawImage, hdc, CurrentBMH, 0, 0, 0, 0, WinWidth, WinHeight, 1000, 750
	cmp CountDown, 0	;-1
	je singlenocount
	;cmp CountDown, 0
	;je singlecountgo
	cmp CountDown, 1
	je singlecount1
	cmp CountDown, 2
	je singlecount2
	cmp CountDown, 3
	je singlecount3
	cmp CountDown, 4
	je singlecount4
	cmp CountDown, 5
	je singlecount5
	ret
singlecountgo:
	invoke DrawImage_WithMask, hdc, CountGoBMH, CountGoMaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 679, 346
	ret
singlecount1:
	invoke DrawImage_WithMask, hdc, Count1BMH, Count1MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
singlecount2:
	invoke DrawImage_WithMask, hdc, Count2BMH, Count2MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
singlecount3:
	invoke DrawImage_WithMask, hdc, Count3BMH, Count3MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
singlecount4:
	invoke DrawImage_WithMask, hdc, Count4BMH, Count4MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
singlecount5:
	invoke DrawImage_WithMask, hdc, Count5BMH, Count5MaskBMH, W2Eighth, H1Quarter, 0, 0, W4Eighth, H2Quarter, 346, 346
	ret
singlenocount:
	ret

mainmenudraw:	;new game, settings, help, credits, exit
	mov eax, Frame
	dec eax
	imul eax, 1000
	invoke DrawImage, hdc, MainMenuBMH, 0, 0, eax, 0, WinWidth, WinHeight, 1000, 750
	cmp Selected, 1
	je mainmenunewgameselect
	cmp Selected, 2
	je mainmenusettingsselect
	cmp Selected, 3
	je mainmenuhelpselect
	cmp Selected, 4
	je mainmenucreditsselect
	cmp Selected, 5
	je mainmenuexitselect
	ret
	
mainmenunewgameselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextmainmenu
mainmenusettingsselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextmainmenu
mainmenuhelpselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextmainmenu
mainmenucreditsselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H4Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextmainmenu
mainmenuexitselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H5Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextmainmenu

nextmainmenu:
	invoke DrawImage_WithMask, hdc, NewGameButtonBMH, NewGameButtonMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, SettingsButtonBMH, SettingsButtonMaskBMH,  W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, HelpButtonBMH, HelpButtonMaskBMH,  W2Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, CreditsButtonBMH, CreditsButtonMaskBMH,  W2Eighth, H4Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, ExitButtonBMH, ExitButtonMaskBMH,  W2Eighth, H5Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke GetTickCount
	mov NowFrameTime, eax
	sub eax, LastFrameTime
	cmp eax, 60
	jge mainmenugifdraw
	ret
mainmenugifdraw:
	mov eax, NowFrameTime
	mov LastFrameTime, eax
	mov eax, Frame
	inc eax
	mov Frame, eax
	cmp Frame, 20
	jg mainmenugifloop
	ret
mainmenugifloop:
	mov eax, 1
	mov Frame, eax
	ret

settingsdraw:	;audio, graphics, back
	mov eax, Frame
	dec eax
	imul eax, 1000
	invoke DrawImage, hdc, SettingsBMH, 0, 0, eax, 0, WinWidth, WinHeight, 1000, 750

	cmp Selected, 1
	je settingsaudioselect
	cmp Selected, 2
	je settingsgraphicsselect
	cmp Selected, 3
	je settingsbackselect
	ret

settingsaudioselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextsettings

settingsgraphicsselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextsettings

settingsbackselect:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextsettings

nextsettings:
	invoke DrawImage_WithMask, hdc, AudioButtonBMH, AudioButtonMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, GraphicsButtonBMH, GraphicsButtonMaskBMH,  W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, BackButtonBMH, BackButtonMaskBMH,  W2Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke GetTickCount
	mov NowFrameTime, eax
	sub eax, LastFrameTime
	cmp eax, 60
	jge settingsgifdraw
	ret
settingsgifdraw:
	mov eax, NowFrameTime
	mov LastFrameTime, eax
	mov eax, Frame
	inc eax
	mov Frame, eax
	cmp Frame, 44
	jg settingsgifloop
	ret
settingsgifloop:
	mov eax, 1
	mov Frame, eax
	ret

pausingdraw:	;resume, new game, settings, help, mainmenu
	mov eax, Frame
	dec eax
	imul eax, 1000
	invoke DrawImage, hdc, PausingBMH, 0, 0, eax, 0, WinWidth, WinHeight, 1000, 750
	cmp Selected, 1
	je pausingresumeselected
	cmp Selected, 2
	je pausingnewgameselected
	cmp Selected, 3
	je pausingsettingsselected
	cmp Selected, 4
	je pausinghelpselected
	cmp Selected, 5
	je pausingmainmenuselected
	ret

pausingresumeselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextpausing

pausingnewgameselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextpausing

pausingsettingsselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextpausing

pausinghelpselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H4Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextpausing

pausingmainmenuselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H5Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextpausing

nextpausing:
	invoke DrawImage_WithMask, hdc, ResumeButtonBMH, ResumeButtonMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, NewGameButtonBMH, NewGameButtonMaskBMH,  W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, SettingsButtonBMH, SettingsButtonMaskBMH,  W2Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, HelpButtonBMH, HelpButtonMaskBMH,  W2Eighth, H4Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, MainMenuButtonBMH, MainMenuButtonMaskBMH,  W2Eighth, H5Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke GetTickCount
	mov NowFrameTime, eax
	sub eax, LastFrameTime
	cmp eax, 60
	jge pausinggifdraw
	ret
pausinggifdraw:
	mov eax, NowFrameTime
	mov LastFrameTime, eax
	mov eax, Frame
	inc eax
	mov Frame, eax
	cmp Frame, 24
	jg pausinggifloop
	ret
pausinggifloop:
	mov eax, 1
	mov Frame, eax
	ret

endingdraw:	;new game, credits, mainmenu, exit
	mov eax, Frame
	dec eax
	imul eax, 1000
	invoke DrawImage, hdc, EndingBMH, 0, 0, eax, 0, WinWidth, WinHeight, 1000, 750

	cmp Selected, 1
	je endingnewgameselected
	cmp Selected, 2
	je endingcreditsselected
	cmp Selected, 3
	je endingmainmenuselected
	cmp Selected, 4
	je endingexitselected
	ret

endingnewgameselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextending

endingcreditsselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H4Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextending

endingmainmenuselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H5Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextending

endingexitselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H6Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextending

nextending:
	invoke DrawImage_WithMask, hdc, NewGameButtonBMH, NewGameButtonMaskBMH,  W2Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, CreditsButtonBMH, CreditsButtonMaskBMH, W2Eighth, H4Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, MainMenuButtonBMH, MainMenuButtonMaskBMH,  W2Eighth, H5Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, ExitButtonBMH, ExitButtonMaskBMH,  W2Eighth, H6Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	cmp Winner, P1WINS
	je Win1
	cmp Winner, P2WINS
	je Win2
	cmp Winner, TIE
	je Tie
	cmp Winner, LOSE
	je Lose
	cmp Winner, WIN
	je Win
Win1:
	invoke DrawImage_WithMask, hdc, P1WinsBMH, P1WinsMaskBMH, W1Eighth, H1Tenth, 0, 0, W6Eighth, H2Tenth, 2713, 679
	jmp endinggif
Win2:
	invoke DrawImage_WithMask, hdc, P2WinsBMH, P2WinsMaskBMH, W1Eighth, H1Tenth, 0, 0, W6Eighth, H2Tenth, 2713, 679
	jmp endinggif
Tie:
	invoke DrawImage_WithMask, hdc, TieBMH, TieMaskBMH, W1Eighth, H1Tenth, 0, 0, W6Eighth, H2Tenth, 2713, 679
	jmp endinggif
Lose:
	invoke DrawImage_WithMask, hdc, YouLoseBMH, YouLoseMaskBMH, W1Eighth, H1Tenth, 0, 0, W6Eighth, H2Tenth, 2713, 679
	jmp endinggif
Win:
	invoke DrawImage_WithMask, hdc, YouWinBMH, YouWinMaskBMH, W1Eighth, H1Tenth, 0, 0, W6Eighth, H2Tenth, 2713, 679
	jmp endinggif
endinggif:
	invoke GetTickCount
	mov NowFrameTime, eax
	sub eax, LastFrameTime
	cmp eax, 500
	jge endinggifdraw
	ret
endinggifdraw:
	mov eax, NowFrameTime
	mov LastFrameTime, eax
	mov eax, Frame
	inc eax
	mov Frame, eax
	cmp Frame, 2
	jg endinggifloop
	ret
endinggifloop:
	mov eax, 1
	mov Frame, eax
	ret

colordraw:
	ret

exitingdraw:
	ret

helpingdraw:
	ret

creditsdraw:
	ret

audiodraw:	;volume, music, sfx, mute, track, back
	mov eax, Frame
	dec eax
	imul eax, 1000
	invoke DrawImage, hdc, AudioBMH, 0, 0, eax, 0, WinWidth, WinHeight, 1000, 750
	cmp Selected, 1
	je audiovolumeselected
	cmp Selected, 2
	je audiomusicselected
	cmp Selected, 3
	je audiosfxselected
	cmp Selected, 4
	je audiomuteselected
	cmp Selected, 5
	je audiotrackselected
	cmp Selected, 6
	je audiobackselected
	jmp nextaudio

audiovolumeselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextaudio
audiomusicselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W1Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextaudio
audiosfxselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W1Eighth, H4Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextaudio
audiomuteselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H5Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextaudio
audiotrackselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H6Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextaudio
audiobackselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H7Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextaudio
nextaudio:
	invoke DrawImage_WithMask, hdc, VolumeButtonBMH, VolumeButtonMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, VolumeBarBMH, VolumeBarMaskBMH, W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1500, 200
	invoke DrawImage_WithMask, hdc, MusicButtonBMH, MusicButtonMaskBMH, W1Eighth, H3Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, SFXButtonBMH, SFXButtonMaskBMH, W1Eighth, H4Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, TrackButtonBMH, TrackButtonMaskBMH, W2Eighth, H6Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, BackButtonBMH, BackButtonMaskBMH, W2Eighth, H7Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, SmallHighlightBMH, SmallHighlightMaskBMH, W5Eighth, H3Tenth, 0, 0, W2Eighth, H1Tenth, 913, 346
	invoke DrawImage_WithMask, hdc, SmallHighlightBMH, SmallHighlightMaskBMH, W5Eighth, H4Tenth, 0, 0, W2Eighth, H1Tenth, 913, 346
audiomusiccheck:
	mov eax, Music
	cmp eax, 1
	je audiomusicon
	cmp eax, 0
	je audiomusicoff
	ret
audiomusicon:
	invoke DrawImage_WithMask, hdc, OnButtonBMH, OnButtonMaskBMH, W5Eighth, H3Tenth, 0, 0, W2Eighth, H1Tenth, 913, 346
	jmp audiosfxcheck
audiomusicoff:
	invoke DrawImage_WithMask, hdc, OffButtonBMH, OffButtonMaskBMH, W5Eighth, H3Tenth, 0, 0, W2Eighth, H1Tenth, 913, 346
	jmp audiosfxcheck
audiosfxcheck:
	mov eax, SFX
	cmp eax, 1
	je audiosfxon
	cmp eax, 0
	je audiosfxoff
	ret
audiosfxon:
	invoke DrawImage_WithMask, hdc, OnButtonBMH, OnButtonMaskBMH, W5Eighth, H4Tenth, 0, 0, W2Eighth, H1Tenth, 913, 346
	jmp audiomutecheck
audiosfxoff:
	invoke DrawImage_WithMask, hdc, OffButtonBMH, OffButtonMaskBMH, W5Eighth, H4Tenth, 0, 0, W2Eighth, H1Tenth, 913, 346
	jmp audiomutecheck
audiomutecheck:
	mov eax, Music
	mov ebx, SFX
	add eax, ebx
	cmp eax, 0
	je audiomuted
audionotmuted:
	invoke DrawImage_WithMask, hdc, MuteButtonBMH, MuteButtonMaskBMH, W2Eighth, H5Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp audiogifcheck
audiomuted:
	invoke DrawImage_WithMask, hdc, UnmuteButtonBMH, UnmuteButtonMaskBMH, W2Eighth, H5Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
audiogifcheck:
	invoke GetTickCount
	mov NowFrameTime, eax
	sub eax, LastFrameTime
	cmp eax, 60
	jge audiogifdraw
	ret
audiogifdraw:
	mov eax, NowFrameTime
	mov LastFrameTime, eax
	mov eax, Frame
	inc eax
	mov Frame, eax
	cmp Frame, 22
	jg audiogifloop
	ret
audiogifloop:
	mov eax, 1
	mov Frame, eax
	ret

graphicsdraw:	;colors, image, resize, back
	mov eax, Frame
	dec eax
	imul eax, 1000
	invoke DrawImage, hdc, GraphicsBMH, 0, 0, eax, 0, WinWidth, WinHeight, 1000, 750
	cmp Selected, 1
	je graphicscolorsselected
	cmp Selected, 2
	je graphicsimageselected
	cmp Selected, 3
	je graphicsresizeselected
	cmp Selected, 4
	je graphicsbackselected
	jmp nextgraphics

graphicscolorsselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextgraphics
graphicsimageselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextgraphics
graphicsresizeselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H6Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextgraphics
graphicsbackselected:
	invoke DrawImage_WithMask, hdc, BigHighlightBMH, BigHighlightMaskBMH, W2Eighth, H7Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	jmp nextgraphics
nextgraphics:
	invoke DrawImage_WithMask, hdc, ColorsButtonBMH, ColorsButtonMaskBMH, W2Eighth, H1Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, ImageButtonBMH, ImageButtonMaskBMH, W2Eighth, H2Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage, hdc, CurrentBMH, W2Eighth, H3Tenth, 0, 0, W4Eighth, H3Tenth, 1000, 750
	invoke DrawImage_WithMask, hdc, ResizeButtonBMH, ResizeButtonMaskBMH, W2Eighth, H6Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke DrawImage_WithMask, hdc, BackButtonBMH, BackButtonMaskBMH, W2Eighth, H7Tenth, 0, 0, W4Eighth, H1Tenth, 1813, 346
	invoke GetTickCount
	mov NowFrameTime, eax
	sub eax, LastFrameTime
	cmp eax, 30
	jge graphicsgifdraw
	ret
graphicsgifdraw:
	mov eax, NowFrameTime
	mov LastFrameTime, eax
	mov eax, Frame
	inc eax
	mov Frame, eax
	cmp Frame, 40
	jg graphicsgifloop
	ret
graphicsgifloop:
	mov eax, 1
	mov Frame, eax
	ret
;============================================================================
DrawBG ENDP

BUILDRECT PROC, x:DWORD, y:DWORD, h:DWORD, w:DWORD, hdc:HDC, brush:HBRUSH
;----------------------------------------------------------------------------
LOCAL rectangle:RECT
mov eax, x
mov rectangle.left, eax
add eax, w
mov rectangle.right, eax

mov eax, y
mov rectangle.top, eax
add eax, h
mov rectangle.bottom, eax

invoke FillRect, hdc, addr rectangle, brush
ret
;============================================================================
BUILDRECT ENDP

WhichPlayer PROC, parameter:WPARAM
;----------------------------------------------------------------------------
	cmp parameter, VK_LEFT
	je PlayerOne
	cmp parameter, VK_RIGHT
	je PlayerOne
	cmp parameter, VK_UP
	je PlayerOne
	cmp parameter, VK_DOWN
	je PlayerOne
	cmp parameter, VK_W
	je PlayerTwo
	cmp parameter, VK_A
	je PlayerTwo
	cmp parameter, VK_S
	je PlayerTwo
	cmp parameter, VK_D
	je PlayerTwo
	jmp unknown
PlayerOne:
	mov eax, 1
	ret
PlayerTwo:
	mov eax, 2
	ret
unknown:
	mov eax, -1
	ret
;============================================================================
WhichPlayer ENDP

GetColor PROC, playerid:BYTE
;----------------------------------------------------------------------------
	cmp playerid, 0
	je noplayercolor
	cmp playerid, 1
	je player1color
	cmp playerid, 2
	je player2color
	cmp playerid, 3
	je player1boost
	cmp playerid, 4
	je player2boost
	cmp playerid, 5
	je player1slow
	cmp playerid, 6
	je player2slow
noplayercolor:
	mov eax, NULL
	ret
player1color:
	mov eax, Color1
	ret
player2color:
	mov eax, Color2
	ret
player1boost:
	mov eax, Darker1
	ret
player2boost:
	mov eax, Darker2
	ret
player1slow:
	mov eax, Lighter1
	ret
player2slow:
	mov eax, Lighter2
	ret
;============================================================================
GetColor ENDP

Restart PROC
;----------------------------------------------------------------------------
	mov ebx, offset grid
	mov eax, WinWidth
	mov ecx, MyD
	xor edx, edx
	div ecx
	mov edx, WinHeight
	mul edx
	xor edx, edx
	div ecx
	mov ecx, eax
clear:
	mov BYTE ptr [ebx], 0
	inc ebx
	loop clear
	mov eax, X1
	mov P1.x, eax
	mov eax, Y1
	mov P1.y, eax
	mov eax, X2
	mov P2.x, eax
	mov eax, Y2
	mov P2.y, eax
	mov eax, FACING1
	mov P1.facing, eax
	mov eax, FACING2
	mov P2.facing, eax
	mov al, VERTICAL1
	mov P1.vertical, al
	mov al, HORIZONTAL1
	mov P1.horizontal, al
	mov al, VERTICAL2
	mov P2.vertical, al
	mov al, HORIZONTAL1
	mov P2.horizontal, al
	mov eax, Speed
	mov P1.speed, eax
	mov P2.speed, eax
	mov al, BOOSTS1
	mov P1.boosts, al
	mov al, BOOSTS2
	mov P2.boosts, al
	mov eax, 3
	mov CountDown, eax
	invoke GetTickCount
	mov CountTime, eax
	mov BoostTime1, eax
	mov BoostTime2, eax
	ret
;============================================================================
Restart ENDP

ReadGrid PROC, XIndex:DWORD, YIndex:DWORD
;----------------------------------------------------------------------------
checkup:
	cmp YIndex, 0
	jl returndead
checkdown:
	mov eax, WinHeight
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp YIndex, eax
	jg returndead
checkleft:
	cmp XIndex, 0
	jl returndead
checkright:
	mov eax, WinWidth
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp XIndex, eax
	jg returndead
checkoccupancy:
	mov ebx, offset grid
	mov eax, WinWidth
	mov ecx, MyD
	xor edx, edx
	div ecx
	mov edx, eax
	mov eax, YIndex
	imul edx
	add ebx, eax
	add ebx, XIndex
	xor eax, eax
	mov al, BYTE ptr [ebx]
	ret
returndead:
	xor eax, eax
	mov al, -99
	ret
;============================================================================
ReadGrid ENDP

DrawGrid PROC, hdc:HDC
;----------------------------------------------------------------------------
local brush:HBRUSH
	mov eax, WinHeight
	mov ebx, MyD
	xor edx, edx
	div ebx
	mov ecx, eax
	mov edx, 0
	mov ebx, 0
loop00:
	mov backupecx, ecx
	mov eax, WinWidth
	mov ebx, MyD
	mov esi, edx
	xor edx, edx
	div ebx
	mov ecx, eax
	mov ebx, 0
	mov edx, esi
loop01:
	pusha
	pusha
	invoke ReadGrid, ebx, edx
	cmp al, 0
	je skipdrawpopa
	invoke GetColor, al
	pusha
	invoke GetStockObject, DC_BRUSH
	mov brush, eax
	invoke SelectObject, hdc, brush
	popa
	invoke SetDCBrushColor, hdc, eax
	mov brush, eax
	popa
	imul ebx, MyD
	imul edx, MyD
	invoke BUILDRECT, ebx, edx, MyD, MyD, hdc, brush
	jmp skipdraw
skipdrawpopa:
	popa
skipdraw:
	popa
	inc ebx
	loop loop01
	mov ecx, backupecx
	inc edx
	dec ecx
	cmp ecx, 0
	jne loop00
	ret
;============================================================================
DrawGrid ENDP

SetGrid PROC, XIndex:DWORD, YIndex:DWORD, data:BYTE
;----------------------------------------------------------------------------
local realdata:BYTE
	
	cmp data, 1
	je player1set
	cmp data, 2
	je player2set
	jmp returning
player1set:
	mov eax, Speed
	cmp P1.speed, eax
	je noboostset1
	mov eax, Slow
	cmp P1.speed, eax
	je slowset1
boostset1:
	mov al, DARK1
	mov realdata, al
	jmp nextset
slowset1:
	mov al, LIGHT1
	mov realdata, al
	jmp nextset
noboostset1:
	mov al, REG1
	mov realdata, al
	jmp nextset
player2set:
	mov eax, Speed
	cmp P2.speed, eax
	je noboostset2
	mov eax, Slow
	cmp P2.speed, eax
	je slowset2
boostset2:
	mov al, DARK2
	mov realdata, al
	jmp nextset
slowset2:
	mov al, LIGHT2
	mov realdata, al
	jmp nextset
noboostset2:
	mov al, REG2
	mov realdata, al
	jmp nextset

nextset:
	cmp YIndex, 0
	jl returning
	mov eax, WinHeight
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp YIndex, eax
	jg returning
	cmp XIndex, 0
	jl returning
	mov eax, WinWidth
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp XIndex, eax
	jg returning
	mov ebx, offset grid
	mov eax, YIndex
	mov ecx, WinWidth
	mul ecx
	mov ecx, MyD
	xor edx, edx
	div ecx
	add ebx, eax
	add ebx, XIndex
	mov al, realdata
	mov BYTE ptr [ebx], al
returning:
	ret
;============================================================================
SetGrid ENDP

MainProcedure PROC, myhWnd:HWND, message:UINT, wParam:WPARAM, lParam:LPARAM
;----------------------------------------------------------------------------
local paint:PAINTSTRUCT
local hdc:HDC
local brushcolouring1:HBRUSH
local brushcolouring2:HBRUSH
local mem_hdc:HDC
local mem_hbm:HBITMAP
local OldHandle:HBITMAP
local rect:RECT
	cmp message, WM_ERASEBKGND
	je noterasing
	cmp message, WM_CLOSE
	je closing
	cmp message, WM_KEYDOWN
	je statuskey
	cmp message, WM_MOUSEMOVE
	je statusmove
	cmp message, WM_LBUTTONDOWN
	je statusclick
	cmp message, WM_PAINT
	je statuspainting
	cmp message, WM_TIMER
	je timing
	cmp message, WM_SOCKET
	je socketing
	jmp OtherInstances

noterasing:
	mov eax, 0
	ret

closing:
	invoke ExitProcess, 0

socketing:
	cmp status, ONLINEGAME
	je connecting
	ret
connecting:
	mov eax,lParam 
	.if ax==FD_CONNECT	; the low word of lParam contains the event code. 
	shr eax,16	; the error code (if any) is in the high word of lParam 
	.if ax==NULL 
	;<no error occurs so proceed> 
	.else 
	invoke ExitProcess, 1
	.endif 
	.elseif	ax==FD_READ 
	shr eax,16 
	.if ax==NULL 
	invoke ioctlsocket, sock, FIONREAD, addr available_data 
	.if eax==NULL	
	invoke recvfrom, sock, offset buffer_for_sock, 1024, 0,NULL,NULL

	.if connected_to_peer == TRUE
	mov ebx, offset buffer_for_sock
	mov ecx, TILES
firstupdate:
	xor esi, esi
	mov esi, [ebx]
	shr esi, 24
	inc ebx
	xor edi, edi
	mov edi, [ebx]
	shr edi, 24
	inc ebx
	xor eax, eax
	mov al, BYTE ptr[ebx]
	inc ebx
	invoke SetGrid, esi, edi, al
loop firstupdate
	ret
	.endif

	invoke crt_strcmp, offset buffer_for_sock, offset doyouwanttoconnect
	cmp eax, 0
	je sendyes
	invoke crt_strcmp, offset buffer_for_sock, offset get_ready_for_ip
	cmp eax, 0
	je getreadyforip


	.if expecting_PORT == TRUE
	invoke crt_atoi, offset buffer_for_sock
	mov clientport, eax
	mov expecting_PORT, FALSE

	
	mov clientsin.sin_family, AF_INET 
	invoke htons, clientport	; convert port number into network byte order first 
	mov clientsin.sin_port,ax	; note that this member is a word-size param. 
	invoke inet_addr, addr clientip	; convert the IP address into network byte order 
	mov clientsin.sin_addr,eax 

	invoke CreateThread, NULL, NULL, offset sendLocation,offset clientsin, NULL, NULL
	mov connected_to_peer, TRUE
	.endif

	.if expecting_IP == TRUE
	invoke crt_strcpy, offset clientip, offset buffer_for_sock
	mov textoffset, offset clientip
	mov expecting_PORT, TRUE
	mov expecting_IP, FALSE
	.endif	
	mov ebx, offset buffer_for_sock
	mov ecx, TILES
secondupdate:
	xor esi, esi
	mov esi, [ebx]
	shr esi, 24
	inc ebx
	xor edi, edi
	mov edi, [ebx]
	shr edi, 24
	inc ebx
	xor eax, eax
	mov al, BYTE ptr[ebx]
	inc ebx
	invoke SetGrid, esi, edi, al
loop secondupdate

	.endif
	;<no error occurs so proceed> 
	.else 
	invoke ExitProcess, 1
	.endif 
	.elseif   ax==FD_CLOSE 
	shr eax,16 
	.if ax==NULL 
	;<no error occurs so proceed> 
	.else 
	invoke ExitProcess, 1
	.endif 
	.endif 
	ret

getreadyforip:
	mov expecting_IP, TRUE
	invoke MessageBox, hWnd, offset get_ready_for_ip, offset get_ready_for_ip, MB_OK
	ret
sendyes:
	invoke crt_strlen, offset yesiamsure
	invoke sendto, sock, offset yesiamsure, eax, 0, offset sin, sizeof sin
	mov expecting_IP, TRUE
	invoke MessageBox, hWnd, offset captionyesiwanttoconnect, offset captionyesiwanttoconnect, MB_OK
	ret

newgame:
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, GAME
	mov status, eax
	ret

localgame:
	invoke StopSFX
	invoke StopMusic
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, LOCALGAME
	mov status, eax
	invoke Restart
	cmp SFX, 0
	je localnosfx
	invoke mciSendString, offset playCountdown, NULL, NULL, NULL
localnosfx:
	ret

onlinegame:
	invoke StopSFX
	invoke StopMusic
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, ONLINEGAME
	mov status, eax
	invoke Restart
	cmp Music, 0
	je onlinenomusic
	invoke mciSendString, offset playDerezzed, NULL, NULL, NULL
onlinenomusic:
	cmp SFX, 0
	je onlinenosfx
	invoke mciSendString, offset playCountdown, NULL, NULL, NULL
onlinenosfx:
	mov textoffset, offset text
	invoke WSAStartup, 101h,addr wsadata 
	.if eax!=NULL 
	invoke ExitProcess, 1;<An error occured> 
	.else 
	xor eax, eax ;<The initialization is successful. You may proceed with other winsock calls> 
	.endif
	
	invoke socket,AF_INET,SOCK_DGRAM,0	; Create a stream socket for internet use 
	.if eax!=INVALID_SOCKET 
	mov sock,eax 
	.else 
	invoke ExitProcess, 1
	.endif
	invoke WSAAsyncSelect, sock, hWnd,WM_SOCKET, FD_CONNECT+FD_READ+FD_CLOSE 
	; Register interest in connect, read and close events. 
	.if eax==SOCKET_ERROR 
	invoke WSAGetLastError
	invoke ExitProcess, 1;<put your error handling routine here> 
	.else 
	xor eax, eax  ;........ 
	.endif
	mov sin.sin_family, AF_INET 
	invoke htons, Port	; convert port number into network byte order first 
	mov sin.sin_port,ax	; note that this member is a word-size param. 
	invoke inet_addr, addr IPAddress	; convert the IP address into network byte order 
	mov sin.sin_addr,eax 
	invoke crt_strlen, offset pleaseconnectus
	invoke sendto,sock, offset pleaseconnectus, eax, 0, offset sin, sizeof sin
	invoke WSAGetLastError
	ret

singlegame:
	invoke StopSFX
	invoke StopMusic
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, SINGLEGAME
	mov status, eax
	invoke Restart
	cmp SFX, 0
	je singlenosfx
	invoke mciSendString, offset playCountdown, NULL, NULL, NULL
singlenosfx:
	ret

settings:
	mov eax, 1
	mov Selected, eax
	mov eax, status
	mov laststatus, eax
	mov eax, SETTINGS
	mov status, eax
	ret
audiotosettings:
	mov eax, 1
	mov Selected, eax
	mov eax, SETTINGS
	mov status, eax
	ret
graphicstosettings:
	mov eax, 1
	mov Selected, eax
	mov eax, SETTINGS
	mov status, eax
	ret

help:
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, HELPING
	mov status, eax
	ret

exiting:
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, EXITING
	mov status, eax
	ret

resume:
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, GAME
	mov status, eax
	invoke StopMusic
	cmp Music, 0
	je resumenomusic
	invoke mciSendString, offset resumeDerezzed, NULL, NULL, NULL
resumenomusic:
	ret

credits:
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, CREDITS
	mov status, eax
	ret
	
pausing:
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, PAUSING
	mov status, eax
	invoke mciSendString, offset pauseDerezzed, NULL, NULL, NULL
	cmp Music, 0
	je pausingnomusic
	invoke PlayMusic
pausingnomusic:
	ret
	ret

backing:
	mov eax, 1
	mov Selected, eax
	cmp laststatus, PAUSING
	je pausing
	cmp laststatus, MAINMENU
	je mainmenu
	ret

audio:
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, AUDIO
	mov status, eax
	ret

mute:
	cmp Volume, 0000h
	je realunmute
	jmp realmute
realunmute:
	mov eax, 0
	mov ebx, BackupVolume
	mov Volume, ebx
	mov BackupVolume, eax
	mov eax, BackupMusic
	mov ebx, BackupSFX
	add eax, ebx
	cmp eax, 0
	jg partialunmute
fullunmute:
	mov eax, 1
	mov BackupMusic, eax
	mov BackupSFX, eax
partialunmute:
	mov ebx, BackupMusic
	mov Music, ebx
	mov BackupMusic, eax
	mov ebx, BackupSFX
	mov SFX, ebx
	mov BackupSFX, eax
	invoke waveOutSetVolume, NULL, Volume
	cmp Music, 0
	je unmutenomusic
	invoke PlayMusic
unmutenomusic:
	ret
realmute:
	mov eax, Volume
	mov ebx, 0
	mov BackupVolume, eax
	mov Volume, ebx
	mov eax, Music
	mov BackupMusic, eax
	mov Music, ebx
	mov eax, SFX
	mov BackupSFX, eax
	mov SFX, ebx
	invoke waveOutSetVolume, NULL, Volume
	ret

track:
	invoke StopMusic
	invoke ChangeTrack
	cmp Music, 0
	je tracknomusic
	invoke PlayMusic
tracknomusic:
	ret

colors:
	ret

music:
	mov eax, Music
	mov BackupMusic, eax
	xor Music, 1
	cmp Music, 1
	je realmusic
	jmp realnomusic
realmusic:
	invoke PlayMusic
	ret
realnomusic:
	invoke StopMusic
	ret

sfx:
	xor SFX, 1
	ret

volume:
	ret

image:
	invoke ChangeImage
	ret

resize:
	mov eax, WinWidth
	sub eax, WINWIDTH/5
	cmp eax, 3*WINWIDTH/5
	jge notloopsize
	mov eax, WINWIDTH
notloopsize:
	mov WinWidth, eax
	invoke Scale, eax
	ret

graphics:
	mov eax, 1
	mov Selected, eax
	;mov eax, status
	;mov laststatus, eax
	mov eax, GRAPHICS
	mov status, eax
	ret

mainmenu:
	mov eax, 1
	mov Selected, eax
	mov eax, status
	mov laststatus, eax
	mov eax, MAINMENU
	mov status, eax
	ret

statusmove:
	mov eax, lParam
	shl eax, 16
	shr eax, 16
	mov MouseX, eax
	mov eax, lParam
	shr eax, 16
	mov MouseY, eax
	cmp status, GAME
	je gamehover
	cmp status, MAINMENU
	je mainmenuhover
	cmp status, SETTINGS
	je settingshover
	cmp status, PAUSING
	je pausinghover
	cmp status, ENDING
	je endinghover
	cmp status, AUDIO
	je audiohover
	cmp status, GRAPHICS
	je graphicshover
	ret
gamehover:	;local, online, single, back
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je gamelocalhover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je gameonlinehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je gamesinglehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je gamebackhover
	ret
gamelocalhover:
	mov eax, 1
	mov Selected, eax
	ret
gameonlinehover:
	mov eax, 2
	mov Selected, eax
	ret
gamesinglehover:
	mov eax, 3
	mov Selected, eax
	ret
gamebackhover:
	mov eax, 4
	mov Selected, eax
	ret
gamenohover:
	ret

mainmenuhover:	;new game, settings, help, credits, exit
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je mainmenunewgamehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je mainmenusettingshover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je mainmenuhelphover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je mainmenucreditshover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H5Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je mainmenuexithover
	ret
mainmenunewgamehover:
	mov eax, 1
	mov Selected, eax
	ret
mainmenusettingshover:
	mov eax, 2
	mov Selected, eax
	ret
mainmenuhelphover:
	mov eax, 3
	mov Selected, eax
	ret
mainmenucreditshover:
	mov eax, 4
	mov Selected, eax
	ret
mainmenuexithover:
	mov eax, 5
	mov Selected, eax
	ret
mainmenunohover:
	ret

settingshover:	;audio, graphics, back
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je settingsaudiohover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je settingsgraphicshover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je settingsbackhover
	ret
settingsaudiohover:
	mov eax, 1
	mov Selected, eax
	ret
settingsgraphicshover:
	mov eax, 2
	mov Selected, eax
	ret
settingsbackhover:
	mov eax, 3
	mov Selected, eax
	ret
settingsnohover:
	ret

pausinghover:	;resume, new game, settings, help, mainmenu
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je pausingresumehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je pausingnewgamehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je pausingsettingshover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je pausinghelphover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H5Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je pausingmainmenuhover
	ret
pausingresumehover:
	mov eax, 1
	mov Selected, eax
	ret
pausingnewgamehover:
	mov eax, 2
	mov Selected, eax
	ret
pausingsettingshover:
	mov eax, 3
	mov Selected, eax
	ret
pausinghelphover:
	mov eax, 4
	mov Selected, eax
	ret
pausingmainmenuhover:
	mov eax, 5
	mov Selected, eax
	ret
pausingnohover:
	ret

endinghover:	;new game, credits, mainmenu, exit
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je endingnewgamehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je endingcreditshover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H5Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je endingmainmenuhover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H6Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je endingexithover
	ret
endingnewgamehover:
	mov eax, 1
	mov Selected, eax
	ret
endingcreditshover:
	mov eax, 2
	mov Selected, eax
	ret
endingmainmenuhover:
	mov eax, 3
	mov Selected, eax
	ret
endingexithover:
	mov eax, 4
	mov Selected, eax
	ret
endingnohover:
	ret

audiohover:	;volume, music, sfx, mute, track, back
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je audiovolumehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je audiovolumehover
	invoke CheckMouse, MouseX, MouseY, W1Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je audiomusichover
	invoke CheckMouse, MouseX, MouseY, W5Eighth, H3Tenth, W2Eighth, H1Tenth
	cmp eax, 1
	je audiomusichover
	invoke CheckMouse, MouseX, MouseY, W1Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je audiosfxhover
	invoke CheckMouse, MouseX, MouseY, W5Eighth, H4Tenth, W2Eighth, H1Tenth
	cmp eax, 1
	je audiosfxhover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H5Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je audiomutehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H6Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je audiotrackhover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H7Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je audiobackhover
	ret
audiovolumehover:
	mov eax, 1
	mov Selected, eax
	ret
audiomusichover:
	mov eax, 2
	mov Selected, eax
	ret
audiosfxhover:
	mov eax, 3
	mov Selected, eax
	ret
audiomutehover:
	mov eax, 4
	mov Selected, eax
	ret
audiotrackhover:
	mov eax, 5
	mov Selected, eax
	ret
audiobackhover:
	mov eax, 6
	mov Selected, eax
	ret
audionohover:
	ret

graphicshover:	;colors, image, resize, back
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je graphicscolorshover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je graphicsimagehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je graphicsimagehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je graphicsimagehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H5Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je graphicsimagehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H6Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je graphicsresizehover
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H7Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je graphicsbackhover
	ret
graphicscolorshover:
	mov eax, 1
	mov Selected, eax
	ret
graphicsimagehover:
	mov eax, 2
	mov Selected, eax
	ret
graphicsresizehover:
	mov eax, 3
	mov Selected, eax
	ret
graphicsbackhover:
	mov eax, 4
	mov Selected, eax
	ret
graphicsnohover:
	ret

statusclick:
	mov eax, lParam
	shl eax, 16
	shr eax, 16
	mov MouseX, eax
	mov eax, lParam
	shr eax, 16
	mov MouseY, eax
	cmp status, GAME
	je gameclick
	cmp status, MAINMENU
	je mainmenuclick
	cmp status, SETTINGS
	je settingsclick
	cmp status, PAUSING
	je pausingclick
	cmp status, ENDING
	je endingclick
	cmp status, AUDIO
	je audioclick
	cmp status, GRAPHICS
	je graphicsclick
	ret
gameclick:	;local, online, back
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je localgame
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je onlinegame
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je singlegame
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je mainmenu
	ret

mainmenuclick:	;new game, settings, help, credits, exit
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je newgame
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je settings
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je help
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je credits
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H5Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je exiting
	ret

settingsclick:	;audio, graphics, back
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je audio
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je graphics
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je backing
	ret

pausingclick:	;resume, new game, settings, help, mainmenu
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je resume
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je newgame
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je settings
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je help
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H5Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je mainmenu
	ret

endingclick:	;new game, credits, mainmenu, exit
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je newgame
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je credits
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H5Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je mainmenu
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H6Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je exiting
	ret

audioclick:	;volume, music, sfx, mute, track, back
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je mute
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je volume
	invoke CheckMouse, MouseX, MouseY, W1Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je music
	invoke CheckMouse, MouseX, MouseY, W5Eighth, H3Tenth, W2Eighth, H1Tenth
	cmp eax, 1
	je music
	invoke CheckMouse, MouseX, MouseY, W1Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je sfx
	invoke CheckMouse, MouseX, MouseY, W5Eighth, H4Tenth, W2Eighth, H1Tenth
	cmp eax, 1
	je sfx
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H5Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je mute
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H6Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je track
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H7Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je audiotosettings
	ret

graphicsclick:	;colors, image, resize, back
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H1Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je colors
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H2Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je image
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H3Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je image
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H4Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je image
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H5Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je image
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H6Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je resize
	invoke CheckMouse, MouseX, MouseY, W2Eighth, H7Tenth, W4Eighth, H1Tenth
	cmp eax, 1
	je graphicstosettings
	ret

statuskey:
	cmp status, GAME
	je gamemovement
	cmp status, LOCALGAME
	je localgamemovement
	cmp status, ONLINEGAME
	je onlinegamemovement
	cmp status, SINGLEGAME
	je singlegamemovement
	cmp status, MAINMENU
	je mainmenumovement
	cmp status, SETTINGS
	je settingsmovement
	cmp status, PAUSING
	je pausingmovement
	cmp status, ENDING
	je endingmovement
	cmp status, AUDIO
	je audiomovement
	cmp status, GRAPHICS
	je graphicsmovement
	ret

pausingmovement:
	cmp wParam, VK_P
	je resume
	cmp wParam, VK_UP
	je pausingupselect
	cmp wParam, VK_DOWN
	je pausingdownselect
	cmp wParam, VK_RETURN
	je pausingselect
	cmp wParam, VK_ESCAPE
	je closing
	ret
pausingupselect:
	dec Selected
	cmp Selected, 1
	jl pausingselectbot
	ret
pausingdownselect:
	inc Selected
	cmp Selected, 5	;number of buttons: resume, new game, settings, help, mainmenu
	jg pausingselecttop
	ret
pausingselect:
	cmp Selected, 1
	je resume
	cmp Selected, 2
	je newgame
	cmp Selected, 3
	je settings
	cmp Selected, 4
	je help
	cmp Selected, 5
	je mainmenu
	ret
pausingselecttop:
	mov eax, 1
	mov Selected, eax
	ret
pausingselectbot:
	mov eax, 5
	mov Selected, eax
	ret
	
endingmovement:
	cmp wParam, VK_UP
	je endingupselect
	cmp wParam, VK_DOWN
	je endingdownselect
	cmp wParam, VK_RETURN
	je endingselect
	cmp wParam, VK_ESCAPE
	je closing
	ret
endingupselect:
	dec Selected
	cmp Selected, 1
	jl endingselectbot
	ret
endingdownselect:
	inc Selected
	cmp Selected, 4	;number of buttons: new game, credits, mainmenu, exit
	jg endingselecttop
	ret
endingselect:
	cmp Selected, 1
	je newgame
	cmp Selected, 2
	je credits
	cmp Selected, 3
	je mainmenu
	cmp Selected, 4
	je exiting
	ret
endingselecttop:
	mov eax, 1
	mov Selected, eax
	ret
endingselectbot:
	mov eax, 4
	mov Selected, eax
	ret

mainmenumovement:
	cmp wParam, VK_UP
	je mainmenuupselect
	cmp wParam, VK_DOWN
	je mainmenudownselect
	cmp wParam, VK_RETURN
	je mainmenuselect
	cmp wParam, VK_ESCAPE
	je closing
	ret
mainmenuupselect:
	dec Selected
	cmp Selected, 1
	jl mainmenuselectbot
	ret
mainmenudownselect:
	inc Selected
	cmp Selected, 5	;number of buttons: new game, settings, help, credits, exit
	jg mainmenuselecttop
	ret
mainmenuselect:
	cmp Selected, 1
	je newgame
	cmp Selected, 2
	je settings
	cmp Selected, 3
	je help
	cmp Selected, 4
	je credits
	cmp Selected, 5
	je exiting
	ret
mainmenuselecttop:
	mov eax, 1
	mov Selected, eax
	ret
mainmenuselectbot:
	mov eax, 5
	mov Selected, eax
	ret

audiomovement:
	cmp wParam, VK_UP
	je audioupselect
	cmp wParam, VK_DOWN
	je audiodownselect
	cmp wParam, VK_RETURN
	je audioselect
	cmp wParam, VK_ESCAPE
	je closing
	ret
audioupselect:
	dec Selected
	cmp Selected, 1
	jl audioselectbot
	ret
audiodownselect:
	inc Selected
	cmp Selected, 6	;number of buttons: volume, music, sfx, mute, change song, back
	jg audioselecttop
	ret
audioselect:
	cmp Selected, 1
	je mute	;;;;;
	cmp Selected, 2
	je music	;;;;;
	cmp Selected, 3
	je sfx
	cmp Selected, 4
	je mute
	cmp Selected, 5
	je track
	cmp Selected, 6
	je audiotosettings
	ret
audioselecttop:
	mov eax, 1
	mov Selected, eax
	ret
audioselectbot:
	mov eax, 6
	mov Selected, eax
	ret

graphicsmovement:
	cmp wParam, VK_UP
	je graphicsupselect
	cmp wParam, VK_DOWN
	je graphicsdownselect
	cmp wParam, VK_RETURN
	je graphicsselect
	cmp wParam, VK_ESCAPE
	je closing
	ret
graphicsupselect:
	dec Selected
	cmp Selected, 1
	jl graphicsselectbot
	ret
graphicsdownselect:
	inc Selected
	cmp Selected, 4	;number of buttons: colors, image, resize, back
	jg graphicsselecttop
	ret
graphicsselect:
	cmp Selected, 1
	je colors
	cmp Selected, 2
	je image
	cmp Selected, 3
	je resize
	cmp Selected, 4
	je graphicstosettings
	ret
graphicsselecttop:
	mov eax, 1
	mov Selected, eax
	ret
graphicsselectbot:
	mov eax, 4
	mov Selected, eax
	ret

settingsmovement:
	cmp wParam, VK_UP
	je settingsupselect
	cmp wParam, VK_DOWN
	je settingsdownselect
	cmp wParam, VK_RETURN
	je settingsselect
	cmp wParam, VK_ESCAPE
	je closing
	ret
settingsupselect:
	dec Selected
	cmp Selected, 1
	jl settingsselectbot
	ret
settingsdownselect:
	inc Selected
	cmp Selected, 3	;number of buttons: audio, graphics, back
	jg settingsselecttop
	ret
settingsselect:
	cmp Selected, 1
	je audio
	cmp Selected, 2
	je graphics
	cmp Selected, 3
	je backing
	ret
settingsselecttop:
	mov eax, 1
	mov Selected, eax
	ret
settingsselectbot:
	mov eax, 3
	mov Selected, eax
	ret

gamemovement:
	cmp wParam, VK_UP
	je gameupselect
	cmp wParam, VK_DOWN
	je gamedownselect
	cmp wParam, VK_RETURN
	je gameselect
	cmp wParam, VK_ESCAPE
	je closing
	ret
gameupselect:
	dec Selected
	cmp Selected, 1
	jl gameselectbot
	ret
gamedownselect:
	inc Selected
	cmp Selected, 4	;number of buttons: local, online, single, back
	jg gameselecttop
	ret
gameselect:
	cmp Selected, 1
	je localgame
	cmp Selected, 2
	je onlinegame
	cmp Selected, 3
	je singlegame
	cmp Selected, 4
	je mainmenu
	ret
gameselecttop:
	mov eax, 1
	mov Selected, eax
	ret
gameselectbot:
	mov eax, 4
	mov Selected, eax
	ret

onlinegamemovement:
	cmp wParam, VK_ESCAPE
	je closing
	cmp CountDown, 0	;-1
	jne onlinetheend
	invoke WhichPlayer, wParam
	cmp eax, 1
	je onlinemovement
	jmp onlinetheend

onlineboost:
	mov eax, Speed
	cmp Me.speed, eax
	jne onlineboostret
	cmp Me.boosts, 0
	je onlineboostret
	invoke GetTickCount
	sub eax, MyBoostTime
	cmp eax, 3000
	jl onlineboostret
	invoke GetTickCount
	mov MyBoostTime, eax
	xor eax, eax
	mov MyBoostTiles, eax
	mov eax, Boost
	mov Me.speed, eax
	dec Me.boosts
	invoke mciSendString, offset playBoost, NULL, NULL, NULL
onlineboostret:
	ret
onlinemovement:
	mov eax, MyNowKey
	mov MyLastKey, eax
	mov eax, wParam
	mov MyNowKey, eax
	mov eax, MyNowKeyTime
	mov MyLastKeyTime, eax
	invoke GetTickCount
	mov MyNowKeyTime, eax
	mov eax, MyNowKey
	cmp MyLastKey, eax
	jne onlinenotboost
	mov eax, MyNowKeyTime
	sub eax, MyLastKeyTime
	cmp eax, 500
	jle onlineboost
	jmp onlinenotboost

onlinenotboost:
	cmp Me.horizontal, 0
	jne onlineVertically

onlineHorizontally:
	cmp wParam, VK_LEFT
	je onlineleft
	cmp wParam, VK_RIGHT
	je onlineright

	cmp Me.vertical, 0
	jne onlinetheend

onlineVertically:
	cmp wParam, VK_UP
	je onlineup
	cmp wParam, VK_DOWN
	je onlinedown
	ret

onlineleft:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, LEFT
	mov Me.facing, eax
	mov Me.horizontal, 1
	mov Me.vertical, 0
	ret

onlineright:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, RIGHT
	mov Me.facing, eax
	mov Me.horizontal, 1
	mov Me.vertical, 0
	ret

onlinedown:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, DOWN
	mov Me.facing, eax
	mov Me.horizontal, 0
	mov Me.vertical, 1
	ret

onlineup:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, UP
	mov Me.facing, eax
	mov Me.horizontal, 0
	mov Me.vertical, 1
	ret
onlinetheend:
	ret

localgamemovement:
	cmp wParam, VK_ESCAPE
	je closing
	cmp wParam, VK_P
	je pausing
	cmp wParam, VK_R
	je newgame
	cmp CountDown, 0	;-1
	jne localtheend
	;cmp wParam, VK_RSHIFT
	;je localboost1
	;cmp wParam, VK_LSHIFT
	;je localboost2
	invoke WhichPlayer, wParam
	cmp eax, 1
	je localmovement1
	cmp eax, 2
	je localmovement2
	cmp eax, -1
	je localtheend

localboost1:
	mov eax, Speed
	cmp P1.speed, eax
	jne localboostret1
	cmp P1.boosts, 0
	je localboostret1
	invoke GetTickCount
	sub eax, BoostTime1
	cmp eax, 3000
	jl localboostret1
	invoke GetTickCount
	mov BoostTime1, eax
	xor eax, eax
	mov BoostTiles1, eax
	mov eax, Boost
	mov P1.speed, eax
	dec P1.boosts
	invoke mciSendString, offset playBoost, NULL, NULL, NULL
localboostret1:
	ret

localboost2:
	mov eax, Speed
	cmp P2.speed, eax
	jne localboostret2
	cmp P2.boosts, 0
	je localboostret2
	invoke GetTickCount
	sub eax, BoostTime2
	cmp eax, 3000
	jl localboostret1
	invoke GetTickCount
	mov BoostTime2, eax
	xor eax, eax
	mov BoostTiles2, eax
	mov eax, Boost
	mov P2.speed, eax
	dec P2.boosts
	invoke mciSendString, offset playBoost, NULL, NULL, NULL
localboostret2:
	ret

localmovement1:
	mov eax, NowKey1
	mov LastKey1, eax
	mov eax, wParam
	mov NowKey1, eax
	mov eax, NowKeyTime1
	mov LastKeyTime1, eax
	invoke GetTickCount
	mov NowKeyTime1, eax
	mov eax, NowKey1
	cmp LastKey1, eax
	jne localnotboost1
	mov eax, NowKeyTime1
	sub eax, LastKeyTime1
	cmp eax, 500
	jle localboost1
	jmp localnotboost1

localnotboost1:
	cmp P1.horizontal, 0
	jne localVertically1

localHorizontally1:
	cmp wParam, VK_LEFT
	je localleft1
	cmp wParam, VK_RIGHT
	je localright1

	cmp P1.vertical, 0
	jne localtheend

localVertically1:
	cmp wParam, VK_UP
	je localup1
	cmp wParam, VK_DOWN
	je localdown1
	ret

localleft1:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, LEFT
	mov P1.facing, eax
	mov P1.horizontal, 1
	mov P1.vertical, 0
	ret

localright1:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, RIGHT
	mov P1.facing, eax
	mov P1.horizontal, 1
	mov P1.vertical, 0
	ret

localdown1:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, DOWN
	mov P1.facing, eax
	mov P1.horizontal, 0
	mov P1.vertical, 1
	ret

localup1:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, UP
	mov P1.facing, eax
	mov P1.horizontal, 0
	mov P1.vertical, 1
	ret

localmovement2:
	mov eax, NowKey2
	mov LastKey2, eax
	mov eax, wParam
	mov NowKey2, eax
	mov eax, NowKeyTime2
	mov LastKeyTime2, eax
	invoke GetTickCount
	mov NowKeyTime2, eax
	mov eax, NowKey2
	cmp LastKey2, eax
	jne localnotboost2
	mov eax, NowKeyTime2
	sub eax, LastKeyTime2
	cmp eax, 500
	jle localboost2
	jmp localnotboost2

localnotboost2:
	cmp P2.horizontal, 0
	jne localVertically2

localHorizontally2:
	cmp wParam, VK_A
	je localleft2
	cmp wParam, VK_D
	je localright2

	cmp P2.vertical, 0
	jne localtheend

localVertically2:
	cmp wParam, VK_W
	je localup2
	cmp wParam, VK_S
	je localdown2
	ret

localleft2:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, LEFT
	mov P2.facing, eax
	mov P2.horizontal, 1
	mov P2.vertical, 0
	ret

localright2:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, RIGHT
	mov P2.facing, eax
	mov P2.horizontal, 1
	mov P2.vertical, 0
	ret

localdown2:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, DOWN
	mov P2.facing, eax
	mov P2.horizontal, 0
	mov P2.vertical, 1
	ret

localup2:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, UP
	mov P2.facing, eax
	mov P2.horizontal, 0
	mov P2.vertical, 1
	ret
localtheend:
	ret

singlegamemovement:
	cmp wParam, VK_ESCAPE
	je closing
	cmp CountDown, 0	;-1
	jne singletheend
	invoke WhichPlayer, wParam
	cmp eax, 1
	je singlemovement
	jmp singletheend

singleboost:
	mov eax, Speed
	cmp P1.speed, eax
	jne singleboostret
	cmp P1.boosts, 0
	je singleboostret
	invoke GetTickCount
	sub eax, MyBoostTime
	cmp eax, 3000
	jl singleboostret
	invoke GetTickCount
	mov MyBoostTime, eax
	xor eax, eax
	mov MyBoostTiles, eax
	mov eax, Boost
	mov P1.speed, eax
	dec P1.boosts
	invoke mciSendString, offset playBoost, NULL, NULL, NULL
singleboostret:
	ret
singlemovement:
	mov eax, MyNowKey
	mov MyLastKey, eax
	mov eax, wParam
	mov MyNowKey, eax
	mov eax, MyNowKeyTime
	mov MyLastKeyTime, eax
	invoke GetTickCount
	mov MyNowKeyTime, eax
	mov eax, MyNowKey
	cmp MyLastKey, eax
	jne singlenotboost
	mov eax, MyNowKeyTime
	sub eax, MyLastKeyTime
	cmp eax, 500
	jle singleboost
	jmp singlenotboost

singlenotboost:
	cmp P1.horizontal, 0
	jne singleVertically

singleHorizontally:
	cmp wParam, VK_LEFT
	je singleleft
	cmp wParam, VK_RIGHT
	je singleright

	cmp P1.vertical, 0
	jne singletheend

singleVertically:
	cmp wParam, VK_UP
	je singleup
	cmp wParam, VK_DOWN
	je singledown
	ret

singleleft:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, LEFT
	mov P1.facing, eax
	mov P1.horizontal, 1
	mov P1.vertical, 0
	ret

singleright:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, RIGHT
	mov P1.facing, eax
	mov P1.horizontal, 1
	mov P1.vertical, 0
	ret

singledown:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, DOWN
	mov P1.facing, eax
	mov P1.horizontal, 0
	mov P1.vertical, 1
	ret

singleup:
	;invoke mciSendString, offset stopTurn, NULL, NULL, NULL
	;invoke mciSendString, offset playTurn, NULL, NULL, NULL
	mov eax, UP
	mov P1.facing, eax
	mov P1.horizontal, 0
	mov P1.vertical, 1
	ret
singletheend:
	ret

statuspainting:
	cmp status, GAME
	je gamepaint
	cmp status, LOCALGAME
	je localgamepaint
	cmp status, ONLINEGAME
	je onlinegamepaint
	cmp status, SINGLEGAME
	je singlegamepaint
	cmp status, MAINMENU
	je mainmenupaint
	cmp status, SETTINGS
	je settingspaint
	cmp status, PAUSING
	je pausingpaint
	cmp status, ENDING
	je endingpaint
	cmp status, AUDIO
	je audiopaint
	cmp status, GRAPHICS
	je graphicspaint
	jmp closing

pausingpaint:
	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	ret

graphicspaint:
	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	ret

endingpaint:
	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	ret

mainmenupaint:
	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	ret

settingspaint:
	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	ret

audiopaint:
	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	ret

gamepaint:
	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	ret

localgamepaint:
	cmp CountDown, 0	;-1
	je nextlocalpaint

	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke SetGrid, P1.x, P1.y, P1.id
	invoke SetGrid, P2.x, P2.y, P2.id
	invoke DrawGrid, mem_hdc
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint

	invoke GetTickCount
	sub eax, CountTime
	cmp eax, 1000
	jge localcount
	ret
localcount:
	dec CountDown
	invoke GetTickCount
	mov CountTime, eax
	cmp CountDown, 0
	jne localnomusic
	cmp Music, 0
	je localnomusic
	invoke mciSendString, offset playDerezzed, NULL, NULL, NULL
localnomusic:
	ret

nextlocalpaint:
	;mov eax, Speed
	;cmp P1.speed, eax
	;je notboosting1
	;invoke GetTickCount
	;sub eax, BoostTime1
	;cmp eax, 300
	;jg localendboost1

;notboosting1:
	mov eax, P1.speed
	mov ecx, MyD
	xor edx, edx
	div ecx
	mov ecx, eax
localpaint1:
	mov eax, Boost
	cmp P1.speed, eax
	jne localnext1
	inc BoostTiles1
	mov eax, BoostTiles1
	cmp eax, 20
	jg localendboost1
	jmp localnext1
localendboost1:
	xor eax, eax
	mov BoostTiles1, eax
	mov eax, Speed
	mov P1.speed, eax
	jmp localnext1
localnext1:
	push ecx
	cmp P1.facing, LEFT
	je localmoveleft1
	cmp P1.facing, RIGHT
	je localmoveright1
	cmp P1.facing, DOWN
	je localmovedown1
	cmp P1.facing, UP
	je localmoveup1
	pusha
	cmp P1.facing, STOP
	je localnotdead1

localmoveleft1:
	dec P1.x
	jmp localcheckalive1

localmoveright1:
	inc P1.x
	jmp localcheckalive1

localmovedown1:
	inc P1.y
	jmp localcheckalive1

localmoveup1:
	dec P1.y
	jmp localcheckalive1

localcheckalive1:
	pusha
	cmp P1.x, 0
	jl localdead1
	mov eax, WinWidth
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp P1.x, eax
	jg localdead1
	cmp P1.y, 0
	jl localdead1
	mov eax, WinHeight
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp P1.y, eax
	jg localdead1
	mov eax, P2.x
	cmp P1.x, eax
	jne localnottied1
	mov eax, P2.y
	cmp P1.y, eax
	je localtied
localnottied1:
	invoke ReadGrid, P1.x, P1.y
	cmp al, -99
	je localdead1
	cmp al, 0
	je localnotdead1
	jmp localdead1

localdead1:
	popa
	invoke mciSendString, offset stopDerezzed, NULL, NULL, NULL
	invoke mciSendString, offset playApplause, NULL, NULL, NULL
	mov eax, status
	mov laststatus, eax
	mov eax, ENDING
	mov status, eax
	mov eax, P2WINS
	mov Winner, eax
	cmp Music, 0
	je localdead1nomusic
	invoke PlayMusic
localdead1nomusic:
	ret

localnotdead1:
	invoke SetGrid, P1.x, P1.y, P1.id
	popa
	pop ecx
	dec ecx
	cmp ecx, 0
	jne localpaint1

	;mov eax, Speed
	;cmp P2.speed, eax
	;je notboosting2
	;invoke GetTickCount
	;sub eax, BoostTime2
	;cmp eax, 300
	;jg localendboost2
	mov eax, P2.speed
	mov ecx, MyD
	xor edx, edx
	div ecx
	mov ecx, eax
localpaint2:
	mov eax, Boost
	cmp P2.speed, eax
	jne localnext2
	inc BoostTiles2
	mov eax, BoostTiles2
	cmp eax, 20
	jg localendboost2
	jmp localnext2
localendboost2:
	xor eax, eax
	mov BoostTiles2, eax
	mov eax, Speed
	mov P2.speed, eax
	jmp localnext2
localnext2:
	push ecx
	cmp P2.facing, LEFT
	je localmoveleft2
	cmp P2.facing, RIGHT
	je localmoveright2
	cmp P2.facing, DOWN
	je localmovedown2
	cmp P2.facing, UP
	je localmoveup2
	pusha
	cmp P2.facing, STOP
	je localnotdead2

localmoveleft2:
	dec P2.x
	jmp localcheckalive2

localmoveright2:
	inc P2.x
	jmp localcheckalive2

localmovedown2:
	inc P2.y
	jmp localcheckalive2

localmoveup2:
	dec P2.y
	jmp localcheckalive2

localcheckalive2:
	pusha
	cmp P2.x, 0
	jl localdead2
	mov eax, WinWidth
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp P2.x, eax
	jg localdead2
	cmp P2.y, 0
	jl localdead2
	mov eax, WinHeight
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp P2.y, eax
	jg localdead2
	mov eax, P2.x
	cmp P1.x, eax
	jne localnottied2
	mov eax, P2.y
	cmp P1.y, eax
	je localtied

localnottied2:
	invoke ReadGrid, P2.x, P2.y
	cmp al, -99
	je localdead2
	cmp al, 0
	je localnotdead2
	jmp localdead2

localdead2:
	popa
	invoke mciSendString, offset stopDerezzed, NULL, NULL, NULL
	invoke mciSendString, offset playApplause, NULL, NULL, NULL
	mov eax, status
	mov laststatus, eax
	mov eax, ENDING
	mov status, eax
	mov eax, P1WINS
	mov Winner, eax
	cmp Music, 0
	je localdead2nomusic
	invoke PlayMusic
localdead2nomusic:
	ret

localnotdead2:
	invoke SetGrid, P2.x, P2.y, P2.id
	popa
	pop ecx
	dec ecx
	cmp ecx, 0
	jne localpaint2

	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke DrawGrid, mem_hdc
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	ret

localtied:
	popa
	mov eax, status
	mov laststatus, eax
	mov eax, ENDING
	mov status, eax
	mov eax, TIE
	mov Winner, eax
	invoke mciSendString, offset stopDerezzed, NULL, NULL, NULL
	ret

onlinegamepaint:
	cmp CountDown, 0	;-1
	je nextonlinepaint
	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke SetGrid, Me.x, Me.y, Me.id
	invoke DrawGrid, mem_hdc
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	invoke GetTickCount
	sub eax, CountTime
	cmp eax, 1000
	jge onlinecount
	ret
onlinecount:
	dec CountDown
	invoke GetTickCount
	mov CountTime, eax
	ret

nextonlinepaint:
	;mov eax, Speed
	;cmp P1.speed, eax
	;je notboosting1
	;invoke GetTickCount
	;sub eax, BoostTime1
	;cmp eax, 300
	;jg onlineendboost1

;notboostingme:
	mov eax, Me.speed
	mov ecx, MyD
	xor edx, edx
	div ecx
	mov ecx, eax
onlinepaint:
	mov eax, Boost
	cmp Me.speed, eax
	jne onlinenext
	inc MyBoostTiles
	mov eax, MyBoostTiles
	cmp eax, 20
	jg onlineendboost
	jmp onlinenext
onlineendboost:
	xor eax, eax
	mov MyBoostTiles, eax
	mov eax, Speed
	mov Me.speed, eax
	jmp onlinenext
onlinenext:
	push ecx
	cmp Me.facing, LEFT
	je onlinemoveleft
	cmp Me.facing, RIGHT
	je onlinemoveright
	cmp Me.facing, DOWN
	je onlinemovedown
	cmp Me.facing, UP
	je onlinemoveup
	pusha
	cmp Me.facing, STOP
	je onlinenotdead

onlinemoveleft:
	dec P1.x
	jmp onlinecheckalive

onlinemoveright:
	inc P1.x
	jmp onlinecheckalive

onlinemovedown:
	inc P1.y
	jmp onlinecheckalive

onlinemoveup:
	dec P1.y
	jmp onlinecheckalive

onlinecheckalive:
	pusha
	cmp Me.x, 0
	jl onlinedead
	mov eax, WinWidth
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp Me.x, eax
	jg onlinedead
	cmp Me.y, 0
	jl onlinedead
	mov eax, WinHeight
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp Me.y, eax
	jg onlinedead
	mov eax, P2.x
	cmp Me.x, eax
	jne onlinenottied
	mov eax, P2.y
	cmp Me.y, eax
	je onlinetied
onlinenottied:
	invoke ReadGrid, Me.x, Me.y
	cmp al, -99
	je onlinedead
	cmp al, 0
	je onlinenotdead
	jmp onlinedead

onlinedead:
	popa
	invoke mciSendString, offset stopDerezzed, NULL, NULL, NULL
	invoke mciSendString, offset playApplause, NULL, NULL, NULL
	mov eax, status
	mov laststatus, eax
	mov eax, ENDING
	mov status, eax
	mov eax, LOSE
	mov Winner, eax
	cmp Music, 0
	je onlinedeadnomusic
	invoke PlayMusic
onlinedeadnomusic:
	ret

onlinenotdead:
	invoke SetGrid, Me.x, Me.y, Me.id
	popa
	pop ecx
	dec ecx
	cmp ecx, 0
	jne onlinepaint

	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke DrawGrid, mem_hdc
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	ret

onlinetied:
	popa
	mov eax, status
	mov laststatus, eax
	mov eax, ENDING
	mov status, eax
	mov eax, TIE
	mov Winner, eax
	invoke mciSendString, offset stopDerezzed, NULL, NULL, NULL
	ret

singlegamepaint:
	cmp CountDown, 0	;-1
	je nextsinglepaint

	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke SetGrid, P1.x, P1.y, P1.id
	invoke SetGrid, P2.x, P2.y, P2.id
	invoke DrawGrid, mem_hdc
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint

	invoke GetTickCount
	sub eax, CountTime
	cmp eax, 1000
	jge singlecount
	ret
singlecount:
	dec CountDown
	invoke GetTickCount
	mov CountTime, eax
	cmp CountDown, 0
	jne singlenomusic
	cmp Music, 0
	je singlenomusic
	invoke mciSendString, offset playDerezzed, NULL, NULL, NULL
singlenomusic:
	ret

nextsinglepaint:
	;mov eax, Speed
	;cmp P1.speed, eax
	;je notboosting1
	;invoke GetTickCount
	;sub eax, BoostTime1
	;cmp eax, 300
	;jg singleendboost1

;notboosting1:
	mov eax, P1.speed
	mov ecx, MyD
	xor edx, edx
	div ecx
	mov ecx, eax
singlepaint1:
	mov eax, Boost
	cmp P1.speed, eax
	jne singlenext1
	inc BoostTiles1
	mov eax, BoostTiles1
	cmp eax, 20
	jg singleendboost1
	jmp singlenext1
singleendboost1:
	xor eax, eax
	mov BoostTiles1, eax
	mov eax, Speed
	mov P1.speed, eax
	jmp singlenext1
singlenext1:
	push ecx
	cmp P1.facing, LEFT
	je singlemoveleft1
	cmp P1.facing, RIGHT
	je singlemoveright1
	cmp P1.facing, DOWN
	je singlemovedown1
	cmp P1.facing, UP
	je singlemoveup1
	pusha
	cmp P1.facing, STOP
	je singlenotdead1

singlemoveleft1:
	dec P1.x
	jmp singlecheckalive1

singlemoveright1:
	inc P1.x
	jmp singlecheckalive1

singlemovedown1:
	inc P1.y
	jmp singlecheckalive1

singlemoveup1:
	dec P1.y
	jmp singlecheckalive1

singlecheckalive1:
	pusha
	cmp P1.x, 0
	jl singledead1
	mov eax, WinWidth
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp P1.x, eax
	jg singledead1
	cmp P1.y, 0
	jl singledead1
	mov eax, WinHeight
	mov ebx, MyD
	xor edx, edx
	div ebx
	dec eax
	cmp P1.y, eax
	jg singledead1
	mov eax, P2.x
	cmp P1.x, eax
	jne singlenottied1
	mov eax, P2.y
	cmp P1.y, eax
	je singletied
singlenottied1:
	invoke ReadGrid, P1.x, P1.y
	cmp al, -99
	je singledead1
	cmp al, 0
	je singlenotdead1
	jmp singledead1

singledead1:
	popa
	invoke mciSendString, offset stopDerezzed, NULL, NULL, NULL
	invoke mciSendString, offset playApplause, NULL, NULL, NULL
	mov eax, status
	mov laststatus, eax
	mov eax, ENDING
	mov status, eax
	mov eax, LOSE
	mov Winner, eax
	cmp Music, 0
	je singledead1nomusic
	invoke PlayMusic
singledead1nomusic:
	ret

singlenotdead1:
	invoke SetGrid, P1.x, P1.y, P1.id
	popa
	pop ecx
	dec ecx
	cmp ecx, 0
	jne singlepaint1

	;mov eax, Speed
	;cmp P2.speed, eax
	;je notboosting2
	;invoke GetTickCount
	;sub eax, BoostTime2
	;cmp eax, 300
	;jg singleendboost2
	mov eax, P2.speed
	mov ecx, MyD
	xor edx, edx
	div ecx
	mov ecx, eax
singlepaint2:
	mov eax, Boost
	cmp P2.speed, eax
	jne singlenext2
	inc BoostTiles2
	mov eax, BoostTiles2
	cmp eax, 20
	jg singleendboost2
	jmp singlenext2
singleendboost2:
	xor eax, eax
	mov BoostTiles2, eax
	mov eax, Speed
	mov P2.speed, eax
	jmp singlenext2
singlenext2:
	push ecx
	cmp P2.facing, LEFT
	je singlemoveleft2
	cmp P2.facing, RIGHT
	je singlemoveright2
	cmp P2.facing, DOWN
	je singlemovedown2
	cmp P2.facing, UP
	je singlemoveup2
	cmp P2.facing, STOP
	je singlenotdead2
singlemoveleft2:
	mov eax, P2.x
	dec eax
	invoke ReadGrid, eax, P2.y
	cmp al, 0
	je singleleft2
	mov eax, P2.y
	dec eax
	invoke ReadGrid, P2.x, eax
	cmp al, 0
	je singleup2
	mov eax, P2.y
	inc eax
	invoke ReadGrid, P2.x, eax
	cmp al, 0
	je singledown2
	jmp singledead2

singlemoveright2:
	mov eax, P2.x
	inc eax
	invoke ReadGrid, eax, P2.y
	cmp al, 0
	je singleright2
	mov eax, P2.y
	dec eax
	invoke ReadGrid, P2.x, eax
	cmp al, 0
	je singleup2
	mov eax, P2.y
	inc eax
	invoke ReadGrid, P2.x, eax
	cmp al, 0
	je singledown2
	jmp singledead2

singlemovedown2:
	mov eax, P2.y
	inc eax
	invoke ReadGrid, P2.x, eax
	cmp al, 0
	je singledown2
	mov eax, P2.x
	dec eax
	invoke ReadGrid, eax, P2.y
	cmp al, 0
	je singleleft2
	mov eax, P2.x
	inc eax
	invoke ReadGrid, eax, P2.y
	cmp al, 0
	je singleright2
	jmp singledead2

singlemoveup2:
	mov eax, P2.y
	dec eax
	invoke ReadGrid, P2.x, eax
	cmp al, 0
	je singleup2
	mov eax, P2.x
	dec eax
	invoke ReadGrid, eax, P2.y
	cmp al, 0
	je singleleft2
	mov eax, P2.x
	inc eax
	invoke ReadGrid, eax, P2.y
	cmp al, 0
	je singleright2
	jmp singledead2

singleup2:
	mov eax, UP
	mov P2.facing, eax
	mov P2.horizontal, 0
	mov P2.vertical, 1
	dec P2.y
	jmp singlecheckalive2
singledown2:
	mov eax, DOWN
	mov P2.facing, eax
	mov P2.horizontal, 0
	mov P2.vertical, 1
	inc P2.y
	jmp singlecheckalive2
singleleft2:
	mov eax, LEFT
	mov P2.facing, eax
	mov P2.horizontal, 1
	mov P2.vertical, 0
	dec P2.x
	jmp singlecheckalive2
singleright2:
	mov eax, RIGHT
	mov P2.facing, eax
	mov P2.horizontal, 0
	mov P2.vertical, 1
	inc P2.x
	jmp singlecheckalive2
singlecheckalive2:
	mov eax, P2.x
	cmp P1.x, eax
	jne singlenotdead2
	mov eax, P2.y
	cmp P1.y, eax
	je singletied
	jmp singlenotdead2

singledead2:
	invoke mciSendString, offset stopDerezzed, NULL, NULL, NULL
	invoke mciSendString, offset playApplause, NULL, NULL, NULL
	mov eax, status
	mov laststatus, eax
	mov eax, ENDING
	mov status, eax
	mov eax, WIN
	mov Winner, eax
	cmp Music, 0
	je singledead2nomusic
	invoke PlayMusic
singledead2nomusic:
	ret

singlenotdead2:
	invoke SetGrid, P2.x, P2.y, P2.id
	pop ecx			;;;;;;;;;;;;;
	dec ecx
	cmp ecx, 0
	jne singlepaint2

	invoke BeginPaint, myhWnd, addr paint
	mov hdc, eax
	invoke CreateCompatibleDC, hdc
	mov mem_hdc, eax
	invoke CreateCompatibleBitmap, hdc, WinWidth, WinHeight
	mov mem_hbm, eax
	invoke SelectObject, mem_hdc, mem_hbm
	mov OldHandle, eax
	invoke DrawBG, status, rect, mem_hdc, myhWnd
	invoke DrawGrid, mem_hdc
	invoke BitBlt, hdc, 0, 0, WinWidth, WinHeight, mem_hdc, 0, 0, SRCCOPY
	invoke SelectObject, mem_hdc, OldHandle
	invoke DeleteObject, mem_hbm
	invoke DeleteDC, mem_hdc
	invoke EndPaint, myhWnd, addr paint
	ret

singletied:
	popa
	mov eax, status
	mov laststatus, eax
	mov eax, ENDING
	mov status, eax
	mov eax, TIE
	mov Winner, eax
	invoke mciSendString, offset stopDerezzed, NULL, NULL, NULL
	ret
	
timing:
	invoke InvalidateRect, myhWnd, NULL, TRUE
	cmp status, LOCALGAME
	je localcool
	cmp status, ONLINEGAME
	je onlinecool
	cmp status, SINGLEGAME
	je singlecool
	ret
localcool:
	invoke GetTickCount
	sub eax, CoolTime
	cmp eax, 5000
	jl uncool
cool1:
	cmp P1.boosts, 3
	jge cool2
	inc P1.boosts
	invoke GetTickCount
	mov CoolTime, eax
cool2:
	cmp P2.boosts, 3
	jge uncool
	inc P2.boosts
	invoke GetTickCount
	mov CoolTime, eax
	ret
onlinecool:
	invoke GetTickCount
	sub eax, CoolTime
	cmp eax, 5000
	jl uncool
cool:
	cmp Me.boosts, 3
	jge uncool
	inc Me.boosts
	invoke GetTickCount
	mov CoolTime, eax
	ret
singlecool:
	invoke GetTickCount
	sub eax, CoolTime
	cmp eax, 5000
	jl uncool
	cmp P1.boosts, 3
	jge uncool
	inc P1.boosts
	invoke GetTickCount
	mov CoolTime, eax
	ret
uncool:
	ret

OtherInstances:
	invoke DefWindowProc, myhWnd, message, wParam, lParam
	ret
;============================================================================
MainProcedure ENDP

main PROC
LOCAL wndcls:WNDCLASSA
LOCAL msg:MSG
invoke Scale, WinWidth
invoke waveOutSetVolume, NULL, 0
invoke mciSendString, offset playBoost, NULL, NULL, NULL
invoke mciSendString, offset playTurn, NULL, NULL, NULL
invoke waveOutSetVolume, NULL, Volume
invoke PlayMusic
invoke RtlZeroMemory, addr wndcls, SIZEOF wndcls ;Empty the window class
mov eax, offset ClassName
mov wndcls.lpszClassName, eax
invoke GetStockObject, BLACK_BRUSH
mov wndcls.hbrBackground, eax ;Set the background color as black
mov eax, MainProcedure
mov wndcls.lpfnWndProc, eax ;Set the procedure that handles the window messages
invoke RegisterClassA, addr wndcls ;Register the class
invoke CreateWindowExA, WS_EX_COMPOSITED, addr ClassName, addr windowTitle, WS_SYSMENU, 0, 0, RealWidth, RealHeight, 0, 0, 0, 0 ;Create the window
mov hWnd, eax ;Save the handle

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, GAME1
mov Game1BMH, eax
mov eax, Game1BMH
mov CurrentBMH, eax	;;;;;

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, GAME2
mov Game2BMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, GAME3
mov Game3BMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, GAME4
mov Game4BMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, GAME5
mov Game5BMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, GAME6
mov Game6BMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, MAINMENU
mov MainMenuBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, SETTINGS
mov SettingsBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, ENDING
mov EndingBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, PAUSING
mov PausingBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, GAME
mov GameBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, EXITING
mov ExitingBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, HELPING
mov HelpingBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, CREDITS
mov CreditsBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, AUDIO
mov AudioBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, GRAPHICS
mov GraphicsBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, COLOR
mov ColorBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, NEWGAMEBUTTON
mov NewGameButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, NewGameButtonBMH, 0ffffffh	;white
mov NewGameButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, LOCALGAME
mov LocalButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, LocalButtonBMH, 0ffffffh	;white
mov LocalButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, ONLINEGAME
mov OnlineButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, OnlineButtonBMH, 0ffffffh	;white
mov OnlineButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, SINGLEGAME
mov SingleButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, SingleButtonBMH, 0ffffffh	;white
mov SingleButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, MAINMENUBUTTON
mov MainMenuButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, MainMenuButtonBMH, 0ffffffh	;white
mov MainMenuButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, BACKBUTTON
mov BackButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, BackButtonBMH, 0ffffffh	;white
mov BackButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, SETTINGSBUTTON
mov SettingsButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, SettingsButtonBMH, 0ffffffh	;white
mov SettingsButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, AUDIOBUTTON
mov AudioButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, AudioButtonBMH, 0ffffffh	;white
mov AudioButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, GRAPHICSBUTTON
mov GraphicsButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, GraphicsButtonBMH, 0ffffffh	;white
mov GraphicsButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, RESUMEBUTTON
mov ResumeButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, ResumeButtonBMH, 0ffffffh	;white
mov ResumeButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, HELPBUTTON
mov HelpButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, HelpButtonBMH, 0ffffffh	;white
mov HelpButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, CREDITSBUTTON
mov CreditsButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, CreditsButtonBMH, 0ffffffh	;white
mov CreditsButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, EXITBUTTON
mov ExitButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, ExitButtonBMH, 0ffffffh	;white
mov ExitButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, MUSICBUTTON
mov MusicButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, MusicButtonBMH, 0ffffffh	;white
mov MusicButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, BIGHIGHLIGHT
mov BigHighlightBMH, eax
invoke Get_Handle_To_Mask_Bitmap, BigHighlightBMH, 0ffffffh	;white
mov BigHighlightMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, SMALLHIGHLIGHT
mov SmallHighlightBMH, eax
invoke Get_Handle_To_Mask_Bitmap, SmallHighlightBMH, 0ffffffh	;white
mov SmallHighlightMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, IMAGEBUTTON
mov ImageButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, ImageButtonBMH, 0ffffffh	;white
mov ImageButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, COLORSBUTTON
mov ColorsButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, ColorsButtonBMH, 0ffffffh	;white
mov ColorsButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, TRACKBUTTON
mov TrackButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, TrackButtonBMH, 0ffffffh	;white
mov TrackButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, SFXBUTTON
mov SFXButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, SFXButtonBMH, 0ffffffh	;white
mov SFXButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, RESIZEBUTTON
mov ResizeButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, ResizeButtonBMH, 0ffffffh	;white
mov ResizeButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, VOLUMEBAR
mov VolumeBarBMH, eax
invoke Get_Handle_To_Mask_Bitmap, VolumeBarBMH, 0ffffffh	;white
mov VolumeBarMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, SELECTOR
mov SelectorBMH, eax
invoke Get_Handle_To_Mask_Bitmap, SelectorBMH, 0ffffffh	;white
mov SelectorMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, MUTEBUTTON
mov MuteButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, MuteButtonBMH, 0ffffffh	;white
mov MuteButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, UNMUTEBUTTON
mov UnmuteButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, UnmuteButtonBMH, 0ffffffh	;white
mov UnmuteButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, ONBUTTON
mov OnButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, OnButtonBMH, 0ffffffh	;white
mov OnButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, OFFBUTTON
mov OffButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, OffButtonBMH, 0ffffffh	;white
mov OffButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, VOLUMEBUTTON
mov VolumeButtonBMH, eax
invoke Get_Handle_To_Mask_Bitmap, VolumeButtonBMH, 0ffffffh	;white
mov VolumeButtonMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, TIE
mov TieBMH, eax
invoke Get_Handle_To_Mask_Bitmap, TieBMH, 0ffffffh	;white
mov TieMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, P1WINS
mov P1WinsBMH, eax
invoke Get_Handle_To_Mask_Bitmap, P1WinsBMH, 0ffffffh	;white
mov P1WinsMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, P2WINS
mov P2WinsBMH, eax
invoke Get_Handle_To_Mask_Bitmap, P2WinsBMH, 0ffffffh	;white
mov P2WinsMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, WIN
mov YouWinBMH, eax
invoke Get_Handle_To_Mask_Bitmap, YouWinBMH, 0ffffffh	;white
mov YouWinMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, LOSE
mov YouLoseBMH, eax
invoke Get_Handle_To_Mask_Bitmap, YouLoseBMH, 0ffffffh	;white
mov YouLoseMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, COUNTGO
mov CountGoBMH, eax
invoke Get_Handle_To_Mask_Bitmap, CountGoBMH, 0ffffffh	;white
mov CountGoMaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, COUNT1
mov Count1BMH, eax
invoke Get_Handle_To_Mask_Bitmap, Count1BMH, 0ffffffh	;white
mov Count1MaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, COUNT2
mov Count2BMH, eax
invoke Get_Handle_To_Mask_Bitmap, Count2BMH, 0ffffffh	;white
mov Count2MaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, COUNT3
mov Count3BMH, eax
invoke Get_Handle_To_Mask_Bitmap, Count3BMH, 0ffffffh	;white
mov Count3MaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, COUNT4
mov Count4BMH, eax
invoke Get_Handle_To_Mask_Bitmap, Count4BMH, 0ffffffh	;white
mov Count4MaskBMH, eax

invoke GetModuleHandle, NULL
invoke LoadBitmap, eax, COUNT5
mov Count5BMH, eax
invoke Get_Handle_To_Mask_Bitmap, Count5BMH, 0ffffffh	;white
mov Count5MaskBMH, eax

mov eax, Color1
and eax, 07E7E7Eh
shr eax, 1
mov ebx, Color1
and ebx, 0808080h
or eax, ebx
mov Darker1, eax

mov eax, Color2
and eax, 07E7E7Eh
shr eax, 1
mov ebx, Color2
and ebx, 0808080h
or eax, ebx
mov Darker2, eax

mov eax, Color1
and eax, 07f7f7fh
shl eax, 1
mov Lighter1, eax

mov eax, Color2
and eax, 07f7f7fh
shl eax, 1
mov Lighter2, eax

invoke ShowWindow, hWnd, SW_SHOW ;Show it
invoke SetTimer, hWnd, MAIN_TIMER_ID, 20, NULL ;Set the repaint timer

msgLoop:
invoke GetMessage, addr msg, hWnd, 0, 0 ;Retrieve the messages from the window 
invoke DispatchMessage, addr msg ;Dispatches a message to the window procedure
jmp msgLoop
invoke ExitProcess, 1
main ENDP
end main