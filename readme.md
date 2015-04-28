PS-DirTags
==========

Usage
-----

Installation (normal)
---------------------



Installation (debug)
---------------------

		import-module ps-dirtag -force -verbose -ArgumentList $true


Configuration
-------------

Place a json config file named `.dirtags` in your `$profile` folder.

### Example `.dirtags` file:

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

Uninstallation
--------------

Run the following

        Unregister-DirtagsPrompt
        Remove-Module PS-DirTags

I'm not sure yet how to clean up the prompt when `Remove-Module` is called.


TODO
----

* Support multiple possible paths per tag.
* Support workspaces
* Add overview and examples.