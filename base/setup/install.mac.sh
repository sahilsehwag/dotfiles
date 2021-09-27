/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

! type git            &> /dev/null && brew install git
! type fd             &> /dev/null && brew install fd
! type fasd           &> /dev/null && brew install fasd
! type curl           &> /dev/null && brew install curl
! type wget           &> /dev/null && brew install wget
! type ag             &> /dev/null && brew install ag
! type ack            &> /dev/null && brew install ack
! type tree           &> /dev/null && brew install tree
! type highlight      &> /dev/null && brew install highlight
! type exa            &> /dev/null && brew install exa
! type dos2unix       &> /dev/null && brew install dos2unix
! type readline       &> /dev/null && brew install readline
! type pandoc         &> /dev/null && brew install pandoc
! type ctags          &> /dev/null && brew install universal-ctags
! type sed            &> /dev/null && brew install gnu-sed
! type path-extractor &> /dev/null && brew install path-extractor

! type cmake &> /dev/null && brew install cmake
! type gcc   &> /dev/null && brew install gcc

#! type reattach-to-user-namespace &> /dev/null && brew install reattach-to-user-namespace
#! type jq                         &> /dev/null && brew install jq
#! type htop                       &> /dev/null && brew install htop
#! type cheat                      &> /dev/null && brew install cheat
#! type fuck                       &> /dev/null && brew install thefuck

brew list google-chrome || brew install google-chrome
brew list google-backup-and-sync || brew install google-backup-and-sync
brew list dash || brew install dash
brew list alfred || brew install alfred
brew list vlc || brew install vlc
brew list keycastr || brew install keycastr
#brew list visual-studio-code || brew install visual-studio-code
