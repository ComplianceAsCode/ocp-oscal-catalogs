#!/bin/bash

export COMMIT_TITLE="chore: Catalogs automatic update."
export COMMIT_BODY="Sync catalogs with ocp-oscal-catalogs repo"
git clone https://$GITHUB_TOKEN@github.com/ComplianceAsCode/ocp-oscal-profiles
cd ocp-oscal-profiles
git checkout -b "catalogs_autoupdate_$TRAVIS_BUILD_NUMBER"
cp -r ../catalogs .
if [ -z "$(git status --porcelain)" ]; then 
  echo "Nothing to commit" 
else 
  git diff
  git add catalogs
  if [ -z "$(git status --untracked-files=no --porcelain)" ]; then 
     echo "Nothing to commit" 
  else
     git commit -m "$COMMIT_TITLE"
     git push -u origin "catalogs_autoupdate_$TRAVIS_BUILD_NUMBER"
     echo $COMMIT_BODY
     curl -u TravisCI:$GITHUB_TOKEN -X POST -H "Accept: application/vnd.github.v3+json"  https://api.github.com/repos/ComplianceAsCode/ocp-oscal-profiles/pulls -d '{"head":"'"catalogs_autoupdate_$TRAVIS_BUILD_NUMBER"'","base":"develop","body":"'"$COMMIT_BODY"'","title":"'"$COMMIT_TITLE"'"}'
  fi
fi

