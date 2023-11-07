diff(After3,HTML3) :-
diff1(After3,HTML2),
	string_concat("<b>Diff output</b><br><b>Key</b><table bgcolor=\"green\"><tr><td>Insertion</td></tr></table><br><table bgcolor=\"red\"><tr><td>Deletion</td></tr></table><br>",HTML2,HTML3).

diff1(After3,HTML3) :-
 %correspondences(Corr),
 
 findall(HTML_a,(member(Item%[[n,comment],[Item]]
 ,After3),

 (Item=[*, Name, Item_a] ->
 
 diff2(Name,Item_a,HTML_a);



 ((%trace,
 not(Item=[i,_]),
 not(Item=[d,_]))
 %string(Item)
 ->
 (Item=Item2,%numbers_to_term([Item],Corr,[],Item2),
 Colour="white",Change="");
 ((%trace,
 Item=[i,Item2])->
 (%trace,
 (Item2=[]->fail;true),
 %numbers_to_term([Item3],Corr,[],Item2),
 Colour="green",Change="Insertion: ");
 ((%trace,
 Item=[d,Item2])->
 (%trace,
 (Item2=[]->fail;true),
 %numbers_to_term([Item3],Corr,[],Item2),
 Colour="red",Change="Deletion: ")
 /*;
 (Item=[[c,_],Item_a,Item_b]->
 (numbers_to_term(Item_a,Corr,[],Item2a),
 numbers_to_term(Item_b,Corr,[],Item2b),
 %trace,
 %term_to_atom(Item2a,Item2a1),
 %term_to_atom(Item2b,Item2b1),
 %foldr(string_concat,
 term_to_atom([Item2b,' -> ',Item2a],Item2),
 Colour="yellow",Change="Change: "))
 */
 ))),
 
 HTML_a=["<table bgcolor=\"",Colour,"\"><tr><td>",Change,Item2,"</td></tr></table>"]
 
 )),HTML),
 flatten(HTML,HTML1),
 foldr(string_concat,HTML1,HTML3).
 
 
 diff2(Name,After3,HTML3) :-
 %correspondences(Corr),
 
 findall(["<table bgcolor=\"",Colour,"\"><tr><td>",Change,Item2,"</td></tr></table>"],(member(Item%[[n,comment],[Item]]
 ,After3),

%trace,
 ((not(Item=[i,_]),
 not(Item=[d,_]))
 %string(Item)
 ->
 (Item=Item2,%numbers_to_term([Item],Corr,[],Item2),
 Colour="white",Change="");
 ((%trace,
 Item=[i,Item2])->
 (%trace,
 (Item2=[]->fail;true),
 %numbers_to_term([Item3],Corr,[],Item2),
 Colour="green",Change="Insertion: ");
 ((%trace,
 Item=[d,Item2])->
 (%trace,
 (Item2=[]->fail;true),
 %numbers_to_term([Item3],Corr,[],Item2),
 Colour="red",Change="Deletion: ")
 /*;
 (Item=[[c,_],Item_a,Item_b]->
 (numbers_to_term(Item_a,Corr,[],Item2a),
 numbers_to_term(Item_b,Corr,[],Item2b),
 %trace,
 %term_to_atom(Item2a,Item2a1),
 %term_to_atom(Item2b,Item2b1),
 %foldr(string_concat,
 term_to_atom([Item2b,' -> ',Item2a],Item2),
 Colour="yellow",Change="Change: "))
 */
 )))),HTML),
 flatten(HTML,HTML1),
 foldr(string_concat,HTML1,HTML2),
 
 	foldr(string_concat,["<b>File name: ",Name,"<br>",HTML2],HTML3).
 %term_to_atom(HTML1,HTML2),

 	%time1(Time),
 	%diff_html_n(Diff_html_n),
	%(exists_directory_s("../../lc_logs/")->true;%make_directory_s("../../lc_logs/")),
	 
%foldr(string_concat,["../../lc_logs/diff_html",Time,"-",Diff_html_n,".html"],File1),

/*
	Diff_html_n1 is Diff_html_n+1,
	retractall(diff_html_n(_)),
	assertz(diff_html_n(Diff_html_n1)),
*/
	
 %save_file_s(File1,HTML3).

