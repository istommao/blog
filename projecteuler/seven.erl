#!/usr/bin/env escript

%%%-------------------------------------------------------------------
%%% @author zhuwei
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. 八月 2015 下午10:12
%%%-------------------------------------------------------------------
-module(seven).
-author("zhuwei").

%% API
-export([]).

is_prime(N) when N =< 1 ->
  'false';
is_prime(N) ->
  is_prime(N, 2).

is_prime(N, Acc) ->
  case Acc =:= round(math:sqrt(N)) + 1 of
    'true' -> 'true';
    'false' ->
      case N rem Acc of
        0 -> 'false';
        _ -> is_prime(N, Acc + 1)
      end
  end.


the_nth_prime(N) ->
  the_nth_prime(N, 0, 2).

the_nth_prime(N, Acc, Prime) when Acc =:= N ->
  Prime - 1;
the_nth_prime(N, Acc, Prime) ->
  case is_prime(Prime) of
    'true' -> the_nth_prime(N, Acc+1, Prime+1);
    'false' -> the_nth_prime(N, Acc, Prime+1)
  end.

main(_) ->
  io:format("3 ~p~n", [is_prime(2)]),
  io:format("6 ~p~n", [is_prime(6)]),
  io:format("10001 ~p~n", [the_nth_prime(10001)]).


