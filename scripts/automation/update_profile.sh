#!/bin/bash

export COMMIT_TITLE="chore: Catalogs automatic update."
export COMMIT_BODY="Sync catalogs with ocp-oscal-catalogs repo"
git config --global user.email "automation@example.com"
git config --global user.name "AutomationBot" 
cd ocp-oscal-profiles
git checkout -b "catalogs_autoupdate_$GITHUB_RUN_ID"
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
     remote=https://$GIT_TOKEN@github.com/ComplianceAsCode/ocp-oscal-profiles
     git push -u "$remote" "catalogs_autoupdate_$GITHUB_RUN_ID"
     echo $COMMIT_BODY
     gh pr create -t "catalogs_autoupdate_$GITHUB_RUN_ID" -b "catalogs_autoupdate_$GITHUB_RUN_ID" -B "develop" -H "catalogs_autoupdate_$GITHUB_RUN_ID" 
  fi
fi

