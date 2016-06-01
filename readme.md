PSDirTag
=========

Overview
--------

DirTags are relative paths that appear as variables in the Powershell prompt that update and point to relevant as you navigate.


### A basic example

Consider this overly simple project structure:

```
project1
    - docs
        - internal
            - server
    - src
        - server
```

Let's say that we are working in `project1/src/server`. While editing server code, we may wish to create a documentation file in `docs/internal/server`...

`PS C:\project1\src\server> subl ..\..\docs\internal\server\new-feature.md`

Simple enough, but we did have pay attention to current folder depth. Let's try a DirTag:

_In dirtags.json:_

```
{
  "dirTags": [
    {
      "name": "docs",
      "path": "docs"
    }
  ]
}

```

PSDirTag will walk up the current path to find the first folder with that name, setting it as variable $docs. It wil update upon prompt refresh (more on that later).

```
PS C:\project1\src\server> $docs
C:\project1\docs
```

I use autocomplete:
`PS C:\project1\src\server> subl $docs/i` and press {tab}...

Powershell resolves the path...
`PS C:\project1\src\server> subl C:\project1\docs\internal\`
... and I may continue typing the command:
`PS C:\project1\src\server> subl C:\project1\docs\internal\server\new-feature.md`


#### A slighter better example

Folder name `docs` maybe bit a bit too generic, so let's narrow it down to internal server docs:

_In dirtags.json:_

```
{
  "dirTags": [
    {
      "name": "serverdocs",
      "path": "docs\\internal\\server"
    }
  ]
}
```

I can now tab-complete and use the new dirtag:
```
PS C:\project1\src\server> $serverdocs
C:\project1\docs\internal\server
```

Consider a scenario where it is common to work with multiple projects with the same folder structure. I may access the same dirtag from project2:

```
PS C:\features\project2\src\server> $serverdocs
C:\features\project2\docs\internal\server
```


#### The optional but handy workspaces

_WorkspaceTags_ provide:

* A variable to an absoute path.
* Derived variables for all dirtags that have a matching path under each workspace.


_Consider this dirtags.json:_

```
{
  "dirTags": [
    {
      "name": "serverdocs",
      "path": "docs\\internal\\server"
    },
    {
      "name": "servercode",
      "path": "src\\server"
    }
  ],
  "workspaceTags": [
    {
        "name": "mainline",
        "path": "C:\\project1"
    },
    {
        "name": "devline",
        "path": "C:\\features\\project2"
    }
  ]
}
```

Variables `$mainline` `$devline` are now registered and work as expected.

```
PS C:\> cd $devline
PS C:\features\project2>
```

In addition, each dirTag is checked for existence in each workspace. These variables now exist as well:

`$mainline_serverdocs` points to `C:\project1\docs\internal\server`

`$mainline_servercode` points to `C:\project1\src\server`

`$devline_serverdocs`  points to `C:\features\project2\docs\internal\server`

`$devline_servercode`  points to `C:\features\project2\src\server`

As with any variable, you may locate them via tab completion.


Usage
-----

### Step 1: Installation

#### Via [PowerShell Gallery](https://www.powershellgallery.com)

    Install-Module -Name PSDirTag -Scope CurrentUser

#### Via GitHub

Clone or download to `$env:homepath\documents\WindowsPowerShell\Modules`


### Step 2: Configuration

Place a json config file named `dirtags.json` in your `$profile` folder.

#### Example `dirtags.json` file:

```
{
  "dirTags": [
    {
      "name": "projtools",
      "path": "src\\tools"
    },
    {
      "name": "appimg",
      "path": "resources\\data\\images"
    }
  ]
}
```

### Step 3: Load the module

    Import-Module PSDirTag

optional debug mode

    import-module PSDirTag -force -verbose -ArgumentList $true

Either of these lines may be placed in the PowerShell profile script, accessible via variable `$PROFILE`.


Uninstallation
--------------

Run the following

        Unregister-DirtagsPrompt; Remove-Module PSDirTag

I'm not sure yet how to clean up the prompt when `Remove-Module` is called. Closing and reopening the shell will do the same.


TODO
----

* Support multiple possible paths per tag.
