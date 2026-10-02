#!/usr/bin/env bash
# Creates the "Kotlin Kenya App" GitHub Project for the android254 org, with
# its custom fields, links the repos in REPOS, and gives each repo the shared labels.
# See docs/github-project.md for the steps the API can't do (views, Status
# options, auto-add workflows).
#
# Needs: gh CLI, logged in as an android254 org member who can create projects
#   gh auth refresh -s project,read:org
# Usage:
#   scripts/setup-github-project.sh            # create the project and set everything up
#   PROJECT_NUMBER=3 scripts/setup-github-project.sh   # reuse an existing project (onboard repos, sync labels)
set -euo pipefail

OWNER="android254"
TITLE="Kotlin Kenya App"
REPOS=(
  "android254/kotlin_kenya_product_manager_agent"
  "android254/kotlin-kenya-designer-agent"
)

# name|color|description. Priority and value labels match the designer repo's existing ones.
LABELS=(
  "must fix|B60205|Blocks a release or breaks trust"
  "should fix|D93F0B|Important, plan it soon"
  "nice to have|FBCA04|Do it when there's room"
  "member value|0E8A16|Helps attendees, speakers or job seekers"
  "sponsor value|5319E7|Helps sponsors"
  "organizer value|1D76DB|Helps organizers run events"
  "design|C5DEF5|Figma work"
  "engineering|BFD4F2|App code"
  "scope|D4C5F9|Product scope or decision"
  "accessibility|006B75|Accessibility"
  "documentation|0075CA|Docs"
)

if [[ -z "${PROJECT_NUMBER:-}" ]]; then
  PROJECT_NUMBER=$(gh project create --owner "$OWNER" --title "$TITLE" --format json --jq .number)
  echo "Created project #$PROJECT_NUMBER"
  gh project edit "$PROJECT_NUMBER" --owner "$OWNER" \
    --description "Backlog and roadmap for the Kotlin Kenya / Android254 app, across product, design and engineering repos."

  field() { gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" "$@" >/dev/null && echo "Field: $2"; }
  field --name "Feature area" --data-type SINGLE_SELECT \
    --single-select-options "Onboarding,Home,Events,Call for Speakers,Community,Profile,Cross-cutting"
  field --name "Platform" --data-type SINGLE_SELECT \
    --single-select-options "Android,iOS,Shared/KMP,Backend,Design,Content"
  field --name "Size" --data-type SINGLE_SELECT --single-select-options "S,M,L"
  field --name "Phase" --data-type SINGLE_SELECT --single-select-options "Phase 1,Phase 2,Later"
  field --name "Scope doc" --data-type TEXT
  field --name "Target date" --data-type DATE
else
  echo "Using existing project #$PROJECT_NUMBER"
fi

for repo in "${REPOS[@]}"; do
  gh project link "$PROJECT_NUMBER" --owner "$OWNER" --repo "$repo" && echo "Linked $repo" || echo "Already linked: $repo"
  for l in "${LABELS[@]}"; do
    IFS='|' read -r name color desc <<<"$l"
    gh label create "$name" --repo "$repo" --color "$color" --description "$desc" --force >/dev/null
  done
  echo "Labels synced: $repo"
done

echo
echo "Done: https://github.com/orgs/$OWNER/projects/$PROJECT_NUMBER"
echo "Next: finish the manual steps in docs/github-project.md (Status options, views, auto-add)."
