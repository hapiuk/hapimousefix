#!/bin/bash
# Script to adjust mouse sensitivity with polling rate detection and Zenity popups for all messages

# Detect mouse polling rate using evtest
get_polling_rate() {
    POLLING_RATE=$(sudo evtest --grab /dev/input/eventX | grep -oP '\d+Hz' | head -n1)
    if [ -z "$POLLING_RATE" ]; then
        zenity --error --title="Polling Rate Detection Failed" --text="Unable to detect the mouse polling rate."
        exit 1
    else
        zenity --info --title="Polling Rate Detected" --text="Mouse Polling Rate: $POLLING_RATE"
    fi
}

# Adjust sensitivity based on polling rate
adjust_sensitivity_based_on_polling() {
    if [[ $POLLING_RATE == "1000Hz" ]]; then
        xinput --set-prop 'HID 1bcf:08a0 Mouse' 'Coordinate Transformation Matrix' 0.3 0 0 0 0.7 0 0 0 1
        FIX_APPLIED="Sensitivity set to 0.3x Horizontal, 0.7x Vertical for 1000Hz polling rate."
    elif [[ $POLLING_RATE == "500Hz" ]]; then
        xinput --set-prop 'HID 1bcf:08a0 Mouse' 'Coordinate Transformation Matrix' 0.4 0 0 0 0.8 0 0 0 1
        FIX_APPLIED="Sensitivity set to 0.4x Horizontal, 0.8x Vertical for 500Hz polling rate."
    else
        xinput --set-prop 'HID 1bcf:08a0 Mouse' 'Coordinate Transformation Matrix' 0.5 0 0 0 0.9 0 0 0 1
        FIX_APPLIED="Default sensitivity set: 0.5x Horizontal, 0.9x Vertical."
    fi

    if [ $? -eq 0 ]; then
        zenity --info --title="Mouse Sensitivity Adjusted" --text="$FIX_APPLIED"
    else
        zenity --error --title="Mouse Sensitivity Adjustment Failed" --text="An error occurred while applying the sensitivity settings."
        exit 1
    fi
}

# Reset sensitivity to default
reset_sensitivity() {
    xinput --set-prop 'HID 1bcf:08a0 Mouse' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
    if [ $? -eq 0 ]; then
        zenity --info --title="Mouse Sensitivity Restored" --text="Mouse sensitivity has been restored to default settings."
    else
        zenity --error --title="Mouse Sensitivity Restoration Failed" --text="An error occurred while restoring the default settings."
        exit 1
    fi
}

# Main logic
if [ "$1" == "start" ]; then
    get_polling_rate
    adjust_sensitivity_based_on_polling
elif [ "$1" == "end" ]; then
    reset_sensitivity
fi
