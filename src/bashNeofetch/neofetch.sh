#!/bin/sh

# Obtention de l'OS
OS=$(uname -s)

# Obtention du nom d'hote
hote=$(hostname)

# Obtention du noyau
noyau=$(uname -r)

# Obtention du shell
term=$SHELL

# Obtenir des informations sur la mémoire disponible sur macOS
memory_info=$(sysctl -n hw.memsize)
memory_info_mb=$((memory_info / 1024 / 1024 / 1024))

# Obtenir le nombre de cœurs du processeur
cpu_cores=$(nproc)

# Obtenir le nombre de cœurs du GPU sur macOS
gpu_cores=$(system_profiler SPDisplaysDataType | grep "Number of Cores" | sed -e 's/^[ \tTotal Number of Cores:]*//')

# Résolution de l'écran
resolution=$(system_profiler SPDisplaysDataType | grep 'Resolution' | sed -e 's/^[ \tResolution:]*//')

# Obtenir la durée d'alumage
uptime=$(uptime | cut -d " " -f 1)
uptimeHour=$(echo "$uptime" | cut -d ":" -f 1)
uptimeMin=$(echo $uptime | cut -d ":" -f 2)

# Obtenir le nombre de paquets Homebrew installés
brew_packages=$(brew list | wc -l | tr -d ' ')

# Obtenir l'espace disque disponible sur la partition racine
disk_space=$(df -h / | awk 'NR==2 {print $4}')


ASCII=${1}


case $ASCII in
  "GNU"*)
    printf "\e[0m\n\t    _-\`\`\`\`\`-,           ,- \'- .        \e[1;31mMacbook Pro de Antoine PEREDERII\e[0m\n"
    printf "\e[1;28m\t  .'   .- - |          | - -.  \`.      \n"
    printf "\t /.'  /                     \`.   \     \e[1;32m--------------------------------\e[0m\n"
    printf "\t:/   :      _...   ..._      \`\`   :   \n"
    printf "\t::   :     /._ .\`:'_.._\.    ||   :    \e[1;33mSystème d'exploitation : \e[0;28m$OS\n"
    printf "\t::    \`\.\_ ./  ,\`  :    \ . _.'' .    \e[1;33mHôte : \e[0;28m$hote\n"
    printf "\t\`:.      /   \|  -.  \-. \\_      /     \e[1;33mNoyau : \e[0;28m$noyau\n"
    printf "\t  \:._ _/  .'   .@)  \@) \` \`\ ,.'      \e[1;33mShell : \e[0;28m$term\n"
    printf "\t     _/,--'       .- .\,-.\`--\`.        \e[1;33mMémoire totale : \e[0;28m${memory_info_mb} Go\n"
    printf "\t       ,'/''     (( \ \`  )             \e[1;33mCœurs du processeur : \e[0;28m$cpu_cores\n"
    printf "\t        /'/'  \    \`-'  (              \e[1;33mCœurs du GPU : \e[0;28m$gpu_cores\n"
    printf "\t         '/''  \`\._,-----'             \e[1;33mRésolution d'écran : \e[0;28m$resolution\n"
    printf "\t          ''/'    .,---'               \e[1;33mUptime : \e[0;28mdepuis $uptimeHour heures et $uptimeMin min\n"
    printf "\t           ''/'      ;:                \e[1;33mNombre de paquets Homebrew : \e[0;28m$brew_packages\n"
    printf "\t             ''/''  ''/                \e[1;33mEspace disque disponible : \e[0;28m$disk_space\n"
    printf "\t               ''/''/''                \n"
    printf "\t                 '/'/'                 \n"
    printf "\t                  \`;\n\n"

            ;;

  "Windows"*)

    printf "\n\e[1;31m        ,.=:!!t3Z3z.,                     \e[1;31mMacbook Pro de Antoine PEREDERII\e[0m\n"
    printf "\e[1;31m       :tt:::tt333EE3\n"
    printf "\e[1;31m       Et:::ztt33EEEL\e[1;32m @Ee.,      ..,      \e[1;32m--------------------------------\e[0m\n"
    printf "\e[1;31m      ;tt:::tt333EE7\e[1;32m ;EEEEEEttttt33#\n"
    printf "\e[1;31m     :Et:::zt333EEQ.\e[1;32m \$EEEEEttttt33QL      \e[1;33mSystème d'exploitation : \e[0;28m$OS\n"
    printf "\e[1;31m     it::::tt333EEF\e[1;32m @EEEEEEttttt33F       \e[1;33mHôte : \e[0;28m$hote\n"
    printf "\e[1;31m    ;3=*^\`\`\`\"*4EEV\e[1;32m :EEEEEEttttt33@.       \e[1;33mNoyau : \e[0;28m$noyau\n"
    printf "\e[0;34m    ,.=::::!t=., \e[1;31m\`\e[1;32m @EEEEEEtttz33QF        \e[1;33mShell : \e[0;28m$term\n"
    printf "\e[0;34m   ;::::::::zt33)\e[1;32m   \"4EEEtttji3P*         \e[1;33mMémoire totale : \e[0;28m${memory_info_mb} Go\n"
    printf "\e[0;34m  :t::::::::tt33.\e[1;33m:Z3z..\e[1;32m  \`\`\e[1;33m ,..g.         \e[1;33mCœurs du processeur : \e[0;28m$cpu_cores\n"
    printf "\e[0;34m  i::::::::zt33F\e[1;33m AEEEtttt::::ztF          \e[1;33mCœurs du GPU : \e[0;28m$gpu_cores\n"
    printf "\e[0;34m ;:::::::::t33V\e[1;33m ;EEEttttt::::t3           \e[1;33mRésolution d'écran : \e[0;28m$resolution\n"
    printf "\e[0;34m E::::::::zt33L\e[1;33m @EEEtttt::::z3F           \e[1;33mUptime : \e[0;28mdepuis $uptimeHour heures et $uptimeMin min\n"
    printf "\e[0;34m{3=*^\`\`\`\"*4E3)\e[1;33m ;EEEtttt:::::tZ\`           \e[1;33mNombre de paquets Homebrew : \e[0;28m$brew_packages\n"
    printf "\e[0;34m             \`\e[1;33m :EEEEtttt::::z7            \e[1;33mEspace disque disponible : \e[0;28m$disk_space\n"
    printf "                \e[1;33m\"VEzjt:;;z>*\`\n\n"

            ;;

esac
