def pytest_addoption(parser):
    parser.addoption("--spec", action="store", default="A prompt for an LLM")


def pytest_generate_tests(metafunc):
    # This is called for every test. Only get/set command line arguments
    # if the argument is specified in the list of test "fixturenames".
    option_value = metafunc.config.option.spec
    if 'spec' in metafunc.fixturenames and option_value is not None:
        metafunc.parametrize("spec", [option_value])