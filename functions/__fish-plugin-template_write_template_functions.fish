function __fish-plugin-template_write_template_functions 
    # --argument-names 'plugin' '_flag_debug'
    argparse 'd/debug' -- $argv
    or return 1

    set --local plugin $argv[1]
    set --local filepath "./functions/$plugin.fish"
    set --local version_variable (string replace -a - _ $plugin)

    if not test -n "$plugin"
        echo "code failed: [__fish-plugin-template_write_template_functions]"
        return 1
    end

    # color
    set --local cc (set_color $__fish_plugin_templete_color_color)
    set --local cn (set_color $__fish_plugin_templete_color_normal)
    set --local ca (set_color $__fish_plugin_templete_color_accent)
    set --local ce (set_color $__fish_plugin_templete_color_error)

    set -q _flag_debug; and echo $ce"Debug point: [__fish-plugin-template_write_template_functions ]"$cn

builtin printf -- '%s\n' \
"# function template generated from 'fish-plugin-template'
function $plugin -d 'DISCRIPTION'
    argparse \\
        -x 'v,h' \\
        'v/version' 'h/help' -- \$argv
    or return 1

    set --local version_$version_variable 'v0.0.1'
    ## color template set
    # set --local cc (set_color \$fish_color_comment)
    # set --local ce (set_color \$fish_color_error)
    # set --local cn (set_color \$fish_color_normal)

    if set -q _flag_version
        echo \"$plugin: \" \$version_$version_variable
    else if set -q _flag_help
        __"$plugin"_help
    else
        # main body
    end
end

# helper function
function __"$plugin"_help
    printf '%s\n' \\
        'USAGE:' \\
        '      $plugin [OPTION]' \\
        'OPTIONS:' \\
        '      -v, --version       Show version info' \\
        '      -h, --help          Show help'
end
    " >> "$filepath"

    if test "$status" = "0"
        echo $ca"-->added template:"$cc "$filepath" $cn
    else
        echo $ce"-->failed to write:"$cc "$filepath" $cn
    end
end

