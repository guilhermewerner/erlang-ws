-module(ws_h).

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).

init(Req, Opts) ->
	{cowboy_websocket, Req, Opts}.

websocket_init(Req) ->
    chat_room:enter(self()),
    {ok, Req}.

websocket_handle({text, Msg}, Req, State) ->
    chat_room:send_message(self(), Msg),
    {ok, Req, State};
websocket_handle(_Data, Req, State) ->
    {ok, Req, State}.

websocket_info({send_message, _ServerPid, Msg}, Req, State) ->
    {reply, {text, Msg}, Req, State};
websocket_info(_Info, Req, State) ->
    {ok, Req, State}.

websocket_terminate(_Reason, _Req, _State) ->
    chat_room:leave(self()),
    ok.
