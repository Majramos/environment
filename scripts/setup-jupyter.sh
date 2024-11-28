#!/usr/bin/env bash

JUPYTER_CONFIG_PATH=$(jupyter --config-dir)

if [ ! -f "$JUPYTER_CONFIG_PATH/jupyter_server_config.py" ]; then
    echo "jupyter_server_config.py not found, creating one"
    jupyter server --generate-config
fi

# use this to show hidden files
sed -i 's/c.ContentsManager.allow_hidden = False/c.ContentsManager.allow_hidden = True/' $JUPYTER_CONFIG_PATH/jupyter_server_config.py
sed -i 's/# c.ContentsManager.allow_hidden = True/c.ContentsManager.allow_hidden = True/' $JUPYTER_CONFIG_PATH/jupyter_server_config.py

# get location of default settings
OVERRIDES_PATH=$(jupyter lab path | sed -n 's/Application directory:\s*\(.*\)/\1\/settings/p')

mkdir -pv $OVERRIDES_PATH

# set new default settings
echo '
{
    "@jupyterlab/apputils-extension:themes": {
        "theme": "JupyterLab Dark",
        "theme-scrollbars": true
    },
    "@jupyterlab/fileeditor-extension:plugin": {
        "scrollPastEnd": true,
        "editorConfig": {
            "autoClosingBrackets": true,
            "codeFolding": true,
            "highlightTrailingWhitespace": true,
            "rulers": [80, 100]
        }
    },
    "@jupyterlab/notebook-extension:tracker": {
        "codeCellConfig": {
            "lineNumbers": true,
            "matchBrackets": true,
            "autoClosingBrackets": true
        },
        "markdownCellConfig": {
            "lineNumbers": false,
            "matchBrackets": false
        },
        "rawCellConfig": {
            "lineNumbers": true,
            "matchBrackets": true,
            "autoClosingBrackets": true
        }
    }
}
' > $OVERRIDES_PATH/overrides.json
