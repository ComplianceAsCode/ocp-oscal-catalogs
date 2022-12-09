version_tag=$(semantic-release print-version)
echo "Bumping version of profiles to ${version_tag}" 
export VERSION_TAG="$version_tag"
echo "VERSION_TAG=${VERSION_TAG}" >> $GITHUB_ENV
./scripts/automation/assemble_catalogs.sh $version_tag
echo "Committing..."
./scripts/automation/commit.sh 
git config --global user.name "semantic-release (via TravisCI)"
git config --global user.email "semantic-release@travis"
semantic-release publish
