# You've Got To Be Gitin' Me

## Part I

Git is a simple key-value data store filesystem (i.e., a content-addressable filesystem).
Add any content into the data store and get the address back!

### Hash Objects :gem:

A Hash is a dictionary-like collection of unique keys and their values:

```ruby
# hash in ruby
{ "Jane Doe" => 10, "Jim Doe" => 6, foo: "bar", foo: "foo" }
# 1: warning: key :foo is duplicated and overwritten on line 1
=> {"Jane Doe"=>10, "Jim Doe"=>6, :foo=>"foo"} 
```

```javascript
// object in javascript
var hash = { a: 1, b: "2", 3: 4, "foo": (1 * "hello, world!"), 3: 5 };

for (var key in hash) {
  if (hash.hasOwnProperty(key)) {
    document.write("key " + key + " w/ value " + hash[key] + "; ");
  }
}
// key 3 w/ value 5; key a w/ value 1; key b w/ value 2; key foo w/ value NaN;
```

For Git, hash objects are the data store that contains all file content - but literally **only** the file content.

### Blobs :eyes:

#### SHA-1 Hashing

```bash
$ echo 'Home Chef!' | openssl sha1
3623b9146b99265c340dc681ad45040ac7800ca8
```
You will need to use single quotes. Because of the '!' is a special character in bash.

Example:
```bash
!1
```

Strings in single quotes are not expanded by bash - everything is preserved without exception.

Example:
```bash
$ foo="Big Foo"
$ echo $foo
Big Foo
$ echo 'My name is $foo'
My name is $foo
$ echo "My name is $foo"
My name is Big Foo
```

You could write it like this:
```bash
echo "Home Chef"'!' | openssl sha1
```

Many applications still rely on SHA-1; however, it is no longer consider secure as theoretical attacks have been known since 2005. SHA-1 was officially deprecated in 2011.[1](https://shattered.it/)

* [Announcing the first SHA1 collision](https://security.googleblog.com/2017/02/announcing-first-sha1-collision.html)
* [Here](https://shattered.it/) are two PDF files that display different content, yet have the same SHA-1 digest.

Git uses the cryptography library [OpenSSL](https://en.wikipedia.org/wiki/OpenSSL) and the [SHA-1 (Secure Hash Algorithm 1)](https://en.wikipedia.org/wiki/SHA-1) hash function:

```bash
$ printf "blob 11\000Home Chef\041\n" | openssl sha1
40c46548972e0d0eff2725522e5ba22fde44d346
```

Size (bytes) `-s`:
```bash
git cat-file -s 40c46548972e0d0eff2725522e5ba22fde44d346
# `-s` returns the object size identified by <object>.
# "11" is the nmber of bytes in the blob
```

Type `-t`:
```bash
git cat-file -t 40c46548972e0d0eff2725522e5ba22fde44d346
# [-t] returns the object type identified by <object>.
# "blob" is the type
```
* "000" (or \0) denotes a `null` character
* "041" denotes an exclamation mark 

1. Create directory: `$ mkdir git_home_chef`
2. Navigate into that direcory: `$ cd git_home_chef/`
3. Initialize git:
```bash
$ git init
Initialized empty Git repository in ~/git_home_chef/.git/
```
4. View contents of `.git` directory:
```bash
$ ls .git
HEAD    config    description hooks   info    objects   refs
```
5. View contents of `.git/objects` directory:
```bash
$ ls .git/objects
info  pack
```

#### Hash-Object

Definitions:
* blob: stores file content.
* tree: stores directory layouts and filenames.
* commit: stores commit info and forms the Git commit graph.
* tag: stores annotated tag.

Note: `man git-hash-object` vs `git hash-object`
Add this to to the git database by creating a git hash object (and writing it to the db):

* `git-hash-object` - Computes object ID and optionally creates a blob from a file. (i.e., does what it "says": it hashes the content into the object database)
* `-w` - Write the object into the **object** database.

```bash
$ echo 'Home Chef!' > home_chef.txt
```

```bash
$ git hash-object -w home_chef.txt
40c46548972e0d0eff2725522e5ba22fde44d346
```

View contents of `.git` directory:
```bash
$ ls .git
HEAD    config    description hooks   info    objects   refs
```
View contents of `objects` directory:
```bash
$ ls .git/objects
40  info  pack
```
View contents of `40` directory:
```bash
$ find .git/objects/
.git/objects/
.git/objects//pack
.git/objects//info
.git/objects//40
.git/objects//40/c46548972e0d0eff2725522e5ba22fde44d346
```
```bash
$ find .git/objects/ -type f
.git/objects//40/c46548972e0d0eff2725522e5ba22fde44d346
# "type" here is limited to files (not directories etc)
```

1. The content is stored as a key-value pair in the object database: `.git/objects`

View the contents of any key in the `.git` folder using `git cat-file (<type>) <object>`
```bash
# [-p] here is for pretty
git cat-file -p 40c46548972e0d0eff2725522e5ba22fde44d346
Home Chef!
```

```bash
# [-t] here is for type
git cat-file -t 40c46548972e0d0eff2725522e5ba22fde44d346
blob
```

```bash
# Compressed...
cat .git/objects/40/c46548972e0d0eff2725522e5ba22fde44d346
```

Edit the file:
```bash
$ echo "We used to be called Mealhand and Relished." >> home_chef.txt
# Note: We aren't use `>`.
```
```bash
git hash-object -w home_chef.txt
cc0ec884d71714b244266fa61743465d5be87869
```

Multiple Git Objects
```bash
$ find .git/objects/
.git/objects/
.git/objects//pack
.git/objects//info
.git/objects//cc
.git/objects//cc/0ec884d71714b244266fa61743465d5be87869
.git/objects//40
.git/objects//40/c46548972e0d0eff2725522e5ba22fde44d346
```

```bash
git cat-file -p cc0ec884d71714b244266fa61743465d5be87869
Home Chef!
We used to be called Mealhand and Relished.
```

:blowfish: **Note:** This is **NOT** a **DIFF**!

### Tree Objects

To link **blobs** together to form a snapshot, we need tree objects.
**BUT** before we can do that, we need an **index file** to make trees: i.e,. a **staging area.**

So we are going to add files into our staging area:

```bash
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)

  home_chef.txt
```

```bash
$ git update-index --add home_chef.txt
```

`git update-index` - already has the `hash-object` functionality built into it. `update-index` will check to see if the exists.  If it does, it will use it; otherwise, it will create it under the hood.

Staging:
```bash
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

  new file:   home_chef.txt
```

Add another file:
```bash
$ echo 'The day after today.' > tomorrow.txt
```

```bash
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

  new file:   home_chef.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)

  tomorrow.txt
```

```bash
$ git update-index --add tomorrow.txt
```

```bash
 $ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

  new file:   home_chef.txt
  new file:   tomorrow.txt
```

#### Index
```bash
$ ls .git/
HEAD    config    description hooks   index   info    objects   refs
```

`git-ls-files`: Show information about files in the index (staging area) and the working tree
View this staging area via `$ git ls-files --stage` or `$ git status`
Note: The staging area is in constant flux.

```bash
# `git ls-files` to see the files in the staging area
$ git ls-files --stage
100644 cc0ec884d71714b244266fa61743465d5be87869 0 home_chef.txt
100644 415707d1975e1ca65b1b8a7b190b07d7814a59e9 0 tomorrow.txt
```

`$ git add home_chef.txt` is analagous to

`$ git hash-object -w home_chef.txt;git update-index --add home_chef.txt` or

`$ git update-index --add home_chef.txt`

Note: You must `git update-index` before you can create a tree object from the current index.

#### Git Write Tree :palm_tree:

```bash
$ git write-tree
43c5f15d8f95432194c396e5f007f765b494f45d
```
```bash
# We are writing to the objects folder so we get back a hash
$ git cat-file -p 43c5f15d8f95432194c396e5f007f765b494f45d
100644 blob cc0ec884d71714b244266fa61743465d5be87869  home_chef.txt
100644 blob 415707d1975e1ca65b1b8a7b190b07d7814a59e9  tomorrow.txt
```

Note: All of these **snapshots** are in the objects directory:
```bash
 $ find .git/objects -type f
.git/objects/43/c5f15d8f95432194c396e5f007f765b494f45d
.git/objects/cc/0ec884d71714b244266fa61743465d5be87869
.git/objects/41/5707d1975e1ca65b1b8a7b190b07d7814a59e9
.git/objects/40/c46548972e0d0eff2725522e5ba22fde44d346
```

```bash
$ git cat-file -p 43c5f15d8f95432194c396e5f007f765b494f45d
100644 blob cc0ec884d71714b244266fa61743465d5be87869  home_chef.txt
100644 blob 415707d1975e1ca65b1b8a7b190b07d7814a59e9  tomorrow.txt
```

Make a tree object with stagged files: `git write-tree`.  It looks similar to the **staging** area - but it is a **finalized** snapshot, captured and **persisted**.

```bash
$ git cat-file -p cc0ec884d71714b244266fa61743465d5be87869
Home Chef!
We used to be called Mealhand and Relished.
```

```bash
 $ git cat-file -p 40c46548972e0d0eff2725522e5ba22fde44d346
Home Chef!
```

### Commit Object - MetaData

Create a commit object (meta data) with the sha hash of the tree object
```bash
$ echo "Home Chef demo commit" | git commit-tree 43c5f15d8f95432194c396e5f007f765b494f45d
5c15f53e9c2db14cbb3e50dc58fc979c0ad45ea2
```

```bash
$ find .git/objects -type f
.git/objects/43/c5f15d8f95432194c396e5f007f765b494f45d
.git/objects/5c/15f53e9c2db14cbb3e50dc58fc979c0ad45ea2
.git/objects/cc/0ec884d71714b244266fa61743465d5be87869
.git/objects/41/5707d1975e1ca65b1b8a7b190b07d7814a59e9
.git/objects/40/c46548972e0d0eff2725522e5ba22fde44d346
```

```bash
$ git cat-file -p 5c15f53e9c2db14cbb3e50dc58fc979c0ad45ea2
tree 43c5f15d8f95432194c396e5f007f765b494f45d
author Mike <mike@homechedminsmbp.attlocal.net> 1519367211 -0600
committer Mike <mike@homechedminsmbp.attlocal.net> 1519367211 -0600

Home Chef demo commit
```

## Part II

#### Updates

Update a file: `$ echo "Gold Star is not a Packer Bar anymore." >> bar.txt`
Update Index:
```
$ git update-index --add bar.txt
```

Recall:

```
$ git cat-file -p 30f581e97080951db456a86bd93c1abeba38de27
tree cea74affb155db683d9c9164800843494332bcb2
author Mike <mike@ex.co> 1511154654 -0600
committer Mike <mike@ex.co> 1511154654 -0600

Commit for my first tree object

$ git cat-file -p cea74affb155db683d9c9164800843494332bcb2
100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99  bar.txt
100644 blob c77713e7cb36c8cdc19967ca1ce55fc68e5ddb76  home_chef.txt
```

#### Linking Commits
```
$ git write-tree
a22fc70b3d7139f6540711b0f7c6f661c7512097

$ echo "A second commit" | git commit-tree a22fc70b3d7139f6540711b0f7c6f661c7512097 -p 30f581e97080951db456a86bd93c1abeba38de27
f4d139fc1f1fa894b3c0ed552220619ac86bcc98

$ git cat-file -p f4d139fc1f1fa894b3c0ed552220619ac86bcc98
tree a22fc70b3d7139f6540711b0f7c6f661c7512097
parent 30f581e97080951db456a86bd93c1abeba38de27
author Mike <mike@ex.co> 1511155667 -0600
committer Mike <mike@ex.co> 1511155667 -0600

A second commit
```

#### View Log (`git log --stat <object>`)

We can start to see the history of the second git commit that is linked [f4d139fc1f1fa894b3c0ed552220619ac86bcc98]:
```
git log --stat f4d139fc1f1fa894b3c0ed552220619ac86bcc98
commit f4d139fc1f1fa894b3c0ed552220619ac86bcc98
Author: Mike <mike@ex.co>
Date:   Sun Nov 19 23:27:47 2017 -0600

    A second commit

 bar.txt | 1 +
 1 file changed, 1 insertion(+)

commit 30f581e97080951db456a86bd93c1abeba38de27
Author: Mike <mike@ex.co>
Date:   Sun Nov 19 23:10:54 2017 -0600

    Commit for my first tree object

 bar.txt       | 1 +
 home_chef.txt | 2 ++
 2 files changed, 3 insertions(+)
```

#### Directed Acyclic Graph (DAG) & Merkle Tree

* Keeps data integrity;
* Prohibts duplication;
* Fast b/c of the hash indexing of content

### Branches & HEADS

Branches are just aliases to **commits**.

```
$ ls .git/refs/
.git/refs/
.git/refs//heads
.git/refs//tags
```

Similar to running `git update-index`: `$ git update-ref refs/heads/master f4d139fc1f1fa894b3c0ed552220619ac86bcc98`

```
$ ls .git/refs/heads/
master
$ cat .git/refs/heads/master 
f4d139fc1f1fa894b3c0ed552220619ac86bcc98
```

```
$ git checkout -b feature
Switched to a new branch 'feature'
$ cat .git/refs/heads/feature 
f4d139fc1f1fa894b3c0ed552220619ac86bcc98
```

#### HEAD

The `HEAD` just tells you what branch (alias to a commit) you are working on
```
$ cat .git/HEAD 
ref: refs/heads/feature
```

#### Detached HEAD

All this is, is you HEAD is pointing to a commit that isn't a feature branch.
```
$ find .git/objects/ -type f
.git/objects//a2/2fc70b3d7139f6540711b0f7c6f661c7512097
.git/objects//f4/d139fc1f1fa894b3c0ed552220619ac86bcc98
.git/objects//c7/7713e7cb36c8cdc19967ca1ce55fc68e5ddb76
.git/objects//30/f581e97080951db456a86bd93c1abeba38de27
.git/objects//ce/a74affb155db683d9c9164800843494332bcb2
.git/objects//4f/faf9b667566fed721998daadc29a74f7f0f1a9
.git/objects//40/c46548972e0d0eff2725522e5ba22fde44d346
.git/objects//25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99
```
```
$ git checkout 30f581e97080951db456a86bd93c1abeba38de27
$ git status
HEAD detached at 30f581e
```

Even if you checkout to a commit that is where a branch alias points to, you will have a detached head:
```
$ git chekcout f4d139fc1f1fa894b3c0ed552220619ac86bcc98
$ git status
HEAD detached at f4d139f
```

Checkout branch:
```
$ git chekcout feature
$ git status
On branch feature
```

### Pack Objects

```
$ find .git/objects -type f
.git/objects/a2/2fc70b3d7139f6540711b0f7c6f661c7512097
.git/objects/f4/d139fc1f1fa894b3c0ed552220619ac86bcc98
.git/objects/c7/7713e7cb36c8cdc19967ca1ce55fc68e5ddb76
.git/objects/30/f581e97080951db456a86bd93c1abeba38de27
.git/objects/ce/a74affb155db683d9c9164800843494332bcb2
.git/objects/4f/faf9b667566fed721998daadc29a74f7f0f1a9
.git/objects/40/c46548972e0d0eff2725522e5ba22fde44d346
.git/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99
```

Count the objects (`-H` for human readable)
```
$ git count-objects -H
8 objects, 32.00 KiB
```

#### Garbage Collector :scream:

`git gc` or garbase collect packs all the deltas up.

```
$ git count-objects -H
1 objects, 4.00 KiB
```

```
$ find .git/objects -type f
.git/objects/pack/pack-0f68e8cca9dba49a21644913acfde289d0dbd00a.pack
.git/objects/pack/pack-0f68e8cca9dba49a21644913acfde289d0dbd00a.idx
.git/objects/info/packs
.git/objects/40/c46548972e0d0eff2725522e5ba22fde44d346
```

#### Verify Packed Items
```
$ git verify-pack -v .git/objects/pack/pack-0f68e8cca9dba49a21644913acfde289d0dbd00a.pack
f4d139fc1f1fa894b3c0ed552220619ac86bcc98 commit 244 160 12
30f581e97080951db456a86bd93c1abeba38de27 commit 212 143 172
4ffaf9b667566fed721998daadc29a74f7f0f1a9 blob   43 52 315
c77713e7cb36c8cdc19967ca1ce55fc68e5ddb76 blob   22 32 367
a22fc70b3d7139f6540711b0f7c6f661c7512097 tree   76 82 399
cea74affb155db683d9c9164800843494332bcb2 tree   76 81 481
257cc5642cb1a054f08cc83f2d943e56fd3ebe99 blob   4 13 562
non delta: 7 objects
.git/objects/pack/pack-0f68e8cca9dba49a21644913acfde289d0dbd00a.pack: ok
```

Thank you Emily Xie [YouTube Video](https://www.youtube.com/watch?v=Y2Msq90ZknI) and the [Git Docs](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects)
