#!/usr/bin/env escript

%%%-------------------------------------------------------------------
%%% @author zhuwei
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. 八月 2015 下午9:47
%%%-------------------------------------------------------------------
-module(fifteen).
-author("zhuwei").

%% API
-export([]).

all_paths(X, Y) when X =:= 0 orelse Y =:= 0 ->
  1;
all_paths(X, Y) ->
  all_paths(X - 1, Y) + all_paths(X, Y - 1).

main(_) ->
  io:format("all paths: ~p~n", [all_paths(2, 2)]),
  'ok'.
