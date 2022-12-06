version_tag=$(semantic-release print-version)
echo "Bumping version of profiles to ${version_tag}" 
export VERSION_TAG="$version_tag"
./scripts/automation/assemble_catalogs.sh $version_tag
git config --global user.name "semantic-release (via TravisCI)"
git config --global user.email "semantic-release@travis"
semantic-release publish
