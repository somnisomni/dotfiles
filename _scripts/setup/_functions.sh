#!/usr/bin/env bash

MODULE_SCRIPT_FILE_NAME="module.sh"
MODULE_META_FILE_NAME="module.meta"

function get_available_modules_dirname() {
    local -n target_array=$1
    local modules=()

    for dir in "$BASEDIR/$MODULES_DIR"/*; do
        if [ -r "$dir/$MODULE_SCRIPT_FILE_NAME" ] \
           && [ -r "$dir/$MODULE_META_FILE_NAME" ]; then
            modules+=("$(basename $dir)")
        fi
    done

    target_array=("${modules[@]}")
}

function build_dialog_module_items() {
    local -n target_array=$1
    local module_dirs=()
    local dialog_items=()

    get_available_modules_dirname module_dirs

    for dir in "${module_dirs[@]}"; do
        module_dir="$BASEDIR/$MODULES_DIR/$dir"

        local MODULE_NAME="$dir"
        local MODULE_DESC="No description available"
        local MODULE_DEFAULT="off"

        source "$module_dir/$MODULE_META_FILE_NAME"

        dialog_items+=("$dir" "$MODULE_NAME" "$MODULE_DEFAULT")
    done
    
    target_array=("${dialog_items[@]}")
}

function execute_module_by_id() {
    local module_id=$1
    local module_path="$BASEDIR/$MODULES_DIR/$module_id"
    local module_script="$module_path/$MODULE_SCRIPT_FILE_NAME"

    if [ -z "$module_id" ]; then
        echo "[Error] Module ID is not specified for 'execute_module_by_id' function"
        return 1
    fi

    if ! [ -d "$module_path" ]; then
        echo "[Error] Module directory for ID '$module_id' is not found"
        return 1
    fi

    if ! [ -f "$module_script" ]; then
        echo "[Error] Module script for ID '$module_id' is not found"
        return 1
    fi

    bash $module_script
    return $?
}