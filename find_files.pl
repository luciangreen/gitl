find_files(A1,Mod_time) :-
%trace,

working_directory1(A,A),
working_directory1(_,A),


%repositories_paths(K),

%omit_paths(Omit),

%findall(Omit1,(member(Omit2,Omit),atom_string(Omit1,Omit2)),Omit3),
/*K01=[[A1,[A1]]],
%findall([A1,G4],(%member(K1,[A]),
trace,
 %directory_files("./",F),
%	delete_invisibles_etc(F,G1),
	
%delete(G1,"n.txt",G11),
%findall(H,(member(H,G),not(string_concat("dot",_,H)),

%subtract(G,Omit,G1),

%findall(G3,(member(G2,G1),string_concat(G2,"/",G3)),G4)
%not(member(G,Omit))

%),K01),
%trace,
%foldr(append,K0,K01),

working_directory1(Old_D,Old_D),

findall(Tests1,(member([D,K31],K01),

working_directory1(_,Old_D),

working_directory1(_,D),
*/
%member(K2,K31),

%exists_directory(K2),
/*
writeln1(process_directory_ff_tests_ff_ff_ff([A1],%K31,%_G,
 %Omit,%
 true,
 Tests1)),
 */
 process_directory_ff([A1],%_G,
 %Omit,%
 true,
 Mod_time2),%),Mod_time)
 %),Mod_time2),
 foldr(append,Mod_time2,Mod_time),
 %foldr(append,Mod_time3,Mod_time),
 
 
 working_directory1(_,A)

 ,!.

process_directory_ff(K,%G,
 Top_level,%Mod_time1,
 Mod_time61) :-

%G=K,
%/*
findall(K4,(member(K1,K), directory_files(K1,F),
	delete_invisibles_etc(F,G),
%*/
findall(Mod_time3,(member(H,G),%not(string_concat("dot",_,H)),

%not(member(H,Omit)),


foldr(string_concat,[K1,H],H1),

% if a file then find modification date
% if a folder then continue finding files in folder
(exists_directory(H1)->

(string_concat(H1,"/",H2),
process_directory_ff([H2],%[H],
 false,%[],%Omit % only omit top level dirs xx
 %Mod_time1,
 Mod_time3)
 %foldr(append,Mod_time31,Mod_time3)
 );

(
open_string_file_s(H1,Tests31),
Mod_time3=[[H1,Tests31]]

%time_file(H1,Mod_time4),
%trace,
%append(Mod_time1,[[H1,Mod_time4]],Mod_time3)))
%Mod_time3=[[H1,Mod_time4]]
))

),Mod_time5),%trace,
foldr(append,Mod_time5,Mod_time51),

%Mod_time5=Mod_time51,

(Top_level=true%not(Omit=[]) % at top level
->
(
%term_to_atom(Mod_time51,Mod_time52),
Mod_time51=Mod_time52,
%string_concat(K3,"/",K1),
%foldr(string_concat,["../private2/luciancicd-data/mod_times_",K3,".txt"],K2),
K4=%K2,
Mod_time52
%open_s(K2,write,S),
%write(S,Mod_time52),close(S)

%writeln(["*",K2,
%Mod_time52]
%)
);
K4=Mod_time51
)



),Mod_time6),

(%not(Omit=[])->
Top_level=true->
Mod_time6=Mod_time61;
foldr(append,Mod_time6,Mod_time61)),

!.