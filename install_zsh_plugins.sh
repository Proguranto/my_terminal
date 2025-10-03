#!/bin/bash

# Oh My Zsh Plugins Installation Script
# Installs: fast-syntax-highlighting, zsh-autosuggestions, zsh-autocomplete

set -e  # Exit on any error

echo "Installing Oh My Zsh plugins..."

# Define oh-my-zsh custom plugins directory
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
PLUGINS_DIR="$ZSH_CUSTOM/plugins"

# Create plugins directory if it doesn't exist
mkdir -p "$PLUGINS_DIR"

# Install fast-syntax-highlighting
echo "Installing fast-syntax-highlighting..."
if [ ! -d "$PLUGINS_DIR/fast-syntax-highlighting" ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$PLUGINS_DIR/fast-syntax-highlighting"
    echo "✓ fast-syntax-highlighting installed"
else
    echo "✓ fast-syntax-highlighting already exists"
fi

# Install zsh-autosuggestions
echo "Installing zsh-autosuggestions..."
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGINS_DIR/zsh-autosuggestions"
    echo "✓ zsh-autosuggestions installed"
else
    echo "✓ zsh-autosuggestions already exists"
fi

# Install zsh-autocomplete
echo "Installing zsh-autocomplete..."
if [ ! -d "$PLUGINS_DIR/zsh-autocomplete" ]; then
    git clone https://github.com/marlonrichert/zsh-autocomplete.git "$PLUGINS_DIR/zsh-autocomplete"
    echo "✓ zsh-autocomplete installed"
else
    echo "✓ zsh-autocomplete already exists"
fi

# Update .zshrc with plugins
ZSHRC="$HOME/.zshrc"

echo "Configuring plugins in .zshrc..."

# Backup .zshrc
if [ -f "$ZSHRC" ]; then
    cp "$ZSHRC" "$ZSHRC.backup.$(date +%Y%m%d_%H%M%S)"
    echo "✓ .zshrc backed up"
fi

# Check if plugins line exists and update it
if grep -q "^plugins=" "$ZSHRC" 2>/dev/null; then
    # Get current plugins (remove parentheses and split by whitespace)
    current_plugins=$(grep "^plugins=" "$ZSHRC" | sed 's/plugins=(//' | sed 's/)//' | tr '\n' ' ')
    
    # Add new plugins if they don't exist
    new_plugins="$current_plugins"
    
    if [[ ! "$current_plugins" =~ "fast-syntax-highlighting" ]]; then
        new_plugins="$new_plugins fast-syntax-highlighting"
    fi
    
    if [[ ! "$current_plugins" =~ "zsh-autosuggestions" ]]; then
        new_plugins="$new_plugins zsh-autosuggestions"
    fi
    
    if [[ ! "$current_plugins" =~ "zsh-autocomplete" ]]; then
        new_plugins="$new_plugins zsh-autocomplete"
    fi
    
    # Clean up extra spaces and format
    new_plugins=$(echo "$new_plugins" | xargs)
    
    # Replace the plugins line
    sed -i.tmp "s/^plugins=(.*/plugins=($new_plugins)/" "$ZSHRC"
    rm "$ZSHRC.tmp"
    
    echo "✓ Updated existing plugins line in .zshrc"
else
    # Add plugins line if it doesn't exist
    echo "" >> "$ZSHRC"
    echo "# Plugins" >> "$ZSHRC"
    echo "plugins=(git fast-syntax-highlighting zsh-autosuggestions zsh-autocomplete)" >> "$ZSHRC"
    echo "✓ Added plugins line to .zshrc"
fi

echo ""
echo "🎉 All plugins installed successfully!"
echo ""
echo "Installed plugins:"
echo "  • fast-syntax-highlighting - Syntax highlighting for commands"
echo "  • zsh-autosuggestions - Fish-like autosuggestions" 
echo "  • zsh-autocomplete - Real-time type-ahead completion"
echo ""
echo "To activate the plugins, either:"
echo "  1. Restart your terminal, or"
echo "  2. Run: source ~/.zshrc"
echo ""
echo "Your original .zshrc has been backed up with a timestamp."
