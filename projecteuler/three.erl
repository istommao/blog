#!/usr/bin/env escript
%%%-------------------------------------------------------------------
%%% @author zhuwei
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 七月 2015 下午8:01
%%%-------------------------------------------------------------------
-module(three).
-author("zhuwei").
-mode(compile).

%% API
-export([main/1]).

helper(N) ->
  SqrtN = round(math:sqrt(N)),
  MaxFactor = 1,
  InitFactor = 2,
  max_factor_prime(InitFactor, SqrtN, N, MaxFactor).

max_factor_prime(_InitFactor, 0, _N, MaxFactor) ->
  MaxFactor;
max_factor_prime(InitFactor, SqrtN, N, MaxFactor) ->
  if (N rem InitFactor =:= 0) ->
    if (MaxFactor < InitFactor) ->
      max_factor_prime(InitFactor + 1, SqrtN-1, N div InitFactor, InitFactor);
      'true' -> max_factor_prime(InitFactor + 1, SqrtN-1, N div InitFactor, MaxFactor)
    end;
    'true' -> max_factor_prime(InitFactor+1, SqrtN-1, N, MaxFactor)
  end.

main(_) ->
  io:format("~p~n", [helper(600851475143)]),
  'ok'.
