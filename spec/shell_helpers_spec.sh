#shellcheck shell=sh

Describe 'Evaluating shell_helplers functions: '
    Include lib/shell_helpers.sh

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
    
    Describe 'The is_float function'
        It 'checks if a number is a float'
            When call is_float 1.1 && echo true
            The status should be success
        End

        It 'checks if a number is a float'
            When call is_float 1 && echo true
            The status should be failure
        End
    End

    Describe 'The is_int function'
        It 'checks if a number is an integer'
            When call is_int 1 && echo true
            The status should be success
        End

        It 'checks if a number is an integer'
            When call is_int 1.1 && echo true
            The status should be failure
        End
    End

End