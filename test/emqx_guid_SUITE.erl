%%--------------------------------------------------------------------
%% Copyright (c) 2013-2018 EMQ Enterprise, Inc.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(emqx_guid_SUITE).

-include_lib("eunit/include/eunit.hrl").

-compile(export_all).

all() -> [t_guid_gen, t_guid_hexstr, t_guid_base62].

t_guid_gen(_) ->
    Guid1 = emqx_guid:gen(),
    Guid2 = emqx_guid:gen(),
    <<_:128>> = Guid1,
    true = (Guid2 >= Guid1),
    {Ts1, _, 0} = emqx_guid:new(),
    Ts2 = emqx_guid:timestamp(emqx_guid:gen()),
    true = Ts2 > Ts1.

t_guid_hexstr(_) ->
    Guid = emqx_guid:gen(),
    ?assertEqual(Guid, emqx_guid:from_hexstr(emqx_guid:to_hexstr(Guid))).

t_guid_base62(_) ->
    Guid = emqx_guid:gen(),
    ?assertEqual(Guid, emqx_guid:from_base62(emqx_guid:to_base62(Guid))).

