# cfparser.vim
A [codeforces](http://codeforces.com) plugin for vim, ported from emacs plugin [gnull/cfparser](https://github.com/gnull/cfparser).

## Installation
- Install `curl`
- Install `cfparser.vim` with your favorite plugin manager. With `vim-plug`:

```
Plug 'gabrielsimoes/cfparser.vim'
```

### Optional setup
You can setup some variables at your .vimrc:
- `g:cf_cookies_file` - File in which `curl` will store cookies (default: `'~/.cf_cookies'`)
- `g:cf_default_language` - Language to be used when it it not recognized from file extension (default: g:cf_pl_gpp - g++). Languages are mapped in `plugin/cfparser.vim`
- `g:cf_locale` - Language to download problem statement. Either `"ru"` or `"en"` (default: `"en"`)
- You can also redefine the function `cfparser#CFTestAll()`, that is, the function that is called to test your solution against test files. The default definition is as follows. You can redefine the function by writing your own version of it at your `.vimrc`, *after* loading `cfparser.vim`.

```
function! cfparser#CFTestAll()
    echo system(printf("g++ %s;
                       \cnt=0;
                       \for i in `ls %s/*.in | sed 's/.in//'`; do
                       \   let cnt++;
                       \   echo \"\nTEST $cnt\";
                       \   ./a.out < $i.in | diff -y - $i.out;
                       \done;
                       \rm a.out;", expand('%:p'), expand('%:p:h')))
endfunction
```

This will compile the file with `g++` and test it against `0.in` and `0.out`, `1.in` and `1.out`, etc...

- You also redefine the function `cfparser#CFRun()`, the function that is called to test your solution in an interactive shell. You can redefine it by writing your own version of it at your `.vimrc`, after loading `cfparser.vim`. The default definition is below:

```
function! cfparser#CFRun()
    echo system(printf("g++ %s", expand('%s:p')))
    RunInInteractiveShell ./a.out
    call system("rm a.out")
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
- `<leader>cfr` - *R*uns code in an interactive shell (calls `CFRun()`)
- `<leader>cfs` - **S**ubmit current open file (calls `CFSubmit()`)
- `<leader>cfl` - **L**ist most recent submissions (calls `CFLastSubmissions()` without arguments - can be called with username as argument, default to logged in user)

Submit, download sample tests and problem statement functions "guess" the contest number, problem index and the programming language by the current file name in one of the following forms:
- `directory/505/A/myfile.cpp`
- `directory/505/a.c`
- `directory/505a.cc`

