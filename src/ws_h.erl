-module(ws_h).

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).

init(Req, Opts) ->
    {cowboy_websocket, Req, Opts}.

websocket_init(State) ->
    erlang:start_timer(1000, self(), <<"Ola!">>),
    {[], State}.

websocket_handle({text, Msg}, State) ->
    {[{text, <<"Voce disse: ", Msg/binary>>}], State};
websocket_handle(_Data, State) ->
    {[], State}.

websocket_info({timeout, _Ref, Msg}, State) ->
    %erlang:start_timer(1000, self(), <<"Tudo bem?">>),
    {[{text, Msg}], State};
websocket_info(_Info, State) ->
    {[], State}.
