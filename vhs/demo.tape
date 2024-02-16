# Where should we write the GIF?
Output demo.gif

# Setup the shell
Set Shell bash
Set Width 1400
Set Height 600
Set FontSize 20

# Pull docker image
Type 'docker run --pull always --rm -it -v "/${PWD:?}:/work" kristofferahl/baseops-cli:latest init'
Sleep 1s
Enter

Sleep 4s

# Name
Type "glam"
Sleep 2s
Enter

# Description
Sleep 2s
Enter

# Banner
Type "orous"
Sleep 2s
Enter

# Image name
Sleep 2s
Enter

# Image tag
Sleep 2s
Enter

# Image architecture
Sleep 1s
Space
Sleep 1s
Down
Space
Sleep 1s
Enter

# Accept
Sleep 4s
Enter

# Build glam cli
Sleep 4s
Type "./glam baseops build"
Sleep 1s
Enter

Sleep 14s

# Ensure we select the correct architecture for the sample run
Type "clear"
Enter
Sleep 1s
Type "export BASEOPS_FORCE_ARCH=arm64"
Sleep 1s
Enter

# Start glamorous shell
Sleep 1s
Type "./glam shell"
Sleep 1s
Enter

Sleep 8s

# Exit
Type "exit"
Sleep 1s
Enter

Sleep 2s
