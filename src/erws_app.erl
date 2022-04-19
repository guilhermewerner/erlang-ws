-module(erws_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", cowboy_static, {priv_file, erws, "index.html"}},
            {"/websocket", ws_h, []},
            {"/static/[...]", cowboy_static, {priv_dir, erws, "static"}}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(http, [{port, 5555}], #{
        env => #{dispatch => Dispatch}
    }),
    erws_sup:start_link().

stop(_State) ->
    ok = cowboy:stop_listener(http).
