#!/bin/bash

function travis-branch-commit() {
    local head_ref branch_ref
    head_ref=$(git rev-parse HEAD)
    if [[ $? -ne 0 || ! $head_ref ]]; then
        err "failed to get HEAD reference"
        return 1
    fi
    branch_ref=$(git rev-parse "$TRAVIS_BRANCH")
    if [[ $? -ne 0 || ! $branch_ref ]]; then
        err "failed to get $TRAVIS_BRANCH reference"
        return 1
    fi
    if [[ $head_ref != $branch_ref ]]; then
        msg "HEAD ref ($head_ref) does not match $TRAVIS_BRANCH ref ($branch_ref)"
        msg "someone may have pushed new commits before this build cloned the repo"
        return 0
    fi
    if ! git checkout "$TRAVIS_BRANCH"; then
        err "failed to checkout $TRAVIS_BRANCH"
        return 1
    fi

    if ! git add catalogs; then
        err "failed to add modified files to git index"
        return 1
    fi
    if ! git add md_catalogs; then
        err "failed to add modified files to git index"
        return 1
    fi
    if ! git add adjunct-data; then
        err "failed to add modified files to git index"
        return 1
    fi
    # make Travis CI skip this build
    if ! git commit -m "Travis Build #${TRAVIS_BUILD_NUMBER} [ci skip]"; then
        err "failed to commit updates"
        return 1
    fi
    # add to your .travis.yml: `branches\n  except:\n  - "/\\+travis\\d+$/"\n`
    if [[ $TRAVIS_BRANCH = main ]]; then
        echo "Version tag: ${VERSION_TAG}" 
        git tag -d "v${VERSION_TAG}"
        echo "Adding version tag v${VERSION_TAG} to branch $TRAVIS_BRANCH"
        if ! git tag "v${VERSION_TAG}" -m "Generated version tag from Travis CI build $TRAVIS_BUILD_NUMBER"; then
            err "failed to create git tag: v${VERSION_TAG}"
            return 1
        fi
    fi
    
    local remote=origin
    if [[ $GITHUB_TOKEN ]]; then
        remote=https://$GITHUB_TOKEN@github.com/$TRAVIS_REPO_SLUG
    fi
    if [[ $TRAVIS_BRANCH != main ]] && [[ $TRAVIS_BRANCH != develop ]]; then
        msg "not pushing updates to branch $TRAVIS_BRANCH"
        return 0
    fi
    if ! git push --quiet --follow-tags "$remote" "$TRAVIS_BRANCH" ; then
        err "failed to push git changes"
        return 1
    fi
}

function msg() {
    echo "travis-commit: $*"
}

function err() {
    msg "$*" 1>&2
}

travis-branch-commit