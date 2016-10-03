" Variable definitions "{{{
let g:cf_pl_gcc = "10"
let g:cf_pl_gcc11 = "43"
let g:cf_pl_gpp = "1"
let g:cf_pl_gpp11 = "42"
let g:cf_pl_go = "32"
let g:cf_pl_haskel = "12"
let g:cf_pl_java_7 = "23"
let g:cf_pl_java_8 = "36"
let g:cf_pl_fpc = "4"
let g:cf_pl_perl = "13"
let g:cf_pl_php = "6"
let g:cf_pl_python_2 = "7"
let g:cf_pl_python_3 = "31"
let g:cf_pl_ruby = "8"
let g:cf_pl_scala = "20"
let g:cf_pl_js = "34"

let g:cf_pl_by_ext =    {'.cpp': g:cf_pl_gpp,
                        \'.cc': g:cf_pl_gpp,
                        \'.c': g:cf_pl_gcc,
                        \'.pas': g:cf_pl_fpc,
                        \'.php': g:cf_pl_php,
                        \'.java': g:cf_pl_java_7,
                        \'.py': g:cf_pl_python_3}

if !exists('g:cf_cookies_file')
    let g:cf_cookies_file = expand('~/.cf_cookies')
endif

if !exists('g:cf_default_language')
    let g:cf_default_language = g:cf_pl_gpp
endif

if !exists('g:cf_locale')
    let g:cf_locale = "en"
endif

if !exists('g:cf_test_command')
    let g:cf_test_command = "g++ %s;
                            \cnt=0;
                            \for i in `ls %s/*.in | sed 's/.in//'`; do
                            \   let cnt++;
                            \   echo \"\nTEST $cnt\";
                            \   ./a.out < $i.in | diff -y - $i.out;
                            \done;
                            \rm a.out;"
endif

"}}}
" Command definitions "{{{
command! -nargs=0 CFLogin call cfparser#CFLogin()
command! -nargs=0 CFLogout call cfparser#CFLogout()
command! -nargs=0 CFWhoAmI call cfparser#CFWhoAmI()
command! -nargs=0 CFProblemStatement call cfparser#CFProblemStatement()
command! -nargs=0 CFDownloadTests call cfparser#CFDownloadTests()
command! -nargs=0 CFTestAll call cfparser#CFTestAll()
command! -nargs=0 CFSubmit call cfparser#CFSubmit()
command! -nargs=? CFLastSubmissions call cfparser#CFLastSubmissions(<args>)

"}}}
" Keys definitions "{{{
nmap <leader>cfi :CFLogin<CR>
nmap <leader>cfo :CFLogout<CR>
nmap <leader>cfw :CFWhoAmI<CR>
nmap <leader>cfp :CFProblemStatement<CR>
nmap <leader>cfd :CFDownloadTests<CR>
nmap <leader>cft :CFTestAll<CR>
nmap <leader>cfs :CFSubmit<CR>
nmap <leader>cfl :CFLastSubmissions<CR>
"}}}
" vim:foldmethod=marker:foldlevel=0
