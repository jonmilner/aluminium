echo "Do you wish to open your Applications?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) make install; break;;
        No ) exit;;
    esac
done

# Open Applications
open ../../usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app
open ../../Applications/1Password.app
open ../../Applications/Atom.app
open ../../Applications/Clipy.app
open ../../Applications/Divvy.app
open ../../Applications/Dropbox.app
open ../../Applications/Gitbox.app
open ../../Applications/Github\ Desktop.app
open ../../Applications/Google\ Chrome.app
open ../../Applications/Hyper.app
open ../../Applications/Slack.app
open ../../Applications/Spotify.app