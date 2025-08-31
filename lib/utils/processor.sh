#!/bin/bash

# mark - Template processing utilities

# Function to handle #if conditional blocks
process_if_blocks() {
    local content="$1"
    
    # Process {{#if condition}}...{{/if}} blocks
    while [[ "$content" =~ \{\{#if[[:space:]]+([^}]+)\}\}(.*)\{\{/if\}\} ]]; do
        local condition="${BASH_REMATCH[1]}"
        local block_content="${BASH_REMATCH[2]}"
        
        # Check if condition is truthy (non-empty and not "false")
        local condition_value=""
        if [[ -n "${!condition}" ]]; then
            condition_value="${!condition}"
        fi
        
        local replacement=""
        if [[ -n "$condition_value" && "$condition_value" != "false" ]]; then
            # Condition is true, include the block content
            replacement="$block_content"
        else
            # Condition is false, exclude the block content
            replacement=""
        fi
        
        # Replace the entire block
        content="${content//\{\{#if $condition\}\}$block_content\{\{\/if\}\}/$replacement}"
    done
    
    echo "$content"
}

# Function to handle #each loop blocks
process_each_blocks() {
    local content="$1"
    
    # Process {{#each array}}...{{/each}} blocks
    while [[ "$content" =~ \{\{#each[[:space:]]+([^}]+)\}\}(.*)\{\{/each\}\} ]]; do
        local array_name="${BASH_REMATCH[1]}"
        local block_template="${BASH_REMATCH[2]}"
        
        # Look for indexed items (array_name_0, array_name_1, etc.)
        local replacement=""
        local index=0
        
        # Build the variable name and check if it exists
        local var_name="${array_name}_${index}"
        while [[ -n "${!var_name}" ]]; do
            local item_value="${!var_name}"
            
            # Replace {{this}} with the current item
            local item_replaced="$block_template"
            item_replaced="${item_replaced//\{\{this\}\}/$item_value}"
            
            # Also replace {{@index}} with the current index
            item_replaced="${item_replaced//\{\{@index\}\}/$index}"
            
            replacement="$replacement$item_replaced"
            
            # Increment index and build next variable name
            index=$((index + 1))
            var_name="${array_name}_${index}"
        done
        
        # If no indexed items found, check if there's a direct value
        if [[ -z "$replacement" && -n "${!array_name}" ]]; then
            local item_value="${!array_name}"
            local item_replaced="$block_template"
            item_replaced="${item_replaced//\{\{this\}\}/$item_value}"
            replacement="$item_replaced"
        fi
        
        # Replace the entire block
        content="${content//\{\{#each $array_name\}\}$block_template\{\{\/each\}\}/$replacement}"
    done
    
    echo "$content"
}