# importir
Bash script to list your actual dependencies of your node.js project, support CommonJS require and ES6 import

<p>
  <a href="#how-it-works">How it works |</a>
  <a href="#installation">Installation |</a>
  <a href="#in-action">In Action | </a>
  <a href="#todo">Todo |</a>
  <a href="#licenses">License</a>
  <br><br>
  <blockquote>
  Bash script to list your actual dependencies of your node.js project
  
  support CommonJS require and ES6 import
  </blockquote>
</p>

How It Works
------------
```
Dependencies will be listed by applying regex to every js file in target directory

There are 2 regex that will be used to determine a dependency
require regex, require\(['\"]\K([a-zA-Z][^'\"/]*)(?=['\"]\))
import regex, import\s(.*)\sfrom\s['\"]\K([a-zA-Z][^'\"/]*)(?=['\"])
These two regex will be applied to js file using grep with Perl Regex options (-P)

Notes: These are simple regex and may not be reliable in some case (only tested for few cases)
```


Installation
----------- 
* git clone
* chmod +x importir.sh (optional)
* move to your PATH, maybe remove .sh if you want (optional)
```bash
  NAME:
    importir - bash script to list node.js project dependencies

  USAGE:
    importir command [command options] [arguments...]

  VERSION:
    0.0.1

  AUTHOR:
    Adhitya Ramadhanus <adhitya.ramadhanus@gmail.com>

  COMMANDS:
      list        List all dependencies in target dir (current directory by default)
      help        See help
      version     See current version
```
In Action
----------------
(soon)

Todo
----------------
* I don't know, give me some suggestions

License
----

MIT © [Adhitya Ramadhanus]

