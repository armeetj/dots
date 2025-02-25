function showcolors
    # Define standard ANSI color names
    set color_names black red green yellow blue magenta cyan white brblack brred brgreen bryellow brblue brmagenta brcyan brwhite

    # Print named colors in a 2×8 vertical layout
    echo "Standard ANSI Colors:"
    for i in (seq 0 7)
        set color_name1 (echo $color_names | cut -d' ' -f (math $i + 1))
        set color_name2 (echo $color_names | cut -d' ' -f (math $i + 9))
        printf "\e[48;5;%dm   \e[0m %-9s (%2d)      \e[48;5;%dm   \e[0m %-9s (%2d)  \n" \
            $i $color_name1 $i \
            (math $i + 8) $color_name2 (math $i + 8)
    end

    echo -e "\n256-Color Palette:"

    # Print all 256 colors in a grid format
    for i in (seq 0 255)
        printf "\e[48;5;%dm   \e[0m%3d " $i $i
        if test (math "$i % 16") -eq 15
            echo
        end
    end

    # Reset colors
    echo -e "\e[0m"
end
