#!/bin/sh -l

GITHUB_TOKEN=$1
PR_COMMENT_URL=$2

output_json=`npx depcheck --json`
echo ${output_json} > depcheck_output.json
echo "# depcheck Result" > depcheck_output_pretty.txt
echo "List up libraries that are defined in dependencies and devDependencies in package.json but not used in your codes." >> depcheck_output_pretty.txt
echo "- Unused dependencies" >> depcheck_output_pretty.txt
cat depcheck_output.json | jq '.dependencies' >> depcheck_output_pretty.txt
echo "- Unused dev dependencies" >> depcheck_output_pretty.txt
cat depcheck_output.json | jq '.devDependencies' >> depcheck_output_pretty.txt
# echo "Missing" >> depcheck_output_pretty.txt
# cat depcheck_output.json | jq '.missing' >> depcheck_output_pretty.txt
cat depcheck_output_pretty.txt
cat depcheck_output_pretty.txt | perl -pe 's/\n/\\n/g' > depcheck_output_pretty2.txt
cat depcheck_output_pretty2.txt
cat depcheck_output_pretty2.txt | perl -pe 's/\",?$//g' > depcheck_output_pretty3.txt
cat depcheck_output_pretty3.txt | perl -pe 's/\"/  - /g' > depcheck_output_pretty4.txt
cat depcheck_output_pretty4.txt | perl -pe 's/[\[|\]\|{\|}]//g' > depcheck_output_pretty5.txt
echo "fixed"
cat depcheck_output_pretty5.txt
curl -X POST \
     -H "Authorization: token ${GITHUB_TOKEN}" \
     -d "{\"body\": \"$(cat depcheck_output_pretty5.txt)\"}" \
     ${PR_COMMENT_URL}
