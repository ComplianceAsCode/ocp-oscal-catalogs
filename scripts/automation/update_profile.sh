#!/bin/bash

export COMMIT_TITLE="chore: Catalogs automatic update."
export COMMIT_BODY="Sync catalogs with ocp-oscal-catalogs repo"
git config --global user.email "automation@example.com"
git config --global user.name "Automation Bot" 
git clone https://$GIT_TOKEN@github.com/ComplianceAsCode/ocp-oscal-profiles
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
     local remote=origin
     if [[ $GIT_TOKEN ]]; then
        remote=https://$GIT_TOKEN@github.com/ComplianceAsCode/ocp-oscal-profiles
     fi
     git push -u "$remote" "catalogs_autoupdate_$GITHUB_RUN_ID"
     echo $COMMIT_BODY
     curl -u AutomationBot:$GIT_TOKEN -X POST -H "Accept: application/vnd.github.v3+json"  https://api.github.com/repos/ComplianceAsCode/ocp-oscal-profiles/pulls -d '{"head":"'"catalogs_autoupdate_$GITHUB_RUN_ID"'","base":"develop","body":"'"$COMMIT_BODY"'","title":"'"$COMMIT_TITLE"'"}'
  fi
fi

