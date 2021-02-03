#!/bin/bash
nohup "$@" &>/dev/null & disown %%
