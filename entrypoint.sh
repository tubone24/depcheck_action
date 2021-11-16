#!/bin/sh -l

output_json=`npx depcheck --json`
echo ${output_json} > depcheck_output.json
cat depcheck_output.json | jq '.dependencies' > depcheck_output_pretty.txt
cat depcheck_output.json | jq '.devDependencies' >> depcheck_output_pretty.txt
cat depcheck_output.json | jq '.missing' >> depcheck_output_pretty.txt
sed -i 's/\n/\\n/g' depcheck_output_pretty.txt
sed -i 's/"/\\"/g' depcheck_output_pretty.txt
cat depcheck_output_pretty.txt
curl -X POST \
     -H "Authorization: token ${GITHUB_TOKEN}" \
     -d "{\"body\": \"$(cat depcheck_output_pretty.txt)\"}" \
     ${URL}
