@ECHO OFF
IF NOT EXIST plugged (
    mkdir autoload
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('~\vimfiles\autoload\plug.vim'))"
    vim +PlugInstall +qall
) ELSE (
    echo "vim config is initialized already."
)
