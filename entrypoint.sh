#!/bin/sh -l

output=`npx depcheck`
echo ${output} > depcheck_output.txt
cat depcheck_output.txt
sed -i 's/\n/\\n/g' depcheck_output.txt
curl -X POST \
     -H "Authorization: token ${GITHUB_TOKEN}" \
     -d "{\"body\": \"$(cat depcheck_output.txt)\"}" \
     ${URL}
