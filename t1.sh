#!/bin/bash
for ((i=1; i<=250000; i++))
do
   BRANCH="t1-batch-$i"
   git checkout main && git pull origin main
   git checkout -b $BRANCH
   for ((j=1; j<=100; j++)); do
      echo "T1-B$i-C$j" >> data_t1.txt
      git add data_t1.txt && git commit -m "T1-C$j" --quiet
   done
   git push origin $BRANCH
   gh pr create --title "T1 Batch $i" --body "Auto" --base main
   gh pr merge --squash --delete-branch --admin
done
