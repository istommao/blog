#!/usr/bin/env escript

%%%-------------------------------------------------------------------
%%% @author zhuwei
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. 八月 2015 下午8:47
%%%-------------------------------------------------------------------
-module(six).
-author("zhuwei").

%% API
-export([]).

sum_square_difference(N) ->
  sum_square_difference(N, 0).

sum_square_difference(A, Ret) ->
  2 * sum_square_difference(A, A - 1, Ret).

sum_square_difference(A, _B, Ret) when A =:= 2 ->
  Ret + A;
sum_square_difference(A, B, Ret) when B =:= 1 ->
  sum_square_difference(A - 1, A - 2, Ret + A * B);
sum_square_difference(A, B, Ret) ->
  sum_square_difference(A, B - 1, Ret + A * B).

main(_) ->
  io:format("sum : ~p~n", [sum_square_difference(100)]).
