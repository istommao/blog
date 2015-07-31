#!/usr/bin/env escript
%%%-------------------------------------------------------------------
%%% @author zhuwei
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. 七月 2015 下午1:57
%%%-------------------------------------------------------------------
-module(four).
-author("zhuwei").

%% API
-export([]).

max_divisor(Number) ->
  max_divisor(Number, 1).

max_divisor(Number, Div) ->
  case round(Number div Div) >= 10 of
    'false' -> Div;
    'true' -> max_divisor(Number, Div * 10)
  end.


is_palindrome(Number) when Number < 0 ->
  'false';
is_palindrome(Number) ->
  MaxDiv = max_divisor(Number),
  is_palindrome(Number, MaxDiv).

is_palindrome(Number, _Div) when Number =:= 0 ->
  'true';
is_palindrome(Number, Div) ->
  Left = round(Number div Div),
  Right = Number rem 10,
  if Left =/= Right -> 'false';
    'true' -> is_palindrome(round((Number rem Div) div 10), round(Div div 100))
  end.


max_three_digit_product_palindrome(I, J) ->
  max_three_digit_product_palindrome(I, J, 1, J).

max_three_digit_product_palindrome(0, 0, MaxAnswer, OrgJ) ->
  MaxAnswer;
max_three_digit_product_palindrome(I, 0, MaxAnswer, OrgJ) ->
  max_three_digit_product_palindrome(I - 1, OrgJ, MaxAnswer, OrgJ);
max_three_digit_product_palindrome(I, J, MaxAnswer, OrgJ) ->
  case is_palindrome(I * J) of
    'true' ->
        if (I * J > MaxAnswer) -> max_three_digit_product_palindrome(I, J - 1, I * J, OrgJ);
          'true' -> max_three_digit_product_palindrome(I, J - 1, MaxAnswer, OrgJ)
        end;
    'false' ->
      max_three_digit_product_palindrome(I, J - 1, MaxAnswer, OrgJ)
  end.



main(_) ->
  io:format("999: ~p~n", [is_palindrome(999)]),
  io:format("191: ~p~n", [is_palindrome(191)]),
  io:format("299: ~p~n", [is_palindrome(299)]),
  io:format("906609: = ~p~n", [max_three_digit_product_palindrome(999, 999)]),
  io:format("22: ~p~n", [is_palindrome(22)]).



