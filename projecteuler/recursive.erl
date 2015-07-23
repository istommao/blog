#!/usr/bin/env escript

%%%-------------------------------------------------------------------
%%% @author zhuwei
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. 七月 2015 下午2:00
%%%-------------------------------------------------------------------
-module(recursive).
-author("zhuwei").

%% API
-export([sum_list/1
        ,fib/1
        ]).

sum_list(T) when is_integer(T) ->
  sum_list([T]);
sum_list(T) when is_list(T) ->
  sum_list(T, 0);
sum_list(_T) ->
  erlang:error(badarity, "arity must be integer or list").

sum_list([], Acc) ->
  Acc;
sum_list([H|T], Acc) ->
  sum_list(T, H + Acc).

%% 1, 2, 3, 5
fib(N) when is_integer(N) ->
  fib(N, 1, 2);
fib(_N) ->
  erlang:error(badarity, "arity must be integer or list").

fib(1, Acc1, _Acc2) ->
  Acc1;
fib(2, _Acc1, Acc2) ->
  Acc2;
fib(N, Acc1, Acc2) ->
  fib(N-1, Acc2, Acc1 + Acc2).


main(_) ->
  io:format("sum_list 10: ~p~n", [sum_list(10)]),
  io:format("sum_list [2, 9, 10]: ~p~n", [sum_list([2, 9, 10])]),

  io:format("fib1 : ~p, fib2: ~p~n", [fib(1), fib(2)]),
  io:format("fib(10) = 89 = ~p~n", [fib(10)]),
  ok.
