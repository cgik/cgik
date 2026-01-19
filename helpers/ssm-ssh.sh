function ssm-ssh {
    local STORE_FILE="$HOME/.ssh_instances"
    touch "$STORE_FILE"

    usage() {
        echo "Usage:"
        echo "  ssm-ssh --add <name> <profile> <instance-id>   # Add a new SSH entry"
        echo "  ssm-ssh --list                                 # List all SSH entries"
        echo "  ssm-ssh --rm <name>                            # Remove an SSH entry"
        echo "  ssm-ssh <name>                                 # Connect to the instance via SSH"
        echo "  ssm-ssh --profile <profile> <instance-id>      # Connect using specified profile and instance ID"
    }

    case "$1" in
        --add)
        echo "$2|$3|$4" >> "$STORE_FILE"
        echo "Saved '$2' successfully."
        ;;
        --list)
        echo "Saved Instances:"
        column -t -s '|' "$STORE_FILE" | sed 's/^/  /'
        ;;
        --rm)
        sed -i.bak "/^$2|/d" "$STORE_FILE"
        echo "Removed '$2'."
        ;;
        --profile)
        _ssm_connect "$2" "$3"
        ;;
        --help|-h)
        usage
        ;;
        *)
        if [ -z "$1" ]; then usage; return; fi
        
        DATA=$(grep "^$1|" "$STORE_FILE")
        if [ -n "$DATA" ]; then
            PROFILE=$(echo "$DATA" | cut -d'|' -f2)
            ID=$(echo "$DATA" | cut -d'|' -f3)
            _ssm_connect "$PROFILE" "$ID"
        else
            echo "Error: Shortcut '$1' not found."
            usage
        fi
        ;;
    esac
}

function _ssm_connect() {
    local PROF="$1"
    local TARGET="$2"

    echo "Connecting to $TARGET using profile $PROF..."
    aws ssm start-session --profile "$PROF" --target "$TARGET"

    if [ $? -ne 0 ]; then
        echo "Session failed. Attempting SSO login..."
        aws sso login --profile "$PROF"
        aws ssm start-session --profile "$PROF" --target "$TARGET"
    fi
}
