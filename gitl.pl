% GitL

% Moves a copy of a folder into the folder
% - adds a version number to the folder
% Diffs last two versions

:-include('diff.pl').
:-include('find_files.pl').
:-include('../luciancicd/ci_vintage.pl').
:-include('gitl_ws.pl').
:-include('gitl_ws1.pl').
:-include('../listprologinterpreter/listprolog.pl').

repository_root_path("../gitl_test/").
gitl_data_path("../gitl_data/").

commit(Repository1) :-

 (string_concat(Repository,"/",Repository1)->true;
 Repository=Repository1),
 
 working_directory1(A1,A1),

 repository_root_path(Repository_root_path),
 
(exists_directory_s(Repository_root_path)->true;make_directory(Repository_root_path)),

 gitl_data_path(Gitl_data_path1),
 
(exists_directory_s(Gitl_data_path1)->true;make_directory(Gitl_data_path1)),

  %trace,
  foldr(string_concat,[Repository_root_path,Repository,"/"],R1),
 (exists_directory_s(R1)->true;make_directory(R1)),

  foldr(string_concat,[Gitl_data_path1,Repository,"/"],R21),
 (exists_directory_s(R21)->true;make_directory(R21)),
%trace,

 foldr(string_concat,[Gitl_data_path1,Repository,"/","n.txt"],N_path),
 (exists_file_s(N_path)->
 open_file_s(N_path,N);
 (N=0,number_string(N,NS),save_file_s(N_path,NS))),

 N1 is N+1,
 
 (N=0->N0=N1;N0=N),
 foldr(string_concat,[Gitl_data_path1,Repository,"/",N0,"/"],To_m_1),
 foldr(string_concat,[Gitl_data_path1,Repository,"/",N1,"/"],To1),

 %trace,

 %(N0=0->
 
 
 
 
 ((To=To1,
 find_files(R1,RTests),
 (N1=1->(scp1(Repository_root_path,Repository,Gitl_data_path1,N1,R1,N_path),

 HTML=(-));
 (sd1(RTests,R1,To_m_1,Repository_root_path,Repository,Gitl_data_path1,N1,R1,N_path,To,HTML)))
 
)
 ->(

  %working_directory1(_,A1),

 

 %Gitl_data_path=R2,
 





  foldr(string_concat,[Gitl_data_path1,Repository,"/",N1,".html"],HTMLP),

 working_directory1(_,A1),
 (HTML=(-) ->true;
 save_file_s(HTMLP,HTML))
 );(writeln("Not committed. Folders identical."),abort)),!.
 
%open_string_file_s

%save_diff(N0,R1,To_m_1,To,HTML3) :-
%trace,

% .

scp1(Repository_root_path,Repository,Gitl_data_path1,N1,R1,N_path) :-

 (number_string(N1,N1S),save_file_s(N_path,N1S)),

%trace,
  foldr(string_concat,[Gitl_data_path1,Repository,"/",N1,"/"],R2),
 (exists_directory_s(R2)->true;make_directory(R2)),


 Scp="scp -pr ",
 foldr(string_concat,[Repository_root_path,Repository,"/*"],From1),
 
 atomic_list_concat(B," ",From1),
 atomic_list_concat(B,"\\ ",From),
 
 foldr(string_concat,[Gitl_data_path1,Repository,"/",N1,"/."],To_a1),

 atomic_list_concat(C," ",To_a1),
 atomic_list_concat(C,"\\ ",To_a),

 foldr(string_concat,[Scp,From," ",To_a],Command), 
 
 directory_files(R1,F),
	delete_invisibles_etc(F,G),
%trace,	
 (G=[]->true;
 shell1_s(Command)).

sd1(RTests,R1,To_m_1,Repository_root_path,Repository,Gitl_data_path1,N1,R1,N_path,To,HTML) :-

%trace,
 
 %findall(T1a,(member([T1,_],RTests),string_concat(R1,T1a,T1)),R11),
 findall([T1a,BA],(member([T1,BA],RTests),string_concat(R1,T1a,T1)),R110),

 find_files(To_m_1,Tests1),
 findall(T1a,(member([T1,_],Tests1),string_concat(To_m_1,T1a,T1)),T11),
 findall([T1a,BA],(member([T1,BA],Tests1),string_concat(To_m_1,T1a,T1)),T110),
 not(T110=R110),
 


 scp1(Repository_root_path,Repository,Gitl_data_path1,N1,R1,N_path), 
 
 find_files(To,Tests2),
 findall(T2b,(member([T2,_],Tests2),string_concat(To,T2b,T2)),T21),

 %trace,

 intersection(T11,T21,IT12),
 subtract(T11,T21,D),
 subtract(T21,T11,I),
 %trace,
 findall([A,B],(member([A1,B],Tests1),string_concat(To_m_1,A,A1)),Tests11),
 findall([A,B],(member([A1,B],Tests2),string_concat(To,A,A1)),Tests21),
 append(Tests11,Tests21,Tests3),
 findall([A1,B],(member(A,IT12),string_concat(To_m_1,A,A1),member([A1,B],Tests1)),IT11),
 findall([A1,B],(member(A,IT12),string_concat(To,A,A1),member([A1,B],Tests2)),IT123),
 %trace,
 length(IT11,IT11L),
 numbers(IT11L,1,[],Ns),
 

 findall([*,T1a,C],(member(NA,Ns),get_item_n(IT11,NA,[A1,B1]),string_concat(To_m_1,T1a,A1),get_item_n(IT123,NA,[_A2,B2]),
 split_string(B1,"\n\r","\n\r",IT111),
 split_string(B2,"\n\r","\n\r",IT121),
 %trace,
 diff(IT111,IT121,C)),CA),
 %trace,
 
 findall([*,A,[[i,B14]]],(member(A,I),%string_concat(To_m_1,A,A1),
 member([A,B],Tests3),split_string(B,"\n\r","\n\r",B1),
 findall([B11,"<br>"],member(B11,B1),B12),
 flatten(B12,B13),foldr(string_concat,B13,B14)),IT11a),
 findall([*,A,[[d,B14]]],(member(A,D),%string_concat(To,A,A1),
 member([A,B],Tests3),split_string(B,"\n\r","\n\r",B1),
 findall([B11,"<br>"],member(B11,B1),B12),
 flatten(B12,B13),foldr(string_concat,B13,B14)),IT123a),
 
 foldr(append,[IT11a,IT123a,CA],C1),
 
 diff(C1,HTML).
  
   
diff(Before,After,After3) :-
 find_insertions_and_deletions_vintage_old(Before,After,Insertions,Deletions),
 replace11_vintage(After,Insertions,[],[],After2),
 replace12_vintage(Before,After2,Deletions,[],After3)
 ,!.