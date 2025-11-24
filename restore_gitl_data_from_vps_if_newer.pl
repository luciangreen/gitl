% swipl -q -s "restore_gitl_data_from_vps_if_newer.pl" -g "restore_gitl_data_from_vps_if_newer(<rep_name>, <user>, x.x.x.x)." -t halt
% note: args must be wrapped in \"

:-include('../listprologinterpreter/listprolog.pl').
:-include('../Text-to-Breasonings/la_vps.pl').
:-include('gitl_vps_paths.pl').

% restore_gitl_data_from_vps_if_newer(+RepName, +User, +Host)
%
% Checks the modification time of the local and VPS gitl_data/<rep_name>
% folders using time_file_sh/2. If the VPS copy is newer, it replaces the
% local folder with the VPS folder.
restore_gitl_data_from_vps_if_newer(RepName, User, Host) :-
    local_gitl_data_path(RepName, LocalPath),
    vps_gitl_data_path(RepName, User, Host, RemotePath),

    (   time_file_sh(LocalPath, LocalTime)
    ->  true
    ;   LocalTime = 0    % Treat missing local as very old
    ),

    (   time_file_sh(RemotePath, RemoteTime)
    ->  true
    ;   RemoteTime = 0
    ),

    format("Comparing timestamps for repo ~w~n", [RepName]),
    format("  Local (~w):  ~w~n", [LocalPath, LocalTime]),
    format("  VPS   (~w):  ~w~n", [RemotePath, RemoteTime]),

    (   RemoteTime > LocalTime
    ->  format("VPS copy is newer; restoring VPS → local.~n", []),
        delete_directory_sh(LocalPath),

	atom_concat(RemotePath,'*',RemotePath2),
	atom_concat(LocalPath,'.',LocalPath2),

    cp(RemotePath2, LocalPath2)
    ;   format("Local copy is up-to-date or newer; not restoring.~n", [])
    ),
    
    print_message(information,"restore_gitl_data_from_vps_if_newer successful").
    