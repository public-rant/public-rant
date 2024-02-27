# import chroma
# import pandas
# import truera
# import openai
# TODO: import calcurse-caldav
import pytest

def evaluate_content_with_trulens():
    pass

def run_radicale_server(name='friend',port=5232,mounts={}):
    # TODO: write a function which creates/removes calendars as per this script:https://github.com/arthur-stace/radical/blob/master/Makefile
    pass

def test_generate_tests_for(spec):
    print ("You are an LLM generating unit tests for: %s" % spec)
    # TODO generate a payload for openai assistants API based on output from calcurse query cli`
    # e.g., payload = `calcurse -Q --from -7days`
    # OpenAI.assistants.create_thread_and_run(payload)
    # TODO upload functions to openAI assistant so it knows how to call evaluate_content_with_trulens and run_radicale_server
    pass