#!/bin/bash
for ((i=250001; i<=500000; i++))
do
   BRANCH="t2-batch-$i"
   git checkout main && git pull origin main
   git checkout -b $BRANCH
   for ((j=1; j<=100; j++)); do
      echo "T2-B$i-C$j" >> data_t2.txt
      git add data_t2.txt && git commit -m "T2-C$j" --quiet
   done
   git push origin $BRANCH
   gh pr create --title "T2 Batch $i" --body "Auto" --base main
   gh pr merge --squash --delete-branch --admin
done
