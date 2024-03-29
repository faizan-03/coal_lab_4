;<---------------------Description------------------------->
;	ROCK PAPER SCISSOR GAME
;	Used functions
;	ASCII (ROCK,SCISSOR,GAME LOGO,PAPER)
;	RANDOM NUMBER GENERATE FOR COMPUTER CHOICE
;	RANDOM NUMBER GENERATE FOR USER CHOICE
;	STORE GAME REULT AND SHOW PREVIOUS SCORE



   ;project rock paper scissor game
   ;rock=1,paper=2,scissor=3

include irvine32.inc
include macros.inc
max = 20
.data
user_score dd 0
computer_choose dd ?
user_choose dd ?
computer_score dd 0
check dd ?
u_file_1 byte "username.txt",0
u_file_2 byte "userscore.txt",0
u_file_h_1 handle ?
u_file_h_2 handle ?

user_name dd max dup(?)
u_s dd 3 dup(?)
u_name dd ?
arr1 dd 5 dup(?)

.code

display_game proc
call crlf
mwrite"						+-+-+-+-+ +-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+ ",0
call crlf
mwrite"						|R|O|C|K| |P|A|P|E|R| |S|C|I|S|S|O|R| |G|A|M|E|	",0
call crlf
mwrite"						+-+-+-+-+ +-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+   ",0                                                          
call crlf                                                                                                                                                                                   
ret
display_game endp
						;Scissor ASCII ART
scissor proc
call crlf
mwrite "    _______",0
call crlf
mwrite "---'   ____)____",0
call crlf
mwrite "          ______)",0
call crlf
mwrite "       __________)	SCISSOR",0
call crlf
mwrite "      (____)",0
call crlf
mwrite "---.__(___)",0
call crlf
ret
scissor endp
							;ROCK ASCII ART
rock proc

call crlf
mwrite "    _______ ",0
call crlf
mwrite "---'   ____) ",0
call crlf
mwrite "      (_____)",0
call crlf
mwrite "      (_____)		ROCK",0
call crlf
mwrite "      (____)",0
call crlf
mwrite "---.__(___)",0
call crlf

ret
rock endp
								;PAPER ASCII ART
paper proc
call crlf
mwrite"     _______",0
call crlf
mwrite"---'    ____)____",0
call crlf
mwrite"           ______)",0
call crlf
mwrite"          _______)	PAPER",0
call crlf
mwrite"         _______)",0
call crlf
mwrite"---.__________)",0
call crlf
ret
paper endp

rules proc
call crlf
mwrite  "---------------------------------",0
call crlf
call crlf
mwrite "|  1.Rock Wins Against Scissor  |",0
call crlf
call crlf
mwrite  "|  2.Scissor Wins Against Paper |",0
call crlf
call crlf
mwrite  "|  3.Paper Wins Against Rock    |",0
call crlf
call crlf
mwrite  "---------------------------------",0
call crlf

ret
rules endp

						;GENERATE RANDOM NUMBER FOR COMPUTER CHOICE
computer proc
mov eax,3
call randomrange
inc eax
mov computer_choose,eax
ret
computer endp
						;USER PREVIOUS SCORE
highest_score proc
mov edx,offset u_file_1
call openinputfile
mov u_file_h_1,eax
mwrite "User Name: ",0
mov edx,offset user_name
mov eax,u_file_h_1
mov ecx,20
call readfromfile
mov edx,offset user_name
mov ecx,20
call writestring
mov eax,u_file_h_1
call closefile

mov edx,offset u_file_2
call openinputfile
mov u_file_h_2,eax
mov edx,offset u_s
mov ecx,1
call readfromfile
call crlf
mwrite "User Previous Score: ",0
mov edx,offset u_s
mov eax,u_file_h_2
mov ecx,1
call writestring
mov eax,u_file_h_2
call closefile
call crlf
call  waitmsg
ret
highest_score endp


						;GAME START
game_start proc
mov user_score,0
mov computer_score,0
mov check,5
start:
.while check>=1

.if user_score==9
mwrite "You Have reached the score limit ,You have defeated the computer badly ",0
call crlf
call waitmsg
call crlf
jmp exit1
.endif

call computer
mwrite "User Health :",0
mov eax,check
call writedec
call crlf
;mov eax,computer_choose
;call writedec
mwrite "Enter Your Choice(Rock=1,Paper=2,Scissor=3,Exit=4): ",0
call readdec
mov user_choose,eax

.if user_choose==1 && computer_choose==1
mwrite"User Choose:",0
call crlf
call rock
call crlf
mwrite"Computer Choose:",0
call crlf
call rock
call crlf
mwrite "Tie Match",0
call crlf

call waitmsg
call clrscr
call display_game
jmp start


.elseif user_choose==2 && computer_choose==2
mwrite"User Choose:",0
call crlf
call paper
call crlf
mwrite"Computer Choose:",0
call crlf
call paper
call crlf
mwrite "Tie Match",0
call crlf

call waitmsg
call clrscr
call display_game
jmp start


.elseif user_choose==3 && computer_choose==3
mwrite"User Choose:",0
call crlf
call scissor
call crlf
mwrite"Computer Choose:",0
call crlf
call scissor
call crlf
mwrite "Tie Match",0
call crlf

call waitmsg
call clrscr
call display_game
jmp start



.elseif user_choose==1 && computer_choose==2
mwrite"User Choose:",0
call crlf
call rock
call crlf
mwrite"Computer Choose:",0
call crlf
call paper
call crlf
mwrite "Computer Win!",0
dec check
call crlf
inc computer_score
mwrite "Score Board: User= ",0
mov eax,user_score
call writedec
mwrite ", Computer= ",0
mov eax,computer_score
call writedec
call crlf

call waitmsg
call clrscr
call display_game
jmp start


.elseif user_choose==2 && computer_choose==1
mwrite"User Choose:",0
call crlf
call paper
call crlf
mwrite"Computer Choose:",0
call crlf
call rock
call crlf
mwrite "User Win!",0
call crlf
inc user_score
mwrite "Score Board: User= ",0
mov eax,user_score
call writedec
mwrite ", Computer= ",0
mov eax,computer_score
call writedec
call crlf


call waitmsg
call clrscr
call display_game
jmp start


.elseif user_choose==1 && computer_choose==3
mwrite"User Choose:",0
call crlf
call rock
call crlf
mwrite"Computer Choose:",0
call crlf
call scissor
call crlf
mwrite "User Win!",0
call crlf
inc user_score
mwrite "Score Board: User= ",0
mov eax,user_score
call writedec
mwrite ", Computer= ",0
mov eax,computer_score
call writedec
call crlf

call waitmsg
call clrscr
call display_game
jmp start


.elseif user_choose==3 && computer_choose==1
mwrite"User Choose:",0
call crlf
call scissor
call crlf
mwrite"Computer Choose:",0
call crlf
call rock
call crlf
mwrite "Computer Win!",0
dec check
call crlf
inc computer_score
mwrite "Score Board: User= ",0
mov eax,user_score
call writedec
mwrite ", Computer= ",0
mov eax,computer_score
call writedec
call crlf

call waitmsg
call clrscr
call display_game
jmp start



.elseif user_choose==2 && computer_choose==3
mwrite"User Choose:",0
call crlf
call paper
call crlf
mwrite"Computer Choose:",0
call crlf
call scissor
call crlf
mwrite "Computer Win!",0
dec check
call crlf
inc computer_score
mwrite "Score Board: User= ",0
mov eax,user_score
call writedec
mwrite ", Computer= ",0
mov eax,computer_score
call writedec
call crlf

call waitmsg
call clrscr
call display_game
jmp start


.elseif user_choose==3 && computer_choose==2
mwrite"User Choose:",0
call crlf
call scissor
call crlf
mwrite"Computer Choose:",0
call crlf
call paper
call crlf
mwrite "User Win!",0
call crlf
inc user_score
mwrite "Score Board: User= ",0
mov eax,user_score
call writedec
mwrite ", Computer= ",0
mov eax,computer_score
call writedec
call crlf

call waitmsg
call clrscr
call display_game
jmp start


.else
.if user_choose==4
jmp exit1
.endif
mwrite "Please Enter Valid Input: ",0
call crlf
.endif


.endw

call clrscr
call crlf

exit1:
mwrite "User Total Score : ",0
mov eax,user_score
call writedec
call crlf
mwrite "Computer Total Score :",0
mov eax,computer_score
call writedec
call crlf

mov esi,offset arr1
mov ebx,user_score
add ebx,48
mov eax,ebx
mov [esi],eax
mov edx,offset u_file_2
call createoutputfile
mov u_file_h_2,eax
mov edx,offset arr1
mov ecx,2
mov eax,u_file_h_2
call writetofile
mov eax,u_file_h_2
call closefile


mov eax,user_score
.if eax>computer_score
mwrite "User Win!",0
.elseif computer_score>eax
mwrite "Computer Win!",0
.else
mwrite "Match Tie",0
.endif
call crlf
call waitmsg
ret
game_start endp

					;MAIN FUNCTION
main proc
l:
call display_game   ;logo
;call rules

mwrite "		M A N E  M E N U ",0
call crlf
mwrite "1- Play Game: ",0
call crlf
mwrite "2- Show Game Rules: ",0
call crlf
mwrite "3- Show User Previous Score: ",0
call crlf
mwrite "4- Exit Main Menu: ",0
call crlf
mwrite "-> ",0
call readdec
.if eax==1
call clrscr
mwrite "Enter User Name: ",0
mov edx,offset user_name
mov ecx,max
call readstring
mov u_name,eax
mov edx,offset u_file_1
call createoutputfile
mov u_file_h_1,eax
mov edx,offset user_name
mov ecx,u_name
mov eax,u_file_h_1

call writetofile
mov eax,u_file_h_1
call closefile
call display_game   ;logo
call game_start
call clrscr
jmp l
.elseif eax==2
call clrscr
call rules
call waitmsg
call clrscr
jmp l
.elseif eax==3
call highest_score
call clrscr
jmp l
.elseif eax==4
call crlf
jmp next
.else
call crlf
mwrite "Invalid Input",0
call crlf
call waitmsg

jmp l
.endif

next:
call clrscr
exit
main endp
end main