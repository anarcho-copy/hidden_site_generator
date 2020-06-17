#!/bin/bash
# https://gist.github.com/rosiba/d9c06fe15a661094d4da4565355225a8

# define replacements
declare -a repls=(
    "Ğg"
    "ğg"
    "Çc"
    "çc"
    "Şs"
    "şs"
    "Üu"
    "üu"
    "Öo"
    "öo"
    "İi"
    "ıi"
    " -"
    "--"
)

function slug() {
    slug=""

    for (( i=0; i<${#arg}; i++ )) 
    do
        char="${arg:$i:1}"
        ascii=$(printf "%d" "'$char")

        # if alphanumeric
        # locale encoding should be UTF-8 for this values to work
        if [[ ( $ascii -ge 48 && $ascii -le 57 ) || # numbers
            ( $ascii -ge 65 && $ascii -le 90 ) ||  # uppercase
            ( $ascii -ge 97 && $ascii -le 122 ) ]]; then # lowercase
            slug="$slug$char"
        else
            for (( j=0; j < ${#repls[@]}; j++ ))
            do
                from=${repls[$j]:0:1}
                to=${repls[$j]:1:1}
                if [[ $char == $from ]]; then
                    slug="$slug$to"
                    break
                fi
            done
        fi
    done

    if [[ $slug == "" ]]; then
        echo "words should contain at least one valid character"
        exit 1
    fi

    echo $slug | awk '{print tolower($0)}'
}

if tty -s
then
#FOR PARAMETERS
 for arg in "$@"
 do
  slug;
 done
else
##FOR READ PIPE
 while read arg;
 do
  slug;
 done
fi

