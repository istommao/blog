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
-mode(compile).

%% API
-export([sum_list/1
        ,fib/1
        ,main/1
        ,get_intersection_list/3
        ,pred1/2
        ,get_intersection_list2/2
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

%% ==========fibonacci==========
%% 1, 2, 3, 5
fib(N) when is_integer(N) ->
  fib(N, 1, 2);
fib(_N) ->
  erlang:error(badarity, "arity must be integer or list").

%% fib(N, 1, 2)
fib(1, Acc1, _Acc2) ->
  Acc1;
fib(2, _Acc1, Acc2) ->
  Acc2;
fib(N, Acc1, Acc2) ->
  fib(N-1, Acc2, Acc1 + Acc2).

%% 或者
%% fib(N, 1, 1)
%% fib(1, Acc1, _Acc2) ->
%%   Acc1;
%% fib(N, Acc1, Acc2) ->
%%   fib(N-1, Acc2, Acc1 + Acc2).

%% 或者
%% fib(N, 0, 1)
%% fib(0, Acc1, _Acc2) ->
%%   Acc1;
%% fib(1, _Acc1, Acc2) ->
%%   Acc2;
%% fib(N, Acc1, Acc2) ->
%%   fib(N-1, Acc2, Acc1 + Acc2).

pred1(_Elem, []) ->
  'false';
pred1(Elem, [H|T]) ->
  case Elem =:= H of
    'true' -> 'true';
    'false' -> pred1(Elem, T)
  end.

get_intersection_list(List1, List2, Fun) ->
  List3 = lists:filter(fun(X) -> Fun(X, List1) end, List2),
  io:format("List: ~p~n", [List3]).

get_intersection_list2(List1, List2) ->
  List3 = lists:filter(fun(X) ->
                        lists:any(fun(T) ->
                          case T == X of
                            'true' -> 'true';
                            'false' -> false end end,
                        List1) end,
                      List2),
  io:format("List: ~p~n", [List3]).

main(_) ->
%%   code:add_patha("../"),
  io:format("sum_list 10: ~p~n", [sum_list(10)]),
  io:format("sum_list [2, 9, 10]: ~p~n", [sum_list([2, 9, 10])]),

  io:format("fib1 : ~p, fib2: ~p~n", [fib(1), fib(2)]),
  io:format("fib(10) = 89 = ~p~n", [fib(10)]),

  List1 = ["c7b85d1ccb5b95f5f0b61c3508399f72", "23cc1a758af23b49ff1807f1489ec228", "7ac9c8c75a24672cc493e2016c9afd7c"],
  List2 = ["23cc1a758af23b49ff1807f1489ec228", "7ac9c8c75a24672cc493e2016c9afd7c"],
  List3 = ["df"],
  List4 = ["c7b85d1ccb5b95f5f0b61c3508399f72", "df"],

  io:format("intersection ~p~n", [List1 -- List1 -- List4]),

  get_intersection_list(List1, List2, fun pred1/2),
  get_intersection_list(List1, List3, fun pred1/2),
  get_intersection_list(List1, List4, fun pred1/2),

  get_intersection_list2(List1, List2),
  get_intersection_list2(List1, List3),
  get_intersection_list2(List1, List4),

  ok.
