% swipl -q -s "sync_gitl_data_to_vps.pl" -g "sync_gitl_data_to_vps(<rep_name>, <user>, x.x.x.x)." -t halt
% note: args must be wrapped in \"

%:- module(gitl_vps_sync, [
%    sync_gitl_data_to_vps/3,
%    restore_gitl_data_from_vps_if_newer/3
%]).

:-include('../listprologinterpreter/listprolog.pl').
:-include('../Text-to-Breasonings/la_vps.pl').
:-include('gitl_vps_paths.pl').

% sync_gitl_data_to_vps(+RepName, +User, +Host)
% Example call:
%   sync_gitl_data_to_vps('my_repo', 'lucian', 'x.x.x.x').
%
% Effect:
%   Deletes the gitl_data/<rep_name> folder on the VPS and copies
%   the local folder to the VPS.
sync_gitl_data_to_vps(RepName, User, Host) :-
    local_gitl_data_path(RepName, LocalPath),
    vps_gitl_data_path(RepName, User, Host, RemotePath),	
	
	atom_replace(LocalPath, '~', '~~', SafeLocalPath),
	format("  Local:  ~w~n", [SafeLocalPath]),

	atom_replace(RepName,'~', '~~', SafeRepName),
    format("Syncing local → VPS for ~w~n", [SafeRepName]),

    format("  Local:  ~w~n", [SafeLocalPath]),

	atom_replace(RemotePath, '~', '~~', SafeRemotePath),
    format("  Remote: ~w~n", [SafeRemotePath]),

    % Delete the remote directory and copy the local one
    (delete_directory_sh(RemotePath)->true;true),
   
    gitl_data_base(Base),
    
	atom_replace(Base, '~', '~~', SafeBase1),
	atom_concat('~/',SafeBase1,SafeBase),
	atom_replace(RepName, '~', '~~', SafeRepName),
	
	foldr(string_concat,["ssh ",User,"@",Host," 'mkdir -p ",SafeBase,"/",SafeRepName,"'"],S1),
	(catch(shell1_s1(S1),_,fail)->true;(writeln("Cannot access VPS and create folder."),abort)),

	atom_concat(LocalPath,'*',LocalPath2),
	atom_concat(RemotePath,'.',RemotePath2),

    cp(LocalPath2, RemotePath2),
    
    print_message(information,"sync_gitl_data_to_vps successful.").
    
