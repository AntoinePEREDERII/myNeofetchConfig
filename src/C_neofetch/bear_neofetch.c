#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/sysctl.h>
#include <sys/utsname.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/mount.h>

int main() {
    struct utsname sys_info;
    uname(&sys_info);
    
    char host_name[50];
    gethostname(host_name, sizeof(host_name));
    
    char kernel_version[50];
    size_t len = sizeof(kernel_version);
    sysctlbyname("kern.osrelease", kernel_version, &len, NULL, 0);
    
    char shell_name[50];
    strcpy(shell_name, getenv("SHELL"));
    
    long memory_info;
    size_t mem_info_size = sizeof(memory_info);
    sysctlbyname("hw.memsize", &memory_info, &mem_info_size, NULL, 0);
    double memory_info_gb = memory_info / (1024.0 * 1024 * 1024);
    
    int cpu_cores = sysconf(_SC_NPROCESSORS_ONLN);
    
    char resolution[50] = "3024 x 1964 Retina";  // Vous devrez ajouter la logique pour obtenir la résolution de l'écran

    int gpu_cores = 16;

    struct timeval boottime;
    size_t size = sizeof(boottime);
    if (sysctlbyname("kern.boottime", &boottime, &size, NULL, 0) != 0) {
        printf("Impossible d'obtenir l'heure de démarrage\n");
        return 1;
    }

    time_t uptime = time(NULL) - boottime.tv_sec;
    
    int days = uptime / (60 * 60 * 24);
    int hours = (uptime / (60 * 60)) % 24;
    int minutes = (uptime / 60) % 60;
    int seconds = uptime % 60;


    DIR *dir;
    struct dirent *ent;
    const char *brewFormulaeDir = "/opt/homebrew/Cellar";
    int packageCount = 0;

    if ((dir = opendir(brewFormulaeDir)) != NULL) {
        while ((ent = readdir(dir)) != NULL) {
            if (ent->d_type == DT_DIR && strcmp(ent->d_name, ".") != 0 && strcmp(ent->d_name, "..") != 0) {
                // Compter les répertoires, chaque répertoire correspond à un paquet Homebrew
                packageCount++;
            }
        }
        closedir(dir);
    } else {
        perror("opendir");
        return 1;
    }

    struct statfs stats;
    const char *rootDirectory = "/"; // Répertoire racine

    if (statfs(rootDirectory, &stats) != 0) {
        perror("statfs");
        return 1;
    }

    unsigned long long blockSize = stats.f_bsize;
    unsigned long long freeBlocks = stats.f_bfree;

    unsigned long long diskSpaceBytes = blockSize * freeBlocks;
    double diskSpaceGB = (double)diskSpaceBytes / 1073741824.0; // Convertit en Go

    printf("\n\n     \e[0;31;10m.smNdy+-    `.:/osyyso+:.`    -+ydmNs.        	   \n");
    printf("     \e[0;31;10mmN.     oMdyy- -y          `-dMo     .Nm       \e[1;31mMacbook Pro de Antoine PEREDERII\e[0m\n");
    printf("     \e[0;31;10m.mN+`  sMy hN+ -:             yMs  `+Nm.   	\n");
    printf("     \e[0;31;10m`yMMddMs.dy `+`               sMddMMy`   	    \e[1;32m--------------------------------\e[0m\n");
    printf("     \e[0;31;10m  +MMMo  .`  .                 oMMM+    	\n");
    printf("     \e[0;31;10m  `NM/    `````.`    `.`````    +MN`   	    \e[1;33mSystème d'exploitation : \e[0;28m%s\n", sys_info.sysname);  
    printf("     \e[0;31;10m  yM+   `.-:yhomy    ymohy:-.`   +My     	    \e[1;33mHôte : \e[0;28m%s\n", host_name);    
    printf("     \e[0;31;10m  yM:          yo    oy          :My           \e[1;33mNoyau : \e[0;28m%s\n", kernel_version);  	
    printf("     \e[0;31;10m  +Ms         .N`    `N.      +h sM+           \e[1;33mShell : \e[0;28m%s\n", shell_name);   
    printf("     \e[0;31;10m  `MN      -   -::::::-   : :o:+`NM`           \e[1;33mMémoire totale : \e[0;28m%.2f Go\n", memory_info_gb);       
    printf("     \e[0;31;10m    yM/    sh   -dMMMMd-   ho  +y+My  	    \e[1;33mCœurs du processeur : \e[0;28m%d\n", cpu_cores);    
    printf("     \e[0;31;10m    .dNhsohMh-//: /mm/ ://-yMyoshNd`           \e[1;33mCœurs du GPU : \e[0;28m%d\n", gpu_cores); 
    printf("     \e[0;31;10m      `-ommNMm+:/. oo ./:+mMNmmo:`             \e[1;33mRésolution d'écran : \e[0;28m%s\n", resolution); 
    printf("     \e[0;31;10m    `/o+.-somNh- :yy: -hNmos-.+o/`             \e[1;33mUptime: \e[0;28m%d jours, %d heures, %d minutes, %d secondes\n", days, hours, minutes, seconds);     
    printf("     \e[0;31;10m    ./` .s/`s+sMdd+``+ddMs+s`/s. `/.           \e[1;33mNombre de paquets Homebrew : \e[0;28m%d\n", packageCount);
    printf("     \e[0;31;10m        : -y.  -hNmddmNy.  .y- :               \e[1;33mEspace disque disponible : \e[0;28m%.2f Go\n", diskSpaceGB);
    printf("     \e[0;31;10m        -+       `..`       +-      \n\n\n");

    return 0;
}