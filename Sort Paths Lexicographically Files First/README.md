# [Sort Paths Lexicographically, Files First](https://www.autohotkey.com/boards/viewtopic.php?f=76&t=71052)

Requires: [`[v2.0-a108-a2fa0498]`](https://github.com/Lexikos/AutoHotkey_L/releases/tag/v2.0-a108)

## Objective

Sort a list of file paths in an ascending lexicographic order such that priority is given to files over folders.

## Input

```
c:\folder a\wfbt.txt
c:\folder c\blah.txt
c:\folder b\terp.txt
c:\folder b\subfolder c\phbt.txt
c:\folder a\subfolder a\hfbt.txt
```

## Output

```
c:\folder a\wfbt.txt
c:\folder a\subfolder a\hfbt.txt
c:\folder b\terp.txt
c:\folder b\subfolder c\phbt.txt
c:\folder c\blah.txt
```

## Implementation

- Break file paths up into the individual file and folder chucks comprising them.
- Store the folder chunks in a recursive tree data structure, implemented atop `Map` (automatic case-sensitive lexicographical sort), as keys associated to other folder chunks (descendants).
- Store file names separated in an internal plain `Map` (to also take advantage of the automatic sorting), as keys associated with a dummy value.
- DFS traverse the tree, making sure to always print files first.