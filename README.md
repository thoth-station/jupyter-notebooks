# jupyter-notebooks

Jupyter Notebooks master repo

<br>

# Submitting the builder Workflow

There is a script already prepared in the [scripts](/scripts/) folder.

Make sure that you are connected to the cluster and run
 `./scripts/submit.sh`

Optionally, you can provide custom arguments to the `argo submit` by passing them to the script directly, i.e.

 `./scripts/submit.sh --namespace argo`

If you don't have the argo client installed, you can make use of docker. In that case, execute:

`USE_DOCKER=1 ./scripts/submit.sh`

# Deploying the actions runner

As the build should run in a secured environment --- in our case, OpenShift --- a [self-hosted actions runner](https://help.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners) is used to make use of the Git Hub machinery and event handling.

To deploy the runner, issue the following set of commands (assumes OpenShift cluster and `oc` tool being installed)

```bash
oc apply -f actions-runner/openshift

# Get the RUNNER_ROKEN from the settings/actions `Add runner`
oc process github-actions-runner \
    --param APP_NAME=jupyter-notebooks \
    --param GITHUB_REPO=thoth-station/jupyter-notebooks \
    --param GITHUB_REPO_TOKEN=${REPO_TOKEN} \
    | oc apply -f -
```

### [optional] Building the actions runner image

There is a [Dockerfile](/actions-runner/Dockerfile) provided. The resulting image is present on [quay.io/thoth-station/actions-runner](https://quay.io/repository/thoth-station/actions-runner).


# Triggering builds

Builds are triggered automatically by merges into the master branch. Also, the vendor repositories should have a mechanism to notify (we create PRs) the master repo about changes to them, so that the submodules are updated.

Currently, the architecture looks as such:

<center>
<img src="/assets/img/repository-structure.png">
</center>

# Adding custom images

### Steps:

1) Create a repository containing the custom s2i image
2) Create required secrets in the repository settings:

    - `GITHUB_REPO_SSH_KEY`: SSH key used to clone thoth-station/jupyter-notebooks
    - `GITHUB_REPO_TOKEN`: a PAT token used to create a PR for thoth-station/jupyter-notebooks

    Our repos use secrets stored in `gopass show aicoe/thoth/sesheta`

3) Add the new repository as a submodule to the thoth-station/jupyter-notebooks

    ```
    git submodule add <repo> <dir>
    ```

4) Add the trigger workflow, for example see the [workflow from s2i-minimal-notebook repo](https://github.com/thoth-station/s2i-minimal-notebook/blob/master/.github/workflows/trigger.yml).
