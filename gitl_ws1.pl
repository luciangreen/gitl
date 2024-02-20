% Web server - finds differences between last saved version and current changes

ws_html(Repository1,HTML1) :-

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
 (open_file_s(N_path,N),
 
 

 %N1 is N+1,
 
 %(N=0->N0=N1;N0=N),
 foldr(string_concat,[Gitl_data_path1,Repository,"/",N,"/"],To_m_1),
 %foldr(string_concat,[Gitl_data_path1,Repository,"/",N1,"/"],To1),

 %trace,

 %(N0=0->
 
 
 
 
 %((%To=To1,
 %(N1=1->(scp1(Repository_root_path,Repository,Gitl_data_path1,N1,R1,N_path),

 %HTML=(-));
 %(

 find_files(To_m_1,Tests1)
 );Tests1=[]),

 find_files(R1,RTests),

 findall([T1a,BA],(member([T1,BA],RTests),string_concat(R1,T1a,T1)),R110),


 To=R1,

(sd2(R110,Tests1,RTests,R1,To_m_1,Repository_root_path,Repository,Gitl_data_path1,N,R1,N_path,To,HTML)
 ->HTML1=HTML;
 HTML1=(-)),

 !.
 
sd2(R110,Tests1,RTests,R1,To_m_1,_Repository_root_path,_Repository,_Gitl_data_path1,_N1,R1,_N_path,To,HTML) :-

%trace,
 
 %findall(T1a,(member([T1,_],RTests),string_concat(R1,T1a,T1)),R11),
 findall(T1a,(member([T1,_],Tests1),string_concat(To_m_1,T1a,T1)),T11),
 findall([T1a,BA],(member([T1,BA],Tests1),string_concat(To_m_1,T1a,T1)),T110),

 %trace,

 not(T110=R110),
 


 %scp1(Repository_root_path,Repository,Gitl_data_path1,N1,R1,N_path), 
 
 %find_files(To,Tests2),
 Tests2=RTests,
 %trace,
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
 diff_gitl(IT111,IT121,C)),CA),
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
 
 diff_gitl(C1,HTML).
  
   