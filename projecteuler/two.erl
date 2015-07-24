#!/usr/bin/env escript
%%%-------------------------------------------------------------------
%%% @author zhuwei
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. 七月 2015 下午1:37
%%%-------------------------------------------------------------------
-module(two).
-author("zhuwei").
-mode(compile).

%% API
-export([]).

fib(N) ->
  fib(N, 0, 1).

fib(0, Acc1, _Acc2) ->
  Acc1;
fib(1, _Acc1, Acc2) ->
  Acc2;
fib(N, Acc1, Acc2) ->
  fib(N-1, Acc2, Acc1+Acc2).

help(Fun, N, L, Max) ->
  case Fun(N) < Max of
    'true' ->
      case Fun(N) rem 2 =:= 0 of
        'true' ->
          help(Fun, N+1, [Fun(N) | L], Max);
        'false' ->
          help(Fun, N+1, L, Max)
      end;
    'false' ->
      L
  end.

help(L) ->
  Result = lists:foldl(fun(X, Sum) -> X + Sum end, 0, L),
  Result.

main(_) ->
  L1 = help(fun fib/1, 1, [], 4000000),
  io:format("sum(L1): ~p~n", [help(L1)]).



