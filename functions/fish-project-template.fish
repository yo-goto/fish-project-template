function fish-project-template -d "Make a fisher template project"
    argparse \
        -x 'v,h,d' \
        'v/version' 'h/help' 'd/debug' \
        'a/add_template' \
        -- $argv
    or return 1
    
    set --local version_fish_project_template "v0.0.1"

    # color
    set --local cn (set_color $__fish_project_templete_color_normal)
    set --local ce (set_color $__fish_project_templete_color_error)

    # template directories & files for the proejct 
    set --local list_create_dir "functions" "completions" "conf.d" 
    set --local list_create_dir_test "tests"
    set --local list_create_files "README" "CHANGELOG" "LICENSE"
    set --local list_all $list_create_dir $list_create_dir_test $list_create_files

    # set target name for a plugin name or direcotry name
    set --local target_first $argv[1]
    set --local target_second_file_name $argv[2]

    if set -q _flag_version
        echo "fish-project-template:" $version_fish_project_template
        return
    else if set -q _flag_help
        __fish-project-template_help
        return
    else if test -n "$target_first"
        if contains $target_first $list_all

            if test -n "$target_second_file_name"
                # for list_create_dir
                if contains $target_first $list_create_dir
                    set -q _flag_debug; and echo $ce"Debug Point: [Z-1]"$cn
                    # --argument-names 'directory' 'base_name' 'extension' '_flag_create_file' '_flag_add_template' '_flag_debug'
                    __fish-proejct-template_make_template "$target_first" "$target_second_file_name" ".fish" --create_file $_flag_add_template $_flag_debug
                    return
                end

                # for list_create_dir_test
                if contains $target_first $list_create_dir_test
                    set -q _flag_debug; and echo $ce"Debug Point: [Z-2]"$cn
                    # --argument-names 'directory' 'base_name' 'extension' '_flag_create_file' '_flag_add_template' '_flag_debug'
                    __fish-proejct-template_make_template "$target_first" "$target_second_file_name" ".fish" --create_file $_flag_add_template $_flag_debug
                    return
                end
            else
                echo $ce"Please pass a file name to the second argument"$cn
                return 1
            end

            # for list_create_files
            if contains $target_first $list_create_files
                set -q _flag_debug; and echo $ce"Debug Point: [Z-3]"$cn
                # --argument-names 'directory' 'base_name' 'extension' '_flag_create_file' '_flag_add_template' '_flag_debug'
                __fish-proejct-template_make_template "root" "$target_first" ".md" --create_file $_flag_add_template $_flag_debug
                return
            end
        end
    else
        __fish-project-template_interactive $_flag_debug
    end
end


# helper functions
function __fish-project-template_help
    set_color $__fish_project_templete_color_color
    echo 'Usage: '
    echo '      fish-project-template [OPTION]'
    echo 'Options: '
    echo '      -v, --version   Show version info'
    echo '      -h, --help      Show help'
    echo '      -d, --debug     Show debug tests'
    set_color normal
end
