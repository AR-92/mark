#!/bin/bash

# mark - Template processing utilities

# Function to handle #if conditional blocks
process_if_blocks() {
    local content="$1"
    
    # Process {{#if condition}}...{{/if}} blocks with {{else}} support
    # Use a simple approach that works for non-nested blocks
    while [[ "$content" =~ \{\{#if[[:space:]]+([^}]+)\}\} ]]; do
        # Extract the condition
        local condition="${BASH_REMATCH[1]}"
        
        # Find the start position
        local start_marker="{{#if $condition}}"
        local before_content="${content%%$start_marker*}"
        local after_start="${content#*$start_marker}"
        
        # Find the end position by looking for the first {{/if}} after the start
        local block_content=""
        local after_content=""
        
        # Split at the first {{/if}} we find
        if [[ "$after_start" == *"{{/if}}"* ]]; then
            block_content="${after_start%%\{\{/if\}\}*}"
            local full_match="${start_marker}${block_content}{{/if}}"
            after_content="${content#*$full_match}"
        else
            # No matching {{/if}}, leave content as is
            break
        fi
        
        # Process the block content for else part
        local replacement=""
        if [[ "$block_content" == *"{{else}}"* ]]; then
            # Split the block content at the else marker
            local if_part="${block_content%%\{\{else\}\}*}"
            local else_part="${block_content#*\{\{else\}\}}"
            
            # Check if condition is truthy (non-empty and not "false")
            local condition_value=""
            if [[ -n "${!condition}" ]]; then
                condition_value="${!condition}"
            fi
            
            if [[ -n "$condition_value" && "$condition_value" != "false" ]]; then
                # Condition is true, include the if part
                replacement="$if_part"
            else
                # Condition is false, include the else part
                replacement="$else_part"
            fi
        else
            # No else part, handle as simple if block
            # Check if condition is truthy (non-empty and not "false")
            local condition_value=""
            if [[ -n "${!condition}" ]]; then
                condition_value="${!condition}"
            fi
            
            if [[ -n "$condition_value" && "$condition_value" != "false" ]]; then
                # Condition is true, include the block content
                replacement="$block_content"
            else
                # Condition is false, exclude the block content
                replacement=""
            fi
        fi
        
        # Reconstruct the content with the replacement
        content="${before_content}${replacement}${after_content}"
    done
    
    echo "$content"
}

# Function to handle #each loop blocks
process_each_blocks() {
    local content="$1"
    
    # Process {{#each array}}...{{/each}} blocks
    # Use a more precise approach to match blocks
    while [[ "$content" =~ \{\{#each[[:space:]]+([^}]+)\}\} ]]; do
        # Extract the array name
        local array_name="${BASH_REMATCH[1]}"
        
        # Find the start position of the block
        local start_marker="{{#each $array_name}}"
        local end_marker="{{/each}}"
        
        # Extract everything before the start marker
        local before_block="${content%%$start_marker*}"
        
        # Extract everything after the start marker
        local after_start="${content#*$start_marker}"
        
        # Extract the block content (everything before the end marker)
        local block_content="${after_start%%$end_marker*}"
        
        # Extract everything after the end marker
        local after_block="${after_start#*$end_marker}"
        
        # Look for indexed items (array_name_0, array_name_1, etc.)
        local replacement=""
        local index=0
        
        # Build the variable name and check if it exists
        local var_name="${array_name}_${index}"
        while [[ -n "${!var_name}" ]]; do
            local item_value="${!var_name}"
            
            # Replace {{this}} with the current item
            local item_replaced="$block_content"
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
            local item_replaced="$block_content"
            item_replaced="${item_replaced//\{\{this\}\}/$item_value}"
            replacement="$item_replaced"
        fi
        
        # Reconstruct the content with the replacement
        content="${before_block}${replacement}${after_block}"
    done
    
    echo "$content"
}