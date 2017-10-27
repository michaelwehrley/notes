# Git Objects

Git is a simple key-value data store filesystem (i.e., a content-addressable filesystem).
Add any content into the data store and get the address back!

## Hash Objects

### Blobs

They are the data store that contains all file content - but literally *only* the file content.

1. Create `hello_world.txt` file
1. Add content `Hello World!`
1. Create "hash-object":

```bash
$ git hash-object hello_world.txt
980a0d5f19a64b4b30a87d4206aade58726b60e3
```

1. This content is stored in `.git/objects`
1. View contents of `.git` directory:

```bash
# "type" here is limited to files (not directories etc)
$ find .git/objects -type f
.git/objects/98/0a0d5f19a64b4b30a87d4206aade58726b60e3
```

1. Use the cryptography library `openssl` and the Secure Hash Algorithm 1 hash function:
```bash
# "13" is the nmber of bytes in the blob (`$ git cat-file -s 980a0d5f19a64b4b30a87d4206aade58726b60e3` wil return "13")
# "blob" is the type (`$ git cat-file -t 980a0d5f19a64b4b30a87d4206aade58726b60e3` wil return "blob")
# "000" denotes a `null` character
# "041" denotes an exclamation mark 
$ printf "blob 13\000Hello World\041\n" | openssl sha1
980a0d5f19a64b4b30a87d4206aade58726b60e3
```

View the contents of any key in the `.git` folder using `git cat-file (<type>) <object>`
```bash
# "p" here is for pretty
git cat-file -p 980a0d5f19a64b4b30a87d4206aade58726b60e3
Hello World!
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

`$ git add hello_world.txt` is analagous to `$ git hash-object hello_world.txt;git update-index --add hello_world.txt` or `$ git update-index --add hello_world.txt`

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

### Parents and Linking


### Directed Acyclic Graph (DAG) & Merkle Tree