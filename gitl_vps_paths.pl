% Adjust base as needed
gitl_data_base("Dropbox/GitHub/gitl_data").

local_gitl_data_path(RepName, Path) :-
    get_home(Home),
    gitl_data_base(P),
    atomic_list_concat([Home, "/",P,"/", RepName,"/"], Path).
    
vps_gitl_data_path(RepName, User, Host, RemotePath) :-
    gitl_data_base(Base),
    
	atom_replace(Host, '~', '~~', SafeHost),
	atom_replace(Base, '~', '~~', SafeBase1),
	atom_concat('~/',SafeBase1,SafeBase),
	atom_replace(RepName, '~', '~~', SafeRepName),

    format(atom(RemotePath),
           "~w@~w:~w/~w/",
           [User, SafeHost, SafeBase, SafeRepName]).    
           
get_home(Home) :-
    expand_file_name("~", [Home]).