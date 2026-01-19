#!/bin/bash
for ((i=750001; i<=1000000; i++))
do
   BRANCH="t4-batch-$i"
   git checkout main && git pull origin main
   git checkout -b $BRANCH
   for ((j=1; j<=100; j++)); do
      echo "T4-B$i-C$j" >> data_t4.txt
      git add data_t4.txt && git commit -m "T4-C$j" --quiet
   done
   git push origin $BRANCH
   gh pr create --title "T4 Batch $i" --body "Auto" --base main
   gh pr merge --squash --delete-branch --admin
done
