#! /usr/bin/env python2
from subprocess import check_output
import os


def get_pass(account):
    return check_output("pass Mail/" + account, shell=True).splitlines()[0]

def get_oauth2_client_id(account):
    #output =  check_output("bash -c 'echo $OAUTH2_CLIENT_ID_{}'".format(account.upper()), shell=True).splitlines()[0]
    oauth = "OAUTH2_CLIENT_ID_"
    return get_token(oauth, account)

def get_oauth2_client_secret(account):
    #output =  check_output("bash -c 'echo $OAUTH2_CLIENT_SECRET_{}'".format(account.upper()), shell=True).splitlines()[0]
    oauth = "OAUTH2_CLIENT_SECRET_"
    return get_token(oauth, account)

def get_oauth2_refresh_token(account):
    #output =  check_output("bash -c 'echo $OAUTH2_REFRESH_TOKEN_{}'".format(account.upper()), shell=True).splitlines()[0]
    oauth = "OAUTH2_REFRESH_TOKEN_"
    return get_token(oauth, account)

def get_token(oauth, account):
    check_output("source /home/arch/.dotfiles/APIs", shell=True)
    output = os.environ.get("{}{}".format(oauth, account.upper()).encode('utf-8'))
    return output
