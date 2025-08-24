#!/bin/bash

# Script to fix wakelock namespace issue
# This script will add namespace to wakelock android build.gradle

WAKELOCK_PATH="$HOME/.pub-cache/hosted/pub.dev/wakelock-0.6.2/android/build.gradle"

if [ -f "$WAKELOCK_PATH" ]; then
    echo "Found wakelock build.gradle at $WAKELOCK_PATH"
    
    # Check if namespace already exists
    if ! grep -q "namespace" "$WAKELOCK_PATH"; then
        echo "Adding namespace to wakelock build.gradle"
        
        # Add namespace after 'android {' line
        sed -i '/android {/a\    namespace "com.github.creativecreatorormaybenot.wakelock"' "$WAKELOCK_PATH"
        
        echo "Namespace added successfully"
    else
        echo "Namespace already exists in wakelock build.gradle"
    fi
else
    echo "Wakelock build.gradle not found at $WAKELOCK_PATH"
fi
