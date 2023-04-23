#shellcheck shell=sh

Describe 'Evaluating shell_helplers functions: '
    Include lib/bash_helpers.sh

    Describe 'The trim_string function'
        It 'trims leading and trailing white-space from string'
            When call trim_string "    Hello,  World    "
            The output should eq 'Hello,  World'
        End

        It 'trims leading and trailing white-space from string'
            name="   John Black  "
            When call trim_string "$name"
            The output should eq 'John Black'
        End
    End

    Describe 'The trim_all function'
        It 'trims all white-space from string and truncate spaces'
            When call trim_all "    Hello,    World    "
            The output should eq 'Hello, World'
        End

        It 'trims all white-space from string and truncate spaces'
            name="   John   Black  is     my    name.    "
            When call trim_all "$name"
            The output should eq 'John Black is my name.'
        End
    End

    # Describe 'The regex function'
        # It 'uses regex on a string'
        #     When call regex '    hello' '^\s*(.*)'
        #     The output should eq 'hello'
        # End

        # It 'validates a hex color.'
        #     When call regex "#FFFFFF" '^(#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3}))$'
        #     The output should eq '#FFFFFF'
        # End

        # It 'validates a hex color (invalid).'
        #     When call is_hex_color "$color" || color="#FFFFFF"
        #     The output should eq "#FFFFFF"
        # End
    # End

    Describe 'The split function'
        # It 'splits a string on a delimiter'
        #     When call split "a,b,c" ","
        #     The output should eq 'a b c'
        # End

        # It 'splits a string on a delimiter'
        #     When call split "hello---world---my---name---is---john" "---"
        #     The output should eq '(hello world my name is john)'
        # End
    End

    Describe 'The lower function'
        It 'changes a string to lowercase'
            When call lower "HELLO"
            The output should eq 'hello'
        End
    End

    Describe 'The upper function'
        It 'changes a string to uppercase'
            When call upper "HeLlO"
            The output should eq 'HELLO'
        End
    End

    Describe 'The reverse_case function'
        It 'reverses a string case'
            When call reverse_case "HeLlO"
            The output should eq 'hElLo'
        End
    End

    Describe 'The trim_quotes function'
        It 'trims quotes from a string'
            var="'Hello', \"World\""
            When call trim_quotes "$var"
            The output should eq 'Hello, World'
        End
    End

    Describe 'The strip_all function'
        It 'strips all instances of pattern from string'
            When call strip_all "The Quick Brown Fox" "[aeiou]"
            The output should eq 'Th Qck Brwn Fx'
        End
    End

    Describe 'The strip function'
        It 'strips first occurrence of pattern from string'
            When call strip "The Quick Brown Fox" "[aeiou]"
            The output should eq 'Th Quick Brown Fox'
        End

        It 'strips first occurrence of pattern from string'
            When call strip "The Quick Brown Fox" "[[:space:]]"
            The output should eq 'TheQuick Brown Fox'
        End
    End

    Describe 'The lstrip function'
        It 'strips pattern from start of string'
            When call lstrip "The Quick Brown Fox" "The "
            The output should eq 'Quick Brown Fox'
        End
    End

    Describe 'The rstrip function'
        It 'strips pattern from end of string'
            When call rstrip "The Quick Brown Fox" " Fox"
            The output should eq 'The Quick Brown'
        End
    End

    Describe 'The urlencode function'
        It 'percent-encodes a string'
            When call urlencode "https://github.com/dylanaraps/pure-bash-bible"
            The output should eq 'https%3A%2F%2Fgithub.com%2Fdylanaraps%2Fpure-bash-bible'
        End
    End

    Describe 'The urldecode function'
        It 'decodes a percent-encoded string'
            When call urldecode "https%3A%2F%2Fgithub.com%2Fdylanaraps%2Fpure-bash-bible"
            The output should eq 'https://github.com/dylanaraps/pure-bash-bible'
        End
    End



    Describe 'The trim_string function'
        It 'trims leading and trailing white-space from string'
            When call trim_string "    Hello,  World    "
            The output should eq 'Hello,  World'
        End
    
        It 'trims leading and trailing white-space from string'
            name="   John Black  "
            When call trim_string "$name"
            The output should eq 'John Black'
        End
    End

    Describe 'The trim_all function'
        It 'trims all white-space from string and truncate spaces'
            When call trim_all "    Hello,    World    "
            The output should eq 'Hello, World'
        End

        It 'trims all white-space from string and truncate spaces'
            name="   John   Black  is     my    name.    "
            When call trim_all "$name"
            The output should eq 'John Black is my name.'
        End
    End

    # Describe 'The split function'
    #     It 'splits a string on a delimiter'
    #         When call split "apples,oranges,pears,grapes" ","
    #         The output should eq "apples
    #         oranges
    #         pears
    #         grapes"
    #     End

    #     It 'splits a string on a delimiter'
    #         When call split "1, 2, 3, 4, 5" ", "
    #         The output should eq '1 2 3 4 5'
    #     End
    # End

    Describe 'The trim_quotes function'
        It 'trims quotes from a string'
            var="'Hello', \"World\""
            When call trim_quotes "$var"
            The output should eq 'Hello, World'
        End
    End

    Describe 'The head function'
        It 'gets the first N lines of a file'
            When call head 1 spec/shell_helpers_spec.sh
            The output should eq '#shellcheck shell=sh'
        End
    End

    Describe 'The lines function'
        setup(){ 
            touch /tmp/deleteme
            printf "line 1\nline2" > /tmp/deleteme
            }
        cleanup(){ rm /tmp/deleteme;}
        BeforeCall 'setup'
        AfterCall 'cleanup'

        It 'gets the number of lines in a file'
            When call lines /tmp/deleteme
            The output should eq 2
        End
    End

    # Describe 'The count function'
    #     setup(){ 
    #         tmp_dir=$(mktemp -d)
    #         mktemp "${tmp_dir}"/script1.XXXXXX
    #         mktemp "${tmp_dir}"/script2.XXXXXX
    #         }
    #     cleanup(){ rm -rf "${tmp_dir}";}
    #     BeforeCall 'setup'
    #     AfterCall 'cleanup'
        
    #     It 'counts files or directories in directory'
    #         When call count "${tmp_dir}/"
    #         The output should eq 2
    #     End
    # End

    Describe 'The dirname function'
        It 'gets the directory name of a file path'
            When call dirname "$HOME/Pictures/Wallpapers/1.jpg"
            The output should eq "$HOME/Pictures/Wallpapers"
        End

        It 'gets the directory name of a file path'
            When call dirname "$HOME/Pictures/Downloads/"
            The output should eq "$HOME/Pictures"
        End
    End

    Describe 'The basename function'
        It 'gets the base-name of a file path'
            When call basename "$HOME/Pictures/Wallpapers/1.jpg"
            The output should eq "1.jpg"
        End

        It 'gets the base-name of a file path'
            When call basename "$HOME/Pictures/Wallpapers/1.jpg" .jpg
            The output should eq "1"
        End

        It 'gets the base-name of a file path'
            When call basename "$HOME/Pictures/Downloads"
            The output should eq "Downloads"
        End
    End
End