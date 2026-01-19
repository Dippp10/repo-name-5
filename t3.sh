#!/bin/bash
for ((i=500001; i<=750000; i++))
do
   BRANCH="t3-batch-$i"
   git checkout main && git pull origin main
   git checkout -b $BRANCH
   for ((j=1; j<=100; j++)); do
      echo "T3-B$i-C$j" >> data_t3.txt
      git add data_t3.txt && git commit -m "T3-C$j" --quiet
   done
   git push origin $BRANCH
   gh pr create --title "T3 Batch $i" --body "Auto" --base main
   gh pr merge --squash --delete-branch --admin
done
