function natural_scrolling -d "enable natural scrolling for the mouse"
    set ID (xinput --list | grep Logitech | awk '{print $7}' | awk -F'=' '{print $2;}')
    xinput --set-button-map $ID 1 2 3 5 4
end
