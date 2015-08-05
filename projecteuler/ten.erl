#!/usr/bin/env escript

%%%-------------------------------------------------------------------
%%% @author zhuwei
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. 八月 2015 下午1:24
%%%-------------------------------------------------------------------
-module(ten).
-author("zhuwei").
-mode(compile).
%% API
-export([]).

is_prime(Number) when Number < 2 ->
  'false';
is_prime(Number) ->
  is_prime(Number, round(math:sqrt(Number))).

is_prime(_Number, Acc) when Acc =:= 1 ->
  'true';
is_prime(Number, Acc) ->
  case Number rem Acc =/= 0 of
    'true' -> is_prime(Number, Acc - 1);
    'false' -> 'false'
  end.


main(_) ->
  Sum = lists:foldl(fun(X, Acc) -> X + Acc end, 0
                    ,lists:filter(fun is_prime/1, lists:seq(2, 2000000))),
  io:format("sum: ~p~n", [Sum]),

  'ok'.
