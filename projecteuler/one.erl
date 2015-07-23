#!/usr/bin/env escript
%%%-------------------------------------------------------------------
%%% @author zhuwei
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. 七月 2015 下午1:15
%%%-------------------------------------------------------------------
-module(one).
-author("zhuwei").

%% API
-export([]).


%% sum(T) when is_integer(T) ->
%%   T;
%% sum(T) when is_list(T) ->
%%   sum(T, 0);
%% sum(_T) ->
%%   erlang:error(badarity).
%%
%% sum([], Acc) -> Acc;
%% sum([H|T], Acc) ->
%%   sum(T, H + Acc).

handler(N) ->


  L1 = [Data || Data <- lists:seq(1, N-1), Data rem 3 =:= 0 orelse Data rem 5 =:= 0],
  lists:sum(L1).
%%   io:format("Data ~p sum: ~p~n", [L1, sum(L1)]),
%%   ok.

main([N]) ->
  Sum = handler(list_to_integer(N)),
  io:format("Sum ~p~n", [Sum]).