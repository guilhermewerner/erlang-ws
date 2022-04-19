%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(erws_app).
-behaviour(application).

%% API.
-export([start/2, stop/1]).

%% API.
start(_Type, _Args) ->
    erws_sup:start_link().

stop(_State) ->
    ok = cowboy:stop_listener(http).
