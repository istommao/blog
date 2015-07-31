#!/usr/bin/env escript

%%%-------------------------------------------------------------------
%%% @author zhuwei
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 31. 七月 2015 下午8:12
%%%-------------------------------------------------------------------
-module(five).
-author("zhuwei").

%% API
-export([]).

gcd(Num1, Num2) ->
  case Num1 < Num2 of
    'true' ->
      if Num2 rem Num1 =:= 0 ->
        Num1;
        'true' -> gcd(Num1, Num2 rem Num1)
      end;
    'false' ->
      if Num1 rem Num2 =:= 0 ->
        Num2;
        'true' -> gcd(Num2, Num1 rem Num2)
      end
  end.

smallest_multiple(N) ->
  smallest_multiple(N, 1, 1).

smallest_multiple(N, I, NN) when I =:= N ->
  NN;
smallest_multiple(N, I, NN) ->
  smallest_multiple(N, I+1, I * NN div gcd(I, NN)).


main(_) ->
  io:format("1: ~p~n", [gcd(2, 3)]),
  io:format("3: ~p~n", [gcd(3, 6)]),
  io:format("3: ~p~n", [gcd(9, 6)]),
  io:format("20: ~p~n", [smallest_multiple(20)]).


