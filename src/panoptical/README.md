
# My Favorite Color (panoptical)

A feature to remind you of your favorite color

## Example Usage

```json
"features": {
    "ghcr.io/public-rant/public-rant/panoptical:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| spec | Prompt for LLM. | string | Make it better |
| upstream | Your caldav server from which to pull events/attachments | string | fixme |

# Panoptical 

The [build](./gitlab-ci.yml) is broken!

## Prompt Driven Development

We define a `--spec` option for `pytest` in [`conftest.py`](./conftest.py). This allows us to run `pytest -s panoptical_test.py --spec ${SPEC}` in [src/panoptical/install.sh](./src/panoptical/install.sh)


Really what you want to do is configure your devcontainer thusly:

__NB__ there is more than one way to configure a devcontainer

```json
{
    "features": {
        "panoptical": {
            "spec": "Update my calendar with the latest merge requests",
            "upstream": "caldav.example.com"
        }
    }
}
```

Where `spec` is a prompt which will be sent to an LLM to generate content/code.

Since we are using python, we can hook into the python/mojo ML ecosystem. If you configure your devcontainer with `mounts`, you can "trick" calcurse-caldav.py to running as a mojo script. (This assumes you're running in a container with `mojo` available)

```json
...
"panoptical": {
    ...
    "mounts": [
        "source=/path/to/calcurse-caldav.py,target=/path/to/calcurse-caldav.mojo,type=bind,consistency=cached",
        "source=${localWorkspaceFolder}/calcurse-caldav.conf,target=/data,type=bind,consistency=cached"
    ]
}
```

__NB__ this requires a image with mojo available which you can use when configuring your devcontainer e.g.,
    
```json
"features": {
    "image": "gitlab.com/containers/mojo:latest",
    "panoptical": {
        "spec": "Update my calendar with the latest merge requests",
        "upstream": "caldav.example.com"
    }
}
```

## The Prompt

The [prompt](./panoptical_test.py) uses OpenAI's assistant API to define and run new calendars.

This means we have access to

- function calling
- file/vector database
- code intepreter

You send prompt to LLM. Expected behaviour:

- responds with params to start radicale servers
- generates tasks lists and validates output
- uses calcurse-caldav to sync changes upstream/downstream
- sends/receives attachments from caldav

__NB__ The idea is that the "test" you invoke when installing the devcontainer-feature `panoptical_test.py` creates unit tests which you run inside the running container. So the only code that needs to be developed is found in `panoptical_test.py`. All other functionality should be built/generated using that prompt and evaluated for correctness using TruLens before the feature is published and made available to other developers.

Your devcontainer is ready for production, to the extent that TruLens can ensure the correctness of your code/tests.

- https://www.trulens.org
- https://calcurse.org
- https://docs.modular.com/mojo

### Upstream/Downstream

You need to configure an [endpoint](https://gitlab.com/public-rant/feature-starter/-/blob/main/test/panoptical/config.sample?ref_type=heads#L16-20) for `calcurse-caldav`

__it would be MUCH better if this was overridable in [`calcurse-caldav`](https://gitlab.com/public-rant/feature-starter/-/blob/main/calcurse-caldav.py?ref_type=heads#L621)__
Once you've pulled data using calcurse-caldav, your LLM assistant can [optimise your schedule and create new calendars](./panoptical_test.py).

You define a source calendar and it will optimise your tasks and create new calendars for work you want to delegate to a human or robot.

You provide config when running the container that sets the upstream calendar. calcurse-caldav reads from there. Since we are calling OpenAI's assistant with access to `run_radicale_server`, you can use this to delegate tasks, observe what was planned by the LLM and if you like what you see, ship it to production.


## Further work

The CI/CD extension should respond to [webhooks](https://docs.gitlab.com/ee/user/project/integrations/webhook_events.html) according to rules you will need to define. E.g., if the body of a comment matches certain criteria. Or, what about hooks triggered from motion sensors in your Apple Vision Pro which prompt SORA render the scene around the corner?

Use [`nmh`](https://www.mhonarc.org/archive/html/nmh-workers/2014-07/msg00157.html) alongside `calcurse` to handle attachments


## Radicale

### Why would you want this?

__calendars integrate nicely with 3rd party project management software__

I think it could be helpful to have all of the tasks your AI agents are planning expressed as a calendar. The CalDAV protocol allows attachments, and `nmh` can handle sending them.

To make this e2e, apply this patch

```diff
index d26a5bc..760b686 100644
--- a/.devcontainer/devcontainer.json
+++ b/.devcontainer/devcontainer.json
@@ -1,5 +1,7 @@
 {
-    "image": "mcr.microsoft.com/devcontainers/javascript-node:1-18-bullseye",
+    "dockerComposeFile": "docker-compose.yml",
+    "service": "devcontainer",
+    "workspaceFolder": "/workspaces/feature-starter",
     "customizations": {
         "vscode": {
             "settings": {
diff --git a/.devcontainer/docker-compose.yml b/.devcontainer/docker-compose.yml
new file mode 100644
index 0000000..8c6850f
--- /dev/null
+++ b/.devcontainer/docker-compose.yml
@@ -0,0 +1,35 @@
+version: '3.8'
+services:
+  devcontainer:
+    image: mcr.microsoft.com/devcontainers/base:ubuntu
+    volumes:
+      - ../..:/workspaces:cached
+    network_mode: service:radicale
+    command: sleep infinity
+
+  radicale:
+    image: tomsquest/docker-radicale
+    container_name: radicale
+    ports:
+      - 127.0.0.1:5232:5232
+    volumes:
+      - work:/data
+
+volumes:
+  work:
```


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/public-rant/public-rant/blob/main/src/panoptical/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
