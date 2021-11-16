#!/bin/sh -l

output=`npx depcheck --json | jq`
echo ${output} > depcheck_output.json
cat depcheck_output.json
sed -i 's/\n/\\n/g' depcheck_output.json
sed -i 's/"/\"/g' depcheck_output.json
curl -X POST \
     -H "Authorization: token ${GITHUB_TOKEN}" \
     -d "{\"body\": \"$(cat depcheck_output.json)\"}" \
     ${URL}
