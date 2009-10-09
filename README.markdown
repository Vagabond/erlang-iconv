About
=====

Erlang-iconv is a fork of the iconv in Jungerl. I pulled it out of jungerl
because I only wanted iconv, not all the other stuff in jungerl and because the
jungerl build system wasn't very helpful on anything but linux.

erlang-iconv has been built and tested on the following platforms:

* Linux
* FreeBSD
* OpenBSD
* OSX

It should also build on NetBSD and most other UNIX-like systems. I haven't
bothered to try on windows yet.

Usage
=====

Here's some sample usage converting some shift-jis text to utf-8:

<pre>
1> iconv:start().
{ok,<0.53.0>}
2> X = <<83,97,109,112,108,101,58,32,142,132,32,130,205,32,131,67,32,131,147,32,131,79,32,131,71,32,130,197,32,130,183,13,10>>.
<<83,97,109,112,108,101,58,32,142,132,32,130,205,32,131,
  67,32,131,147,32,131,79,32,131,71,32,130,197,32,...>>
3> io:format("~s~n", [X]).
Sample:
         Í C  O G Å ·

ok
4> io:format("~ts~n", [X]).
** exception exit: {badarg,[{io,format,
                                [<0.25.0>,"~ts~n",
                                 [<<83,97,109,112,108,101,58,32,142,132,32,130,205,32,
                                    131,67,32,131,147,...>>]]},
                            {erl_eval,do_apply,5},
                            {shell,exprs,6},
                            {shell,eval_exprs,6},
                            {shell,eval_loop,3}]}
     in function  io:o_request/3
5> {ok, CD} = iconv:open("utf-8", "shift-jis").
{ok,<<176,86,91,1,0,0,0,0>>}
6> {ok, Output} = iconv:conv(CD, X).
{ok,<<83,97,109,112,108,101,58,32,231,167,129,32,227,129,
      175,32,227,130,164,32,227,131,179,32,227,130,176,
      ...>>}
7> io:format("~ts~n", [Output]).
Sample: 私 は イ ン グ エ で す
8> iconv:close(CD).
ok
</pre>

As you can see, before we passed it through iconv it was an unprintable mess.


