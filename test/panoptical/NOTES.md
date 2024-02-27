Under the hood, this uses `pytest -K ${SPEC}` when installing the container to sync with your calendar/project management software.

Since we are using python, we can hook into the python/mojo ML ecosystem.

The CI/CD extension should respond to webhooks according to rules you will need to define. E.g., if the body of a comment matches certain criteria.

```json
{
    "mojo": {
        "image": "docker.io/library/mojo:latest",
        "features": {
            "panoptical": {
                "spec": "Update my calendar with the latest merge requests"
            }
        }
    },
    "python": {
        "image": "docker.io/library/python:latest",
        "features": {
            "panoptical": {
                "spec": "Update my calendar with the latest comments"
            }
        }
    }
}
```