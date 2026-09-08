# Task 1: `git commit -a -m` vs `git commit -m`
## Difference
* **`git commit -m "message"`**: Commits **only** the files that have been explicitly staged in the index using the `git add` command. If you modified a file but didn't run `git add`, it will not be committed.
* **`git commit -a -m "message"`**: The `-a` (all) flag tells Git to automatically stage files that have been modified or deleted, and then commit them. **Note:** It does *not* stage brand new, untracked files.

## Commands & Outputs
### 1. commit -m
![commit -m](<screenshots/commit-m.png>)
### 2. commit -m without staging
![no staging](<screenshots/commit-no-stage.png>)
### 3. commit -a -m
![commit -a -m](<screenshots/commit-a-m.png>)
- We can see that only 1 insertion is there as `file2.txt` remains unchanged because `-a` ignores brand new files.

---

# Task 2: Git Cherry-Pick
`git cherry-pick <commit-hash>` allows us to pick a specific commit from one branch and apply it to our current branch, without merging the entire branch.


## Execution & Outputs
![initial](<screenshots/initial.png>)
- We create 2 commits in the master branch.
- Then we create a new branch and make 2 commits.
- We use `git log` to identify specific commit to cherry-pick.

---

![cherry-pick](<screenshots/cherry-pick.png>)
- We want to bring `Feature Commit 1` over to main.
- We switch back to master branch and cheery-pick the commit by using its hash i.e. `f8ddcef`.
- After we cherry-pick, we can notice the `feature1.txt` is now in main branch but `feature2.txt` is not, proving we selectively picked just one commit.