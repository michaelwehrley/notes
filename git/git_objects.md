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
$ ls .git/objects
info  pack
```

```bash
$ echo 'Home Chef!' > home_chef.txt
```

**hash-object**
Note: `man git-hash-object` vs `git hash-object`
Add this to to the git database by creating a git hash object (and writing it to the db):

* `git-hash-object` - Computes object ID and optionally creates a blob from a file. (i.e., does what it says; it hashes the content into the object database)
* `-w` - Write the object into the **object** database.

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

$ find .git/objects/ -type f
.git/objects//40/c46548972e0d0eff2725522e5ba22fde44d346
```

1. The content is stored as a key-value pair in the object database: `.git/objects`

```bash
# "type" here is limited to files (not directories etc)
$ find .git/objects -type f
.git/objects/40/c46548972e0d0eff2725522e5ba22fde44d346
```

View the contents of any key in the `.git` folder using `git cat-file (<type>) <object>`
```bash
# [-p] here is for pretty
git cat-file -p 40c46548972e0d0eff2725522e5ba22fde44d346
Home Chef!
```

### Tree Objects

Tree objects are complete snapshot of the entire project directory.

`git update-index` - already has the `hash-object` functionality built into it. `update-index` will check to see if the exists.  If it does, it will use it; otherwise, it will create it under the hood.

Create a staging area where we can index our tree objects: `$ git update-index --add hello_world.txt`.
View this staging area via `$ git ls-files --stage` or `$ git status`
Not the staging area is in constant flux.

```bash
# `git ls-files` just to see the files
$ git ls-files --stage
100644 980a0d5f19a64b4b30a87d4206aade58726b60e3 0 hello_world.txt
```

`$ git add hello_world.txt` is analagous to

`$ git hash-object -w hello_world.txt;git update-index --add hello_world.txt` or

`$ git update-index --add hello_world.txt`

Make a tree object with stagged files: `git write-tree`.  It looks familiar to the staging area - but it is a finalized snapshot, captured and persisted. 
```bash
$ git write-tree
d1df156691ebcab17bba4e20226fda99132617f2 # we are writing to the objects  folder so we get back a hash
$ git cat-file -p d1df156691ebcab17bba4e20226fda99132617f2
100644 blob 980a0d5f19a64b4b30a87d4206aade58726b60e3  hello_world.txt
```

Note that all of these snapshots are in the objects directory:
```bash
$ find .git/objects -type f
.git/objects/0c/1b4e6feb7eaed08e75d20e3ce2e2a3207c78b3
.git/objects/1d/f50e25fbea5bd8a8ba58e2204fff063376f421
.git/objects/81/864cc123ffccf8110aa9da6c2be6e0c440c3ef
.git/objects/98/0a0d5f19a64b4b30a87d4206aade58726b60e3
.git/objects/d1/df156691ebcab17bba4e20226fda99132617f2
```

### Commit Objects

Create a commit object with the sha hash of the tree object
```bash
$ echo "my commit" | git commit-tree d1df156691ebcab17bba4e20226fda99132617f2
$ find .git/objects -type f
.git/objects/0c/1b4e6feb7eaed08e75d20e3ce2e2a3207c78b3
.git/objects/1d/f50e25fbea5bd8a8ba58e2204fff063376f421
.git/objects/81/864cc123ffccf8110aa9da6c2be6e0c440c3ef
.git/objects/98/0a0d5f19a64b4b30a87d4206aade58726b60e3
.git/objects/bb/0be81df086316319daed635acd58f57c326351
.git/objects/d1/df156691ebcab17bba4e20226fda99132617f2
```

```bash
$ git cat-file -p bb0be81df086316319daed635acd58f57c326351
tree d1df156691ebcab17bba4e20226fda99132617f2
author Mike <mike@ex.co> 1509081962 -0500
committer Mike <mike@ex.co> 1509081962 -0500

my commit
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
