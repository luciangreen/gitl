:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).

% we need this module from the HTTP client library for http_read_data
:- use_module(library(http/http_client)).
:- http_handler('/gitl', gitl_web_form, []).

%:-include('../SSI/ssi.pl').
%:-include('../SSI/ssi.pl').
%:-include('gitl1_pl.pl').

%:- include('files/listprolog.pl').

% show changes to all repos on page, allow selecting checkboxes of repos to commit or all 
% have anchor, link to top
% list of repos at top have notif icon, pass icon
% refresh time

:-dynamic num1/1.

gitl_server(Port) :-
        http_server(http_dispatch, [port(Port)]).

	/*
	browse http://127.0.0.1:8000/
	This demonstrates handling POST requests
	   */

	   gitl_web_form(_Request) :-
%retractall(html_api_maker_or_terminal(_)),
%assertz(html_api_maker_or_terminal(html
 %terminal
 %)),
 
 retractall(num1(_)),assertz(num1(1)),
			
			repository_root_path(RRP),atom_string(RRP1,RRP),
			working_directory(A3,A3),
			working_directory(_,RRP1),
																										              format('Content-type: text/html~n~n', []),
																			
data(Header,Footer),

format(Header,[]),

writeln("<h1 id=\"#Top\">GitL</h1><br><br>
<p><input onClick=\"setAllCheckboxes('repositories', this);\" type=\"checkbox\" />All</p>
<div id=\"repositories\">
<form action=\"/gitl_landing\" method=\"post\">"),
directory_files("./",F),
	delete_invisibles_etc(F,G),
	
	findall([N,H,H1,F1],(member(H,G),atom_string(H,HH),ws_html(HH,F1),%open_string_file_s(H,F11),
	get_num(N),
%(string_concat("log",_,H)->(term_to_atom(F111,F11),F111=[Success,F12],
((F1=(-))->Success1="<font color=\"black\"></font>";foldr(string_concat,["<font color=\"green\">CHANGED</font> <input type=\"checkbox\" name=\"",HH,"xxA\" /> Label: <input type=\"text\" name=\"",HH,"xxB\" />"],Success1)),foldr(string_concat,["<b>",Success1,"</b> - "],Success2),%);(F11=F12,Success2="")),	time_file(H,T),atomic_list_concat(A,"\n",F12),atomic_list_concat(A,"<br>",F1),
	foldr(string_concat,[Success2,"<a href=\"#",N,"\">",
	H,"</a>",
	"<br><br>"],H1)%,writeln(H1)
	),J0),
	
	sort(J0,J),
	%reverse(J1,J),
	
	findall(_,(member([_,_,H1,_],J),writeln(H1)),_),
	
	writeln("<input type=\"submit\" value=\"Commit\">"),
	
	findall(_,(member([N,H,_,F1],J),foldr(string_concat,["<h2 id=\"",N,"\">",H,"</h2><a href=\"#Top\">Top</a><br>",F1,"<br><br>"],H2),writeln(H2)),_),
%Debug=off,

	%test_open_types_cases(4,Query,Types,Modes,Functions),

%international_lucianpl([lang,"en"],Debug,Query,Types,Modes,Functions,_Result),
%p2lpconverter([file,"../private/la_com_ssi1.pl"],List3),

%testopen_cases(8,[[n,test]],List3),
	%test(1,Query,Functions,Result),

% Form and HTML Table
%test1(Functions),	
%Query=[[n,test]],
	%gitl_test(List3),
	%para(List3),
	%international_lucianpl([lang,"en"],Debug,[[n,gitl]],List3,_Result1),
writeln("</div>
<a href=\"#Top\">Top</a>"),

			working_directory(_,A3),


format(Footer,[])

																								      .

						%term_to_atom(Debug2,'off'),
%term_to_atom(Query2,Query1),
%term_to_atom(Functions2,Functions1),

%international_interpret([lang,"en"],Debug2,Query2,Functions2,Result),
																														%%format('</p><p>========~n', []),
																															%%portray_clause
																															%portray_clause(result),
																																																															%%writeln1(Data),

%format('</p>').


data(Header,Footer) :-

Header='<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html lang="en">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>GitL</title>
    <style type="text/css"> 
<!-- 

A:link {text-decoration: none;} 
A:visited {text-decoration: none;} 
A:hover {text-decoration: underline;} 

img {
 height: auto;
 max-width: 100%;
 object-fit: contain;
} 

table {table-layout: fixed; width: 100%;}

td {word-wrap: break-word;}

--> 
  </style>
  
<script language="JavaScript">
function setAllCheckboxes(divId, sourceCheckbox) {
    divElement = document.getElementById(divId);
    inputElements = divElement.getElementsByTagName(\'input\');
    for (i = 0; i < inputElements.length; i++) {
        if (inputElements[i].type != \'checkbox\')
            continue;
        inputElements[i].checked = sourceCheckbox.checked;
    }
}
</script>
  
    <meta name="viewport" content="width=device-width, initial-scale=1">

  </head>
  <body style="background-color: rgb(255, 239, 227);">

   
    <div style="text-align: center;">
      <table width="80%">
        <tbody>
          <tr>
            <td>
              <p>',

Footer='</p>
            </td>
          </tr>
        </tbody>
      </table>
      <br>

    <br>
  </body>
</html>'.

get_num(A) :- num1(A),retractall(num1(_)),A1 is A+1,assertz(num1(A1)).



:- http_handler('/gitl_landing', gitl_landing_pad, []).

																								      gitl_landing_pad(Request) :-
																								              member(method(post), Request), !,
																									              http_read_data(Request, Data, []),
																										              format('Content-type: text/html~n~n', []),
																											      	format('<p>', []),
																												        %%portray_clause(Data),
																												        
																												        %%term_to_atom(Term,Data),
		%append(Data1,[submit=_],Data),

		findall(_,(member(HHa=O,Data),atom_concat(HH,'xxA',HHa),atom_concat(HH,'xxB',HH1a),(O=on->(member(HH1a=Label,Data),
		atomic_list_concat(B,"+",HH),%atomic_list_concat(B,"\\ ",HH1),
		atomic_list_concat(B," ",HH1),atom_string(HH1,HH2),
		(commit(HH2,Label)->(foldr(string_concat,[HH1," (with label: \"",Label,"\") was committed.<br>"],A),writeln(A));writeln([HH,not,committed]))))),_),																										        
%Data=[%%debug='off',%%Debug1,
%query=Query1,functions=Functions1,submit=_],

%term_to_atom(Debug2,'off'),
%term_to_atom(Query2,Query1),
%term_to_atom(Functions2,Functions1),

%international_interpret([lang,"en"],Debug2,Query2,Functions2,Result),
																														%%format('</p><p>========~n', []),
																															%%portray_clause
																															%portray_clause(Result),
																																																															%%writeln1(Data),

format('</p>').