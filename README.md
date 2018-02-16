# cfparser.vim
A [codeforces](http://codeforces.com) helper plugin for vim, ported from emacs plugin [gnull/cfparser](https://github.com/gnull/cfparser).

## Installation
- Install `curl`.
- Install `cfparser.vim` with your favorite vim plugin manager. If you use [`vim-plug`](https://github.com/junegunn/vim-plug):

```
Plug 'gabrielsimoes/cfparser.vim'
```

### Optional setup
You can setup some variables at your .vimrc:
- `g:cf_cookies_file` - File in which `curl` will store cookies (default: `'~/.cf_cookies'`)
- `g:cf_default_language` - Language to be used when it it not recognized from file extension. Languages codes are available at `plugin/cfparser.vim`. The default is `"54"` which corresponds to `C++17`, as defined in the variable `g:cf_pl_gpp`.
- `g:cf_pl_by_ext_custom` - A dictionary from file extension to language code to override the defaults. `cfparser.vim` will first check in the custom map, and if not found it will check the default map, and finally `g:cf_default_language`. If you prefer `C++11` over `C++17`, for example:

```vim
let g:cf_pl_by_ext_custom = {'.cpp': "42"}
```

- `g:cf_locale` - Language to download problem statement. Either `"ru"` or `"en"` (default: `"en"`)
- You can also redefine the function `cfparser#CFTestAll()`, that is, the function that is called to test your solution against test files. The default definition is as follows. You can redefine the function by writing your own version of it at your `.vimrc`, *after* loading `cfparser.vim`.

```vim
function! cfparser#CFTestAll()
    echo system(printf("g++ %s -o /tmp/cfparser_exec;
                        \cnt=0;
                        \for i in `ls %s/*.in | sed 's/\\.in$//'`; do
                        \   let cnt++;
                        \   echo \"\nTEST $cnt\";
                        \   /tmp/cfparser_exec < $i.in | diff -y - $i.out;
                        \done;
                        \rm /tmp/cfparser_exec",
        \ expand('%:p'), expand('%:p:h')))
endfunction
```

This will compile the file with `g++` and test it against `0.in` and `0.out`, `1.in` and `1.out`, etc...

- You also redefine the function `cfparser#CFRun()`, the function that is called to test your solution in an interactive shell. You can redefine it by writing your own version of it at your `.vimrc`, after loading `cfparser.vim`. The default definition is below:

```vim
function! cfparser#CFRun()
    echo system(printf("g++ %s -o /tmp/cfparser_exec", expand('%s:p')))
    RunInInteractiveShell /tmp/cfparser_exec
    call system("rm /tmp/cfparser_exec")
endfunction
```

This will compile the file with `g++` and run it with the command `RunInteractiveShell`, which is provided by the following plugin: [christoomey/vim-run-interactive](https://github.com/christoomey/vim-run-interactive).

## Usage
- `<leader>cfi` - Log**i**n (calls `CFLogin()`)
- `<leader>cfo` - Log**o**ut (calls `CFLogout()`)
- `<leader>cfw` - **W**ho am I (calls `CFWhoAmI()`)
- `<leader>cfp` - Display **p**roblem statement (calls `CFProblemStatement()`)
- `<leader>cfd` - **D**ownload sample tests to current code folder (0.in, 0.out, 1.in ...) (calls `CFDownloadTests()`)
- `<leader>cft` - Runs code with sample **t**ests (calls `CFTestAll()`)
- `<leader>cfr` - **R**uns code in an interactive shell (calls `CFRun()`)
- `<leader>cfs` - **S**ubmit current open file (calls `CFSubmit()`)
- `<leader>cfl` - **L**ist most recent submissions (calls `CFLastSubmissions()` without arguments - can be called with username as argument, default to logged in user)

When using the submit, download sample tests and problem statement functions, cfparser will "guess" the contest number, problem index and the programming language by the current file name. It should be in one of the following forms: (it could be any extension besides .cpp)
- `directory/123/A/myfile.cpp`
- `directory/123/A.cpp`
- `directory/123A.cpp`

