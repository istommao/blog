#mnesia

	case mnesia:create_table(push_msg_info,
	                             [{disc_copies, [node()]},
	                              {type, set},
	                              {attributes, record_info(fields, push_msg_info)}]) of
	        {atomic, ok} ->
	            io:format("tab: push_msg_info ==> ok, created~n");
	        {aborted,{already_exists,_}} ->
	            io:format("tab: push_msg_info ==> ok, already_exists~n");
	        {Reason} ->
	            io:format("tab: push_msg_info ==> ~p~n",[{error,Reason}]),
	            error({error,Reason})
	    end,
	
	    pong = net_adm:ping(MasterNode),
	
	    mnesia:stop(),
	    mnesia:delete_schema([node()]),
	    mnesia:start(),
	
	    mnesia:change_config(extra_db_nodes, [Node]),
	
	    mnesia:add_table_copy(push_msg_info, node(), ram_copies),
	    
	    
	    