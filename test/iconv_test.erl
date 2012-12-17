-module(iconv_test).

-include_lib("eunit/include/eunit.hrl").

mail_test_() ->
    {setup, fun iconv:start/0,
        fun(_) ->
                iconv:stop()
        end,
        [
            {"Convert from latin-1 to utf-8", fun latin2utf8/0}
            , {"Convert from latin-1 to utf-8", fun utf82latin/0}
            , {"Convert from windows-1251 to utf-8", fun windows2utf8/0}
            ]
    }.

latin2utf8() ->
    {ok, CD} = iconv:open("utf-8", "ISO-8859-1"),
    ?assertEqual({ok, <<"hello world">>}, iconv:conv(CD, "hello world")),
    iconv:close(CD).

utf82latin() ->
    {ok, CD} = iconv:open("ISO-8859-1", "utf-8"),
    ?assertEqual({ok, <<"hello world">>}, iconv:conv(CD, "hello world")),
    iconv:close(CD).

windows2utf8() ->
    {ok, CD} = iconv:open("utf-8", "windows-1251"),
    ?assertEqual(
        {ok, <<208,168,208,176,209,136,208,186,208,190,208,178,32,
               208,148,208,181,208,189,208,184>>},
        iconv:conv(CD, <<216,224,248,234,238,226,32,196,229,237,232>>)),
    iconv:close(CD).
