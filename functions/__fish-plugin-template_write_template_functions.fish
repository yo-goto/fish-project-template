function __fish-plugin-template_write_template_functions 
    # --argument-names 'plugin' 'bool_debug'
    argparse 'd/debug' -- $argv
    or return 1

    set --local plugin $argv[1]
    set --local filepath "./functions/$plugin.fish"

    if not test -n "$plugin"
        echo "code failed: [2]"
        return 1
    end

    # color
    set --local cc (set_color $__fish_plugin_templete_color_color)
    set --local cn (set_color $__fish_plugin_templete_color_normal)
    set --local ca (set_color $__fish_plugin_templete_color_accent)
    set --local ce (set_color $__fish_plugin_templete_color_error)

    set -q _flag_debug; and echo $ce"Debug point: [D]"$cn

    printf -- '%s\n' \
    "# generated function template from fish-plugin" \
    "function $plugin -d 'DISCRIPTION'" \
    "   argparse \ " \
    "       -x 'v,h' \ " \
    "       'v/version' 'h/help' -- \$argv" \
    "   or return 1" \
    "   " \
    "   set --local version_$plugin 'v0.0.1'" \
    "   # color template set" \
    "   set --local cc (set_color \$fish_color_comment)" \
    "   set --local ce (set_color \$fish_color_error)" \
    "   set --local cn (set_color \$fish_color_normal)" \
    "   " \
    "   if set -q _flag_version" \
    "       echo \"$plugin: \" \$version_$plugin" \
    "       return" \
    "   else if set -q _flag_help" \
    "       __"$plugin"_help" \
    "       return" \
    "   else" \
    "       # main body" \
    "   end" \
    "end" \
    "" \
    "# helper function" \
    "function __"$plugin"_help" \
    "   echo 'USAGE:'" \
    "   echo '      $plugin [OPTION]'" \
    "   echo 'OPTIONS:'" \
    "   echo '      -v, --version       Show version info'" \
    "   echo '      -h, --help          Show help'" \
    "end" \
    "   " >> "$filepath"

    if test "$status" = "0"
        echo $ca"-->added template:"$cc "$filepath" $cn
    else
        echo $ce"-->failed to write:"$cc "$filepath" $cn
    end
end
